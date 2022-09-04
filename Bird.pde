public class Bird extends Sprite implements IBoundingBox {
  private final float birdWidth = 60f;
  private final float birdHeight = 50f;
  
  private final PShape bird;
  
  Bird(float x, float y) {
    super(x, y);
    
    bird = createShape(GROUP);
    fill(#ECDF05);
    //bird.addChild(createShape(RECT, 0, 0, birdWidth, birdHeight));
    bird.addChild(createShape(ELLIPSE, birdWidth / 2, birdHeight / 2, birdWidth, birdHeight));
  }
  
  @Override
  public void draw() {
    pushMatrix();
    translate(x, y);
    shape(bird);
    popMatrix();
  }
  
  @Override
  public float getWidth() {
    return birdWidth;
  }
  
  @Override
  public float getHeight() {
    return birdHeight;
  }
}
