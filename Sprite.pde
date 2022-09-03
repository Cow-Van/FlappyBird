public abstract class Sprite implements Drawable {
  protected float x;
  protected float y;
  
  protected Sprite(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  @Override
  public void setPosition(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  @Override
  public float getX() {
    return x;
  }
  
  @Override
  public float getY() {
    return y;
  }
}
