import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
Game game;

public void setup() {
  arduino = new Arduino(this, Arduino.list()[1], 57600);
  
  size(500, 500);
  noStroke();
  
  game = new Game();
}

public void draw() {
  if (arduino.analogRead(1) == 1023 || arduino.analogRead(6) == 1023) {
    game.jump();
  }
  
  game.update();
}
