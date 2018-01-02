#include <Basecamp.hpp>

Basecamp iot;
static const int MaxCommands = 4;
char *commands[MaxCommands], *shortCommands[MaxCommands] = {
  "close", 
  "openPercent", 
  "configure/spcm", 
  "configure/maximumPosition"};

float spcm = 78.0*32;                    // Number of steps per centimeter. Depends on printed parts and the tension of the rope.
float target_p = 0.0;                    // Position of the curtain in percent. 0 means closed 100 means opened.
float max_p = 70.0;                      // Maximum position of your curtain. Please measure this correctly!
const char* curtainName = "WlanGardine"; // Name of this device for MQTT.
static const int MaxBufferSize = 64;     // Increase this if you set a very long curtainName.

void setup() {
  Serial.begin(115200);
  //xTaskCreatePinnedToCore(motorTask, "motorTask", 4096, (void*) &target_p, 0, NULL, 0);
  //Serial.println("Creating the network task...\n");
  //xTaskCreatePinnedToCore(networkTask, "networkTask", 10000, (void*) &iot, 0, NULL, 0);
  //Serial.println("Network task created...");
  networkTask(&iot);
}

void initializeCommandsList(int MaxCommands) {
  for(int i=0; i < MaxCommands; i++) {
    char buf[MaxBufferSize];
    sprintf(buf, "%s/%s", curtainName, shortCommands[i]);
    commands[i] = (char*) malloc(strlen(buf)+1);
    strcpy(commands[i], buf);
  }
}

void networkTask(void* iot_) {
  //Basecamp iot = *((Basecamp*) iot_);
  initializeCommandsList(MaxCommands);
  Serial.println("Initialized MQTT command strings...");
  iot.begin();
  Serial.println("Initialized Basecamp...");
  iot.mqtt.onMessage(onMqttMessage);
  iot.mqtt.onConnect(onMqttConnect);
  iot.web.addInterfaceElement("spcm", "input", "Steps per cm:", "#configform", "spcm");
  iot.web.addInterfaceElement("maxPos", "input", "Travel distance vor a open curtain in cm:", "#configform", "max_p");
  char printBuf[MaxBufferSize];
  sprintf(printBuf, "%f", spcm);
  setSpcm(printBuf);
}

void setSpcm(char* newSpcm) {
  iot.configuration.set("spcm", newSpcm);
  //iot.configuration.save();
  char buf[MaxBufferSize];
  iot.configuration.get("spcm").toCharArray(buf, sizeof(buf));
  spcm = atof(buf);
}

void setMaxPos(char* newMaxPos) {
  iot.configuration.set("maxPos", newMaxPos);
  //iot.configuration.save();
  char buf[MaxBufferSize];
  iot.configuration.get("maxPos").toCharArray(buf, sizeof(buf));
  max_p = atof(buf);
}

void onMqttConnect(bool sessionPresent) {
  for(int i=0; i < MaxCommands; i++) {
    iot.mqtt.subscribe(commands[i], 0);
    Serial.printf("MQTT topic subscribed: %s\n", commands[i]);
  }
}

int cmdToInt(char* cmd) {
  for(int i=0; i < MaxCommands; i++) {
    if(strcmp(cmd, commands[i]) == 0) return i;
  }
}

void onMqttMessage(
  char* topic, char* payload,
  AsyncMqttClientMessageProperties properties,
  size_t len, size_t index, size_t total) {
    Serial.printf("MQTT message at %s: %s.\n", topic, payload);
    switch(cmdToInt(topic)) {
      case 0:
        //homeCurtain();
        break;
      case 1:
        target_p = fmax(0, fmin(100, atof(payload)));
        Serial.printf("Setting target position to %f%%.\n", target_p);
        break;
      case 2:
        setSpcm(payload);
        break;
      case 3:
        setMaxPos(payload);
        break;
    }                
}

void homeCurtain(bool &stopAtEndstop, float &target_p) {
  stopAtEndstop = true;
  target_p = -110;
}

