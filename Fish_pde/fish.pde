//Fish class. Used to create Fish objects for Gone Fishin' game.

class Fish 
{
  float x; // variables used in determining location, velocity and size of Fish object
  float y;
  float dX;
  float diameter;
  
  float leftX; // variables determining zone of collision with Fish object
  float rightX;
  float upperY;
  float lowerY;
  float thisR; // variables used in choosing color of fish object
  float thisB;
  float thisG;
 
  
  Fish(float diam){
    diameter = diam;
    thisR = random(0, 200);
    thisB = random(0, 255);
    thisG = random(0, 255);
    y = random(height);
    x = random(0, 1);
    if (x < .5){
      x = -diameter;
      dX = random(1, 10); 
      rightX = x + (.7 * diameter);
      leftX = x - (1.4 * diameter);
      lowerY = y + (.4 * diameter);
      upperY = y - (.4 * diameter);
    }
    else{
      x = width + diameter;
      dX = random(-10, -1); 
      leftX = x - (.7 * diameter);
      rightX = x + (1.4 * diameter);
      lowerY = y + (.4 * diameter);
      upperY = y - (.4 * diameter);
    }
  }
  
  void moveFish() {
    //moves the zone of collision. Fish move in a straight line so only x variables must be updated.
    x += dX;
    rightX += dX;
    leftX += dX;
  }
  
  void drawFish(){
    //produces a graphical representation of the fish object and chooses a random color.
    fill( thisR, thisG, thisB);
    ellipse(x, y, 2 * diameter, diameter);
    if (dX > 0){
      triangle(x-(diameter), y, x-(1.5*diameter), y + (.5 * diameter), x-(1.5*diameter), y - (.5 * diameter)); 
      line((x + diameter), y, (x + .25 * diameter), y);
      ellipse((x + .5 * diameter), (y - .25 * diameter), (diameter / 5), (diameter / 5));
      ellipse((x + .5 * diameter), (y - .25 * diameter), (diameter / 20), (diameter / 20)); 
    }else{
      triangle(x+(diameter), y, x+(1.5*diameter), y + (.5 * diameter), x+(1.5*diameter), y - (.5 * diameter));
      line((x - diameter), y, (x - .25 * diameter), y);
      ellipse((x - .5 * diameter), (y - .25 * diameter), (diameter / 5), (diameter / 5)); 
      ellipse((x - .5 * diameter), (y - .25 * diameter), (diameter / 20), (diameter / 20)); 
    }
  }
  
  void die(){
    //sets the fish to nothing effectively after they are eaten.
    diameter = 0;
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
  
  float getDiameter(){
    return diameter;
  }
}
