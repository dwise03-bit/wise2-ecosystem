#include <WiFi.h>
#include <WebServer.h>

const char* ssid = "YOUR_SSID";
const char* password = "YOUR_PASSWORD";

WebServer server(80);

// GPIO pins
const int LED1 = 5;
const int LED2 = 18;

void setup() {
  Serial.begin(115200);
  
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  
  WiFi.begin(ssid, password);
  
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  
  Serial.println("\nWiFi connected");
  Serial.println(WiFi.localIP());
  
  // Routes
  server.on("/", handleRoot);
  server.on("/api/data", handleData);
  server.on("/api/status", handleStatus);
  server.on("/api/toggle/led1", handleToggleLED1);
  server.on("/api/toggle/led2", handleToggleLED2);
  
  server.begin();
}

void loop() {
  server.handleClient();
}

void handleRoot() {
  // Serve index.html
  server.send(200, "text/html", "ESP32 WISE² Dashboard");
}

void handleData() {
  String json = "{\"temp\":\"25.5\",\"humidity\":\"60\",\"pressure\":\"1013.25\"}";
  server.send(200, "application/json", json);
}

void handleStatus() {
  bool led1 = digitalRead(LED1);
  bool led2 = digitalRead(LED2);
  String json = "{\"led1\":" + String(led1 ? "true" : "false") + 
                ",\"led2\":" + String(led2 ? "true" : "false") + "}";
  server.send(200, "application/json", json);
}

void handleToggleLED1() {
  digitalWrite(LED1, !digitalRead(LED1));
  server.send(200, "application/json", "{\"status\":\"ok\"}");
}

void handleToggleLED2() {
  digitalWrite(LED2, !digitalRead(LED2));
  server.send(200, "application/json", "{\"status\":\"ok\"}");
}
