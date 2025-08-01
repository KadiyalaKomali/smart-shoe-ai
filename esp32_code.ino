#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <BluetoothSerial.h>
#include <NewPing.h>

#define TRIGGER_PIN 12
#define ECHO_PIN 13
#define MAX_DISTANCE 200

BluetoothSerial SerialBT;
NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);

void setup() {
  Serial.begin(115200);
  SerialBT.begin("SmartShoeESP32");
  pinMode(TRIGGER_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
}

void loop() {
  delay(100);
  int distance = sonar.ping_cm();
  if (distance > 0 && distance < 100) {
    SerialBT.println("Obstacle at " + String(distance) + " cm");
  }
}