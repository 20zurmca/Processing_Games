import processing.core.PApplet;
import java.util.Random;
import java.util.ArrayList;

/****
 * Class Food represents a piece of food for the snake to eat
 ****/

public class Food extends SnakeBlock
{
  /**
   * Constructor for class food calculates valid X and Y coordinates for the food 
   * @param p the PApplet from SnakeGame
   * @param s the snake form SnakeGame
   * @param began whether the game has beegun
   **/
  public Food(PApplet p, Snake s, boolean began)
  {
    this.p = p;
    Random r = new Random();

    ArrayList<Integer> randomXRange = new ArrayList<>(); //will hold a list of valid random x values for food to appear
    ArrayList<Integer> randomYRange = new ArrayList<>(); //will hold a list of valid random y values for food to appear

    int a = p.width-SnakeBlock.SIZE/2;
    int b = p.height- SnakeBlock.SIZE/2;
    while (a >= SnakeBlock.SIZE/2)
    {
      randomXRange.add(a);
      a-=SnakeBlock.SIZE;
    }
    while (b >= p.height/10)
    {
      randomYRange.add(b);
      b-=SnakeBlock.SIZE;
    }

    int randX = randomXRange.get(r.nextInt(randomXRange.size()));
    int randY = randomYRange.get(r.nextInt(randomYRange.size()));



    boolean inSnake = false;
    for (SnakeBlock sb : s.getBody()) //checking if food is inside the snake
    {
      if (sb.getX() == this.x && sb.getY() == this.y) inSnake = true;
    }
    while (inSnake && !began) //if the food is inside the snake and the game has not begun, recalcuate X and Y coordiantes for food (avoids free point before game has started)
    {
      randX = randomXRange.get(r.nextInt(randomXRange.size()));
      randY = randomYRange.get(r.nextInt(randomYRange.size()));
    }
    x = randX;
    y = randY;
  }

  /**
   * Method display displays the food as a red block
   **/
  public void display()
  {
    p.rectMode(p.CENTER);
    p.fill(255, 0, 0);
    p.strokeWeight(1);
    p.stroke(0);
    p.rect(x, y, SIZE, SIZE);
  }
}