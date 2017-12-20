import processing.sound.*; //<>//

/******
 * A fun and simple snake game.  Follow prompts on screen to play.  Control snake with arrows. 
 ******/

int score, highScore, time, prevHighScore;
boolean movingRight, movingDown, movingLeft, movingUp, pause, began;
boolean alreadyPlaying = false;
Snake s;
Food f;
SoundFile f1;

void setup()
{
  size(820, 700);
  score = 0;
  began = movingRight = movingDown = movingLeft = movingUp = pause = false;
  time = millis();
  s = new Snake(this);
  f = new Food(this, s, began);
  prevHighScore = highScore = loadGame();
  f1 = new SoundFile(this, "coin.mp3"); //plays a coin sound when the snake eats food
  frameRate(12);
}

void draw()
{
  background(0);
  s.display();
  f.display();
  checkForFood();
  if (pause)
    pauseGame();
  displayHeader();
  displayInstructions();
  if (movingDown) moveDown();
  else if (movingRight) moveRight();
  else if (movingLeft) moveLeft();
  else if (movingUp) moveUp();
  if (endGame()) {
    int passedTime = millis() - time; // calculates passed milliseconds for animation
    if (passedTime>= 215) {
      time = millis(); //reset time
      die(255, 255, 255); //draw snake blocks white
    } else {
      die(50, 205, 50); //draw snake blocks green
    }
    displayContinueScreen();
  }
}

/**
 * Method displayHeader displays the score, high score, and title of game at top of screen
 **/
void displayHeader()
{
  stroke(50, 205, 50);
  fill(50, 205, 50);
  strokeWeight(1);
  line(0, height/10-SnakeBlock.SIZE/2, width, height/10-SnakeBlock.SIZE/2);
  textFont(loadFont("GoudyOldStyleT-Bold-48.vlw"));
  textAlign(CENTER, CENTER);
  textSize(32);
  text("SNAKE", width/2, height/15);
  textSize(24);
  text("HIGH SCORE: " + highScore, width/6, height/15);
  text("CURRENT SCORE: " + score, 8*width/10, height/15);
}

/**
 * Method displayInstructions displays the instructions for the user at the bottom of the screen
 **/
void displayInstructions()
{
  String s = "Press the arrow keys to move the snake. Start with RIGHT, UP or DOWN key.\nEat as much food as possible without hitting walls or the snake.\nPress CTRL or COMMAND to pause/unpause.";
  if (!began)
  {
    textAlign(CENTER, CENTER);
    textSize(20);
    text(s, width/2, height-100);
  }
}

void keyPressed()
{

  if (keyCode == RIGHT && !movingLeft && !pause && !endGame()) 
  {
    began = true;
    if (moveRight()) { //make sure the snake moves right at least once before setting right to true (avoids a glitch where the snake can run into itself if two arrows are pushed at the same time)
      movingRight = true;
      movingUp = movingDown = false;
    }
  } else if (keyCode == LEFT && !movingRight && began && !pause && !endGame()) 
  {
    if (moveLeft()) //repeated logic
    {
      movingLeft = true;
      movingUp = movingDown = false;
    }
  } else if (keyCode == UP && !movingDown && !pause && !endGame()) 
  {
    began = true; 
    if (moveUp()) {
      movingUp = true;
      movingLeft = movingRight = false;
    }
  } else if (keyCode == DOWN && !movingUp && !pause && !endGame()) 
  {
    began = true;
    if (moveDown()) {
      movingDown = true;
      movingLeft = movingRight = false;
    }
  } else if ((keyCode == CONTROL || keyCode == 157) && !endGame()) //157 = COMMAND on Mac
  {
    if (!pause) {
      pause = true;
    } else {
      pause = false;
      loop();
    }
  } else if (key == ' ' && endGame())
  {
    setup();
  } else if ((key == 'q' || key == 'Q' ) && endGame())
  {
    exit();
  }
}

/**
 * Method moveRight moves the snake right by shifting the blocks in the body of the snake
 * @return if the snake moved right one block size
 **/
boolean moveRight()
{
  int leadX = s.getLeadX();
  for (int i = 0; i<s.getBody().size()-1; i++) //shifting blocks 
  {
    SnakeBlock curr = s.getBody().get(i);
    SnakeBlock next = s.getBody().get(i+1);
    curr.setX(next.getX());
    curr.setY(next.getY());
  }
  s.getLeader().setX(leadX + SnakeBlock.SIZE); //setting leader
  return true;
}

/**
 * Method moveUp moves the snake up by shifitng the blocks in the body of the snake
 * @return if the snake moved up one block size
 **/
boolean moveUp()
{
  int leadY = s.getLeadY();

  for (int i = 0; i<s.getBody().size()-1; i++) //shifting blocks behind leader
  {
    SnakeBlock curr = s.getBody().get(i);
    SnakeBlock next = s.getBody().get(i+1);
    curr.setX(next.getX());
    curr.setY(next.getY());
  }

  //setting leader
  s.getLeader().setY(leadY - SnakeBlock.SIZE);
  return true;
}

