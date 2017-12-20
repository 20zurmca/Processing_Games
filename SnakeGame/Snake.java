import java.util.ArrayList;
import processing.core.PApplet;

/****
 * Class Snake represents the snake in the game
 ****/

public class Snake
{
  ////////////FIELDS////////////////
  private PApplet p; //the PApplet from SnakeGame

  private ArrayList <SnakeBlock> body = new ArrayList<>(); //the body of the snake

  ///////////CONSTRUCTOR////////////
  /**
   * Constructor for class Snake starts with 3 snake blocks in the body
   * @param p the PApplet from SnakeGame
   */
  public Snake(PApplet p)
  {
    this.p = p;
    body.add(new SnakeBlock(p, p.width/2+SnakeBlock.SIZE, p.height/2));
    for (int i = 0; i<2; i++)
    {
      body.add(0, new SnakeBlock(p, body.get(0).getX()-SnakeBlock.SIZE, body.get(0).getY()));
    }
  }

  /////////////METHODS///////////////
  /**
   * Method display displays all the snake blocks in the snake
   */
  public void display()
  {
    for (SnakeBlock b : body)
    {
      b.display();
    }
  }
  /**
   * Method ddeathDisplay displays the snake a certain color upon dying
   * @param r red value
   * @param g green value
   * @param blue blue value
   */
  public void deathDisplay(int r, int g, int blue)
  {
    for (SnakeBlock b : body)
    {
      b.deathDisplay(r, g, blue);
    }
  }
  /**
   * Method grow appends a snake block to the snake
   */
  public void grow()
  {
    SnakeBlock curr =  body.get(0);
    body.add(0, new SnakeBlock(p, body.get(0).getX(), body.get(0).getY()));
  }
  /**
   * Method getBody returns the body of the snake
   * @return this.body
   */
  public ArrayList<SnakeBlock> getBody()
  {
    return body;
  }
  /**
   * Method getLeadX returns the lead block's x position
   * @return the head's X posiiton
   */
  public int getLeadX()
  {
    return body.get(body.size()-1).getX();
  }

  /**
   * Method getLeadY returns the lead block's Y position
   * @return the head's Y position
   */
  public int getLeadY()
  {
    return body.get(body.size()-1).getY();
  }
  
  /**
   * Method getLeader returns the lead block
   * @return the head of the snake
   */
  public SnakeBlock getLeader()
  {
    return body.get(body.size()-1);
  }
}