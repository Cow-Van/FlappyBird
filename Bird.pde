public class Bird extends Sprite {
  private final PShape bird;
  
  Bird(float x, float y) {
    super(x, y);
    
    bird = createShape(GROUP);
    fill(#ECDF05);
    bird.addChild(createShape(ELLIPSE, x, y, 60, 50));
  }
  
  @Override
  public void draw() {
    pushMatrix();
    translate(x, y);
    shape(bird);
    popMatrix();
  }
}
