// Shark class. Creates shark object for Gone Fishin' game.

class Shark
{
  float x; // variables used in determining location, velocity and size of Shark object
  float y;
  float dX;
  float dY;
  float diameter = 20;
  
  float leftX; // variables determining zone of collision with Shark object
  float rightX;
  float upperY;
  float lowerY;
  
  Shark()
  {
    y = random(height);
    x = random(0, 1);
    if (x < .5)
    {
      x = 0;
      dX = random(1, 10); 
    }
    else
    {
      x = width;
      dX = random(-10, -1); 
    }
  }
  
void moveShark(){
  //moves a shark object and their collision zone across the screen. The shark will follow the user fish.
    x += dX;
    y += dY;
    float xDisplace = meX - x;
    float yDisplace = meY - y;
    float distance = sqrt(xDisplace*xDisplace + yDisplace*yDisplace);
    float factor = 25/(0.01+10*distance);
    dX = factor*xDisplace;
    dY = factor*yDisplace;
   
    if (x < 0) x = 0;
    if (x > width) x = width;
    if (y < 0) y = 0;
    if (y > height) y = height;
 
    rightX += dX;
    leftX += dX;
    upperY += dY;
    lowerY += dY;
  }
  
  void drawShark(){
    //creates a grpahical representation of the shark object
    fill(0);
    ellipse(x, y, 2 * diameter, diameter);
    if (dX > 0){
      triangle(x-(diameter), y, x-(1.5* diameter), y + (.5 * diameter), x-(1.5 * diameter), y - (.5 * diameter));
      rightX = x + (.8 * diameter);
      leftX = x - (1.3 * diameter);
      lowerY = y + (.4 * diameter);
      upperY = y - (.4 * diameter);
      triangle(x + .5 * diameter, (y - 1/3 * diameter), (x - .5 * diameter), (y - 1/3 * diameter), (x - .5 * diameter), (y -diameter));
    }else{
      triangle(x+(diameter), y, x+(1.5* diameter), y + (.5 * diameter), x+(1.5 * diameter), y - (.5 * diameter));
      leftX = x - (.8 * diameter);
      rightX = x + (1.3 * diameter);
      lowerY = y + (.4 * diameter);
      upperY = y - (.4 * diameter);
      triangle(x - .5 * diameter, (y - 1/3 * diameter), (x + .5 * diameter), (y - 1/3 * diameter), (x + .5 * diameter), (y -diameter));
    }
  }
 
  //the following are getters used in calculating collisions and result therof in the Fish_pde file. 
   float getLeftX(){
    return leftX;
  }
  
  float getRightX(){
    return rightX;
  }
  
  float getUpperY(){
    return upperY;
  }
  
  float getLowerY(){
    return lowerY;
  }
}

