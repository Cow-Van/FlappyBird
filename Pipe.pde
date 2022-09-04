public class Pipe extends Sprite implements IBoundingBox {
  private final float pipeWidth;
  private final float pipeHeight;
  
  private final PShape pipe;
  
  public Pipe(float x, float y, float pipeWidth, float pipeHeight, boolean isTop) {
    super(x, (isTop) ? y -= pipeHeight : y);
    
    this.pipeWidth = pipeWidth;
    this.pipeHeight = pipeHeight;
    
    pipe = createShape(GROUP);
    fill(#8AC048);
    pipe.addChild(createShape(RECT, 0, 0, pipeWidth, pipeHeight));
  }
  
  @Override
  public void draw() {
    pushMatrix();
    translate(x, y);
    shape(pipe);
    popMatrix();
  }
  
  @Override
  public float getWidth() {
    return pipeWidth;
  }
  
  @Override
  public float getHeight() {
    return pipeHeight;
  }
}
