import java.util.HashMap;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.ListIterator;
import java.util.AbstractMap.SimpleEntry;

public class Game {
  private final HashMap<String, ArrayList> sprites = new HashMap();
  private final ArrayList<SimpleEntry<Pipe, Pipe>> pastPipes = new ArrayList();
  private final float playerMaxVelocityY = 5;
  private final float playerAccelerationY = 0.2;
  private final int playerJumpCooldown = 15;
  private final int pipeCooldown = 80;
  private final int pipeVelocityX = -3;
  private final int minPipeDistance = 125;
  private final int maxPipeDistance = 300;
  
  private Status status = Status.NOT_STARTED;
  private int playerLastJump = pipeCooldown;
  private float playerVelocityY = 0;
  private int lastPipe = 0;
  private int score = 0;
  
  public Game() {
    sprites.put("player", new ArrayList(Arrays.asList(new Bird(75, 250))));
    sprites.put("pipes", new ArrayList());
    
    draw();
  }
  
  public void update() {
    if (status != Status.PLAY) {
      return;
    }
    
    Bird player = (Bird) sprites.get("player").get(0);
    
    if (player.getY() <= 0 || player.getY() + player.getHeight() >= height) {
      status = Status.GAME_OVER;
      return;
    }
    
    for (Object obj : sprites.get("pipes")) {
      SimpleEntry<Pipe, Pipe> pipeEntry = (SimpleEntry<Pipe, Pipe>) obj;
      Pipe topPipe = pipeEntry.getKey();
      Pipe bottomPipe = pipeEntry.getValue();
      
      if (checkCollision(player, topPipe) || checkCollision(player, bottomPipe)) {
        status = Status.GAME_OVER;
        return;
      }
    }
    
    // TODO: Check if player passed a pipe
    for (Object obj : sprites.get("pipes")) {
      SimpleEntry<Pipe, Pipe> pipes = (SimpleEntry<Pipe, Pipe>) obj;
      
      if (pastPipes.contains(pipes)) {
        continue;
      }
      
      Pipe topPipe = pipes.getKey();
      Pipe bottomPipe = pipes.getValue();
      float x = topPipe.getX();
      float y = topPipe.getY() + topPipe.getHeight();
      float pipeWidth = topPipe.getWidth();
      float pipeHeight = bottomPipe.getY() - y;
      
      if (x + pipeWidth >= player.getX() && x <= player.getX() + player.getWidth() && y + pipeHeight >= player.getY() && y <= player.getY() + player.getHeight()) {
        score++;
        
        pastPipes.add(pipes);
      }
    }
    
    lastPipe++;
    
    if (lastPipe >= pipeCooldown) {
      float topPipeHeight = (float) (Math.random() * (width/2d - 50) + 50);
      float bottomPipeHeight = Math.min(topPipeHeight + ((float) (Math.random() * (maxPipeDistance - minPipeDistance) + minPipeDistance)), height - 50);
      
      sprites.get("pipes").add(new SimpleEntry(new Pipe(500, topPipeHeight, 60, 500, true), new Pipe(500, bottomPipeHeight, 60, 500, false)));
      
      lastPipe = 0;
    }
    
    ListIterator<SimpleEntry<Pipe, Pipe>> pipesIterator = sprites.get("pipes").listIterator();
    
    while (pipesIterator.hasNext()) {
      SimpleEntry<Pipe, Pipe> pipeEntry = pipesIterator.next();
      Pipe topPipe = pipeEntry.getKey();
      Pipe bottomPipe = pipeEntry.getValue();
      
      topPipe.setPosition(topPipe.getX() + pipeVelocityX, topPipe.getY());
      bottomPipe.setPosition(bottomPipe.getX() + pipeVelocityX, bottomPipe.getY());
      
      if (topPipe.getX() < -100 && bottomPipe.getX() < -100) {
        sprites.get("pipes").remove(pipeEntry);
        pastPipes.remove(pipeEntry);
        pipesIterator = sprites.get("pipes").listIterator(pipesIterator.previousIndex());
      }
    }
    
    
    playerLastJump++;
    
    if (playerVelocityY + playerAccelerationY <= playerMaxVelocityY) {
      playerVelocityY += playerAccelerationY;
    }
    
    player.setPosition(player.getX(), player.getY() + playerVelocityY);
    
    
    draw();
  }
  
  public void draw() {
    background(#87ceeb);
    
    for (Object obj : sprites.get("player")) {
      ((Sprite) obj).draw();
    }
    
    for (Object obj : sprites.get("pipes")) {
      SimpleEntry<Pipe, Pipe> pipeEntry = (SimpleEntry<Pipe, Pipe>) obj;
      pipeEntry.getKey().draw();
      pipeEntry.getValue().draw();
    }
    
    fill(#FFFFFF);
    textSize(40);
    text(score, width / 2, 50);
  }
  
  public void jump() {
    if (status == Status.NOT_STARTED) {
      status = Status.PLAY;
    }
    
    if (playerLastJump > playerJumpCooldown) {
      playerVelocityY = -5;
      playerLastJump = 0;
    }
  }
  
  public Status getStatus() {
    return status;
  }
  
  private boolean checkCollision(IBoundingBox box1, IBoundingBox box2) {
    return box1.getX() + box1.getWidth() >= box2.getX() && box1.getX() <= box2.getX() + box2.getWidth() && box1.getY() + box1.getHeight() >= box2.getY() && box1.getY() <= box2.getY() + box2.getHeight();
  }
}
