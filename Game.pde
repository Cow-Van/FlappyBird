import java.util.HashMap;

public class Game {
  private final HashMap<String, Sprite> sprites = new HashMap();
  
  public Game() {
    sprites.put("player", new Bird(100, 100));
  }
  
  public void update() {
    draw();
  }
  
  public void draw() {
    for (Sprite sprite : sprites.values()) {
      sprite.draw();
    }
  }
}