float doSteps(int speedDelay, float currPos, float targetPos, unsigned long &last_flank, 
              int &stepPin, int &dirPin, int &sleepPin, int &enablePin) {
  digitalWrite(enablePin, LOW);
  digitalWrite(sleepPin, HIGH);
  digitalWrite(dirPin, currPos + 1/spcm <= targetPos);
  while(abs(currPos - targetPos) >= 1/spcm) {
    while(micros() - last_flank < speedDelay) {}
    if(currPos + 1/spcm <= targetPos) {
      digitalWrite(stepPin, HIGH);
      last_flank = micros();
      currPos += 1/spcm;
    }
    if(currPos - 1/spcm >= targetPos) {
      digitalWrite(stepPin, HIGH);
      last_flank = micros();
      currPos -= 1/spcm;
    }
    while(micros() - last_flank < speedDelay) {}
    digitalWrite(stepPin, LOW);
    last_flank = micros();
  }
  return currPos;
}

void stopMotor(float &v, float &a, int &enablePin, int &sleepPin) {
  digitalWrite(enablePin, HIGH); // Enable is inverted. HIGH means the motor is disabled.
  digitalWrite(sleepPin, LOW);   // Sleep is inverted. LOW means the driver sleeps.
  v = 0;
  a = 0;
}

void motorTask(/*void* t_p*/) {
  int stepPin = 16;
  int dirPin = 17;
  int enablePin = 18;
  int sleepPin = 19;
  int endstopPin = 34;
  bool stopAtEndstop = false;
  //float target_p = *((float*) t_p);
  float dt = 1.0;
  float p = 0.0;
  float p_ = 0.0;
  float v, a = 0.0;
  float vmax = 8.0;
  float amax = 5.0;
  unsigned long now = 0;
  unsigned long last_time = micros();
  unsigned long last_flank = 0;
  pinMode(stepPin, OUTPUT);
  pinMode(dirPin, OUTPUT);
  pinMode(enablePin, OUTPUT);
  pinMode(sleepPin, OUTPUT);
  pinMode(endstopPin, INPUT);
  digitalWrite(dirPin, LOW);
  digitalWrite(stepPin, LOW);
  stopMotor(v, a, enablePin, sleepPin);
  homeCurtain(stopAtEndstop, target_p);
  int i = 0;
  while(true) {
    if(i++%10000 == 0) Serial.printf("tp: %f | p: %f | p_: %f | v: %f | a: %f | dt: %f | vmax: %f\n", target_p/100*max_p, p, p_, v, a, dt, vmax);
    now = micros();
    //if(i%1 == 0) Serial.printf("now: %lu | last_time: %lu\n", now, last_time);
    dt = (float) (now - last_time);
    p_ += 1e-6 * v * dt;
    vmax = 1 + ((p_ > 0.5*(v-1)*(v-1)/amax) ? 7 : 0);
    a = 0;
    float tp = target_p/100*max_p;
    if(((abs(v) < vmax) && (abs(tp - p_) > 0.9 * v * v / amax))) {
      a = ((tp > p_) ? 1 : -1) * amax;
    }
    if(v < 0) {
      if((abs(v) > vmax) || 
         (p_-tp < 0.5 * v * v / amax) || 
         (tp > p_)) {
        a = amax;
      }
    } else {
      if((abs(v) > vmax) || 
         (tp-p_ < 0.5 * v * v / amax) || 
         (tp < p_)) {
        a = -amax;
      }
    }
    v += 1e-6 * a * dt;
    //while(micros() - last_time < 16) {}
    if(stopAtEndstop && digitalRead(endstopPin)) { // Endstop triggered.
      stopMotor(v, a, enablePin, sleepPin);
      p = 0;
      p_ = 0;
      target_p = 0;
      stopAtEndstop = false;
      char msgTopic[MaxBufferSize];
      sprintf(msgTopic, "%s/status", curtainName);
      iot.mqtt.publish(msgTopic, 1, true, "closed");
    }
    if(abs(target_p/100*max_p - p) <= 1.1/spcm) {  // We are at the target position. Stop the motor.
      stopMotor(v, a, enablePin, sleepPin);
      char msgBody[MaxBufferSize], msgTopic[MaxBufferSize];
      sprintf(msgTopic, "%s/status", curtainName);
      sprintf(msgBody, "open at %d%%", target_p);
      iot.mqtt.publish(msgTopic, 1, true, msgBody);
    } else {
      p = doSteps(8, p, p_, last_flank, stepPin, dirPin, sleepPin, enablePin);
    }
    last_time = now;
  }
  Serial.println("This should never be reached!");
}

void loop() {
  motorTask(/*&target_p*/);  
}
