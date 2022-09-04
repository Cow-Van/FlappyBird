import java.util.HashMap;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.ListIterator;

public class Game {
  private final HashMap<String, ArrayList<Sprite>> sprites = new HashMap();
  private final float playerMaxVelocityY = 5;
  private final float playerAccelerationY = 0.2;
  private final int playerJumpCooldown = 15;
  private final int pipeCooldown = 80;
  private final int pipeVelocityX = -3;
  private final int minPipeDistance = 125;
  private final int maxPipeDistance = 300;
  
  private float playerVelocityY = 0;
  private int playerLastJump = 0;
  private int lastPipe = 0;
  
  public Game() {
    sprites.put("player", new ArrayList(Arrays.asList(new Bird(75, 250))));
    sprites.put("pipes", new ArrayList());
  }
  
  public Status update() {
    Bird player = (Bird) sprites.get("player").get(0);
    
    if (player.getY() <= 0 || player.getY() + player.getHeight() >= height) {
      return Status.GAME_OVER;
    }
    
    for (Sprite sprite : sprites.get("pipes")) {
      Pipe pipe = (Pipe) sprite;
      if (checkCollision(player, pipe)) {
        return Status.GAME_OVER;
      }
    }
    
    lastPipe++;
    
    if (lastPipe >= pipeCooldown) {
      float topPipeHeight = (float) (Math.random() * (width/2d - 50) + 50);
      float bottomPipeHeight = Math.min(topPipeHeight + ((float) (Math.random() * (maxPipeDistance - minPipeDistance) + minPipeDistance)), height - 50);
      
      sprites.get("pipes").add(new Pipe(500, topPipeHeight, 60, 500, true));
      sprites.get("pipes").add(new Pipe(500, bottomPipeHeight, 60, 500, false));
      
      lastPipe = 0;
    }
    
    ListIterator<Sprite> pipesIterator = sprites.get("pipes").listIterator();
    
    while (pipesIterator.hasNext()) {
      Pipe pipe = (Pipe) pipesIterator.next();
      pipe.setPosition(pipe.getX() + pipeVelocityX, pipe.getY());
      
      if (pipe.getX() < -100) {
        sprites.get("pipes").remove(pipe);
        pipesIterator = sprites.get("pipes").listIterator(pipesIterator.previousIndex());
      }
    }
    
    
    playerLastJump++;
    
    if (playerVelocityY + playerAccelerationY <= playerMaxVelocityY) {
      playerVelocityY += playerAccelerationY;
    }
    
    player.setPosition(player.getX(), player.getY() + playerVelocityY);
    
    
    draw();
    
    return Status.PLAY;
  }
  
  public void draw() {
    background(#87ceeb);
    for (ArrayList<Sprite> spriteList : sprites.values()) {
      for (Sprite sprite : spriteList) {
        sprite.draw();
      }
    }
  }
  
  public void jump() {
    if (playerLastJump > playerJumpCooldown) {
      playerVelocityY = -5;
      playerLastJump = 0;
    }
  }
  
  private boolean checkCollision(IBoundingBox box1, IBoundingBox box2) {
    return box1.getX() + box1.getWidth() >= box2.getX() && box1.getX() <= box2.getX() + box2.getWidth() && box1.getY() + box1.getHeight() >= box2.getY() && box1.getY() <= box2.getY() + box2.getHeight();
  }
}
