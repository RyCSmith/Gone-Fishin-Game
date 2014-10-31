//creates bubbles (for aesthetic purposes)
class Bubble
{
  float x; // variables used in determining location, velocity and size of Bubble object
  float y;
  float dY;
  float diameter;
  
  Bubble(float diam){
    diameter = diam;
    x = random(0, width);
    y = height;
    dY = -3;
  }
  void moveBubble(){
    //moves the Bubble object. As they move in a straight line up, only Y coordinates and velocity are required.
    y += dY;
  }
  void drawBubble(){
    //creates a graphical representation of a Bubble object
    fill(#36F7FF);
    ellipse(x, y, diameter, diameter);
  }
}