/**
 * Method moveDown moves the snake down by shifting the blocks in the body of the snake
 * @return if the snake moved down one block size
 **/
boolean moveDown()
{
  int leadY = s.getLeadY();

  for (int i = 0; i<s.getBody().size()-1; i++) //shifting blocks behind leader
  {
    SnakeBlock curr = s.getBody().get(i);
    SnakeBlock next = s.getBody().get(i+1);
    curr.setX(next.getX());
    curr.setY(next.getY());
  }
  s.getLeader().setY(leadY + SnakeBlock.SIZE); //setting leader
  return true;
}

/**
 * Method moveLeft moves the snake left by shifitng the blocks in the body of the snake
 * @return if the snake moved left one SnakeBlock Size
 **/
boolean moveLeft()
{
  int leadX = s.getLeadX();

  for (int i = 0; i<s.getBody().size()-1; i++) //shifting blocks behind leader
  {
    SnakeBlock curr = s.getBody().get(i);
    SnakeBlock next = s.getBody().get(i+1);
    curr.setX(next.getX());
    curr.setY(next.getY());
  }
  s.getLeader().setX(leadX - SnakeBlock.SIZE); //setting leader
  return true;
}

/**
 * Method checkForFood checks if the snake ate food
 **/
void checkForFood()
{
  boolean hasFood = s.getLeadX() == f.getX() && s.getLeadY() == f.getY()
    || s.getBody().get(s.getBody().size()-2).getX() == f.getX() && s.getBody().get(s.getBody().size()-2).getY() == f.getY(); //this condition is to account for framerate issues.
                                                                                                                             //If you time it right, you can have the lead block in the snake miss the food
                                                                                                                             //when there should have been a hit
  if (hasFood)
  {
    f = new Food(this, s, began);
    updateScore();
    s.grow();
    f1.play(); //play coin sound
  }
}

/**
 * Method pauseGame pauses the game and informs the user what directions he/she was previously going before pausing
 **/
void pauseGame()
{
  String s = "PAUSED";
  String z = "(You were moving ";
  if (movingDown) z += "down)";
  else if (movingUp) z += "up)";
  else if (movingLeft) z += "left)";
  else if (movingRight) z += "right)";
  else z = "You have not started the game";
  textAlign(CENTER, CENTER);
  fill(255, 0, 0);
  textSize(20);
  text(s, width/2, height/3);
  text(z, width/2, height/3+20);
  noLoop();
}

/**
 * Method saveGame writes the highScore to a .txt file
 **/
void saveGame()
{
  PrintWriter writer = null;
  try {
    writer = createWriter("HighScore.txt");
    writer.print(highScore);
  } 
  catch(Exception e)
  {
    e.printStackTrace();
  }
  writer.close();
  writer.flush();
}

/**
 * Method loadGame reads in the most recent highScore
 * @return the high score from "highScore.txt"
 **/
int loadGame()
{
  String highScore = null;
  BufferedReader reader = null;
  try {
    reader = createReader("HighScore.txt");
    highScore = reader.readLine();
    reader.close();
  } 
  catch(IOException e)
  {
    e.printStackTrace();
  }

  return Integer.parseInt(highScore);
}

/**
 * Method endGame checks conditions for ending the game
 * @return if the snake is in a position to end the game
 **/
boolean endGame()
{
  //Condition 1: if snake hits walls
  if (s.getLeadX() <= 0 || s.getLeadX() >= width || s.getLeadY() <= height/10 - SnakeBlock.SIZE/2 || s.getLeadY() >= height)
  {
    movingRight = movingLeft = movingUp = movingDown = false;
    return true;
  }

  for (int i = 0; i<s.getBody().size()-1; i++)
  {
    //Condition 2: if snake hits itself
    if (s.getLeadX()==s.getBody().get(i).getX() && s.getLeadY()==s.getBody().get(i).getY()) 
    {
      movingRight = movingLeft = movingUp = movingDown = false;
      return true;
    }
  }
  return false;
}

/**
 * Method die makes the snake a certain color upon dying
 * @parm r red value
 * @param g green value
 * @param blue blue value
 **/
void die(int r, int g, int blue)
{
  s.deathDisplay(r, g, blue);
}

/**
 * Method displayContinueScreen appears when the player dies and gives prompts to continue/quit
 **/
void displayContinueScreen()
{
  textSize(32);
  textAlign(CENTER, CENTER);
  fill(255, 0, 0);
  text("PRESS SPACEBAR TO PLAY AGAIN OR Q TO QUIT", width/2, height/3);
  text("YOUR SCORE: " + score, width/2, height/3 + 40);
  text("HIGH SCORE:  " + highScore, width/2, height/3 + 80);
  if (score >= prevHighScore + 1)
  {
    text("NEW HIGH SCORE!", width/2, height/3 + 120);
  }
  textSize(24);
}
/**
 * Method updateScore updates score, highScore, and saves the game if a new high score is achieved
 **/
void updateScore()
{
  score++;
  if (score > highScore)
  {
    highScore = score;
    saveGame();
  }
}