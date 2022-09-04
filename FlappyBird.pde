import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
Game game;

public void setup() {
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  
  size(500, 500);
  noStroke();
  
  game = new Game();
}

public void draw() {
  game.update();
}

void keyPressed() {
  if (key == ' ') {
    game.jump();
  }
}
