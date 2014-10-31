// Gone Fishin' by Anders Schneider and Ryan Smith

//How to play: Move the red user fish by moving the mouse or your finger on the trackpad.
            // Collide with smaller fish in order to eat and grow.
            // Do not collide with larger fish or they will eat you and the game will end.
            // You will achieve a score based on the size of the food you eat.
            // Avoid sharks (black fish with a fin) at all costs! They will eat you and end the game even if you are bigger (they're sharks afterall...).

float meX; //variables representing location of user fish
float meY;
float meDX; //variables representing velocity of user fish
float meDY;
float oldMouseX; //variables representing last position of mouse
float oldMouseY;
ArrayList<Fish> list = new ArrayList();
ArrayList<Bubble> bubList = new ArrayList();
ArrayList<Shark> sharkList = new ArrayList();
int timeCounter;
float usDiameter = 20;
float usLeftX; //variables that create invisible zone around fish for calculating collisions
float usRightX;
float usUpperY;
float usLowerY;
boolean collision = false;
float fishSize = -1; //stores size of computer fish in case of collision
boolean gameOver = false;

void setup(){
  //initializes basic functions of game. user fish starts in the middle of the screen.
  size(1000, 600);
  meX = width / 2;
  meY = height / 2;
  meDX = 0;
  meDY = 0;
  frameRate(60); // number of frames per second
}

