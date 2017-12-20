import processing.core.PApplet;

/****
 * Class SnakeBlock represents a single block in the snake
 ****/

public class SnakeBlock
{
  ////////////FIELDS////////////////
  protected PApplet p; //the PApplet from SnakeGame
  public static final int SIZE = 20; //the size of the block
  protected int x; //the x value of the block
  protected int y; //the y value of the block


  ///////////CONSTRUCTOR////////////
  /**
   *Constructor for class SnakeBlock
   */
  public SnakeBlock() {
  }

  /**
   * Constructor 2 for class SnakeBlock
   * @param p the PApplet from SnakeGame
   * @param x the x position of the block
   * @param y the y position of the block
   */
  public SnakeBlock(PApplet p, int x, int y)
  {
    this.p = p;
    this.x = x;
    this.y = y;
  }

  /////////////METHODS///////////////

  /**
   * Method display displays a green block
   */
  public void display()
  {
    p.rectMode(p.CENTER);
    p.fill(50, 205, 50);
    p.strokeWeight(1);
    p.stroke(0);
    p.rect(x, y, SIZE, SIZE);
  }
  /**
   * Method deathDisplay changes the color of this block when the game ends
   * @param r the red value
   * @param g the green value
   * @param blue the blue value
   */
  public void deathDisplay(int r, int g, int blue)
  {
    p.rectMode(p.CENTER);
    p.fill(r, g, blue);
    p.strokeWeight(1);
    p.stroke(0);
    p.rect(x, y, SIZE, SIZE);
  }

  /**
   * Method getX returns this.x
   * @return this.x
   */
  public int getX()
  {
    return x;
  }
  /**
   * Method getY returns this.y
   * @return this.y
   */
  public int getY()
  {
    return y;
  }
  
  /**
   * Method setX sets this.x
   * @param x the new x position to set this.x to
   */
  public void setX(int x)
  {
    this.x = x;
  }
  
  /**
   * Method setY sets this.y
   * @param y the new x position to set this.y to
   */
  public void setY(int y)
  {
    this.y = y;
  }
}