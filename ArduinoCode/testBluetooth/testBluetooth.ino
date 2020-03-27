
byte receivedData;

void setup() {
  Serial.begin(9600);
   

}

void loop() {
  if(Serial.available() >0){
    receivedData = Serial.read();
    if(receivedData == 48){
      for(int i = 65; i<= 90; i++){
        Serial.print((char)i);
        delay(50);
        
      }
    }
  }
delay(200);
}