void draw(){
  // executes the main functions of the game
  if (gameOver){
    gameOver();
    return;
  }
  timeCounter += 1;
  if (timeCounter % 300 == 0){
    float thisBubDiam = random(30, 120); // produces bubbles
    bubList.add(new Bubble(thisBubDiam));
  }
  
  //following section creates computer fish of random size and ensures a large fish is produced every 10th time
  if (timeCounter % 120 == 0){
    float thisFishDiam;
    if (list.size() % 10 == 0)
    {
      thisFishDiam = random(60, 200);
    } else
    {
      thisFishDiam = random(0, 30);
    }  
    list.add(new Fish(thisFishDiam));
  }
  
  //creates a shark every 10 seconds
  if (timeCounter % 600 == 0){
    sharkList.add(new Shark());
  }

  background(#D4F8FA);
  drawScore();
  
  // following lines draw and move the objects we have created above
  drawMisc();
  for (Bubble bubble : bubList){
    bubble.drawBubble();
    bubble.moveBubble();
  }
  
  for (Fish fish : list){
    fish.moveFish();
    fish.drawFish();
  }
  
  for (Shark shark : sharkList){
    shark.drawShark();
    shark.moveShark();
  }
  
  moveUsFish();
  drawUsFish();
  //drawTestSquare(); This is a test method used when adjusting the zone for collisions. This could be used to increase difficulty with subsequent levels of the game.
  //testOtherFish(); This is a test method used when adjusting the zone for collisions. This could be used to increase difficulty with subsequent levels of the game.
  
  fishSize = testForCollision();
  collision = (fishSize != -1);
  if (collision){
    collision();
  }
  testForSharkCollision();
}

void drawUsFish()
//creates user fish and establishes the zone of impact for collisions
{
  fill(#F50707);
  ellipse(meX, meY, 2 * usDiameter, usDiameter);
  if (meDX > 0){
    triangle(meX-(usDiameter), meY, meX-(1.5* usDiameter), meY + (.5 * usDiameter), meX-(1.5 * usDiameter), meY - (.5 * usDiameter));
    usRightX = meX + (.8 * usDiameter);
    usLeftX = meX - (1.3 * usDiameter);
    usLowerY = meY + (.4 * usDiameter);
    usUpperY = meY - (.4 * usDiameter);
    line((meX + usDiameter), meY, (meX + .25 * usDiameter), meY);
    ellipse((meX + .5 * usDiameter), (meY - .25 * usDiameter), (usDiameter / 5), (usDiameter / 5));
    ellipse((meX + .5 * usDiameter), (meY - .25 * usDiameter), (usDiameter / 20), (usDiameter / 20)); 
  }else{
    triangle(meX+(usDiameter), meY, meX+(1.5* usDiameter), meY + (.5 * usDiameter), meX+(1.5 * usDiameter), meY - (.5 * usDiameter));
    usLeftX = meX - (.8 * usDiameter);
    usRightX = meX + (1.3 * usDiameter);
    usLowerY = meY + (.4 * usDiameter);
    usUpperY = meY - (.4 * usDiameter);
    line((meX - usDiameter), meY, (meX - .25 * usDiameter), meY);
    ellipse((meX - .5 * usDiameter), (meY - .25 * usDiameter), (usDiameter / 5), (usDiameter / 5));
    ellipse((meX - .5 * usDiameter), (meY - .25 * usDiameter), (usDiameter / 20), (usDiameter / 20)); 
  }
}

void moveUsFish(){
  //moves the user fish
  meX += meDX;
  meY += meDY;    
  meDX = (mouseX - meX)/5;
  meDY = (mouseY - meY)/5;

  if (meX < 0) meX = 0;
  if (meX > width) meX = width;
  if (meY < 0) meY = 0;
  if (meY > height) meY = height;
  oldMouseX = mouseX;
  oldMouseY = mouseY;
  
  usRightX += meDX;
  usLeftX += meDX;
  usUpperY += meDY;
  usLowerY += meDY;
}

void drawMisc(){
  //draws the seaweed at the bottom of the screen
  float counter = 1;
  float plantHeight = 100;
  for (int z = 40; z > 1; z--)
  {
    fill(#0AAD1C);
    ellipse((25* counter), 580, 10, plantHeight);
    if (counter % 2 == 1)
    {
      plantHeight = 150;
    }
    else
    {
      plantHeight = 100;
    }
    counter++;
  }
}

float testForCollision(){
  //looks for a collision between the between the computer fish and the user fish. Kills the computer fish if the user fish is bigger.
  for(Fish fish : list){
    if (((fish.getLeftX() < usRightX) && (fish.getLeftX() > usLeftX)) || ((fish.getRightX() > usLeftX) && (fish.getRightX() < usRightX))){
      if(((fish.getLowerY() < usLowerY) && (fish.getLowerY() > usUpperY)) || ((fish.getUpperY() > usUpperY) && (fish.getUpperY() < usLowerY))){
        float fishDiameter = fish.getDiameter();
        if (fishDiameter <= usDiameter){
          fish.die();
        }
        return fishDiameter;
      }
    }
    if (((usLeftX < fish.getRightX()) && (usLeftX > fish.getLeftX())) || ((usRightX > fish.getLeftX()) && (usRightX < fish.getRightX()))){
      if(((usLowerY < fish.getLowerY()) && (usLowerY > fish.getUpperY())) || ((usUpperY > fish.getUpperY()) && (usUpperY < fish.getLowerY()))){
        float fishDiameter = fish.getDiameter();
        if (fishDiameter <= usDiameter){
          fish.die();
        }
        return fishDiameter;
      }
    }
  }
  return -1;
}

void testForSharkCollision(){
  //tests for a collision between the user fish and a shark. updates gameOver variable if it occurs.
  for(Shark shark : sharkList){
    if (((shark.getLeftX() < usRightX) && (shark.getLeftX() > usLeftX)) || ((shark.getRightX() > usLeftX) && (shark.getRightX() < usRightX))){
      if(((shark.getLowerY() < usLowerY) && (shark.getLowerY() > usUpperY)) || ((shark.getUpperY() > usUpperY) && (shark.getUpperY() < usLowerY))){
        gameOver = true;
      }
    }
    if (((usLeftX < shark.getRightX()) && (usLeftX > shark.getLeftX())) || ((usRightX > shark.getLeftX()) && (usRightX < shark.getRightX()))){
      if(((usLowerY < shark.getLowerY()) && (usLowerY > shark.getUpperY())) || ((usUpperY > shark.getUpperY()) && (usUpperY < shark.getLowerY()))){
        gameOver = true;
      }
    }
  }
}

void collision(){
  //After a collision, either increases user fish size or updates endGame variable based on size of computer fish in collision.
  if (fishSize > usDiameter){
    gameOver = true;
  }else{
    usDiameter += (.25 * fishSize);
  } 
}

void gameOver(){
  //Ends the game and prints the score.
  text("Game Over!", 400, 250);
  text(("Your Score: " + str(int(usDiameter-20))), 400, 350);
}



void drawTestSquare(){
  //test method used to see the impact area of the user fish (unused in current operation).
  rect(usLeftX, usUpperY, (usRightX-usLeftX), (usLowerY-usUpperY));
}

void testOtherFish(){
  //test method used to see the impact area of the computer fish (unused in current operation).
  for(Fish fish: list){
    rect(fish.getLeftX(), fish.getUpperY(), (fish.getRightX() - fish.getLeftX()), (fish.getLowerY() - fish.getUpperY()));
  }
}

void drawScore(){
  //Displays the score in the top left hand corner of the screen.
  fill(0);
  textSize(28);
  text(str(int(usDiameter - 20)), 50, 50);
}

