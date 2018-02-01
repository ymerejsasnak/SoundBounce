// cleanup, comments, etc
// make sounds to use


// LAST BUG? - issue with killing old samplers if non-wave file selected (ie, take it out of the try block or reassign then kill?)

// display info on screen? (min/max rate, file loaded, etc?)


import beads.*;
import java.io.File;


final int BORDER = 30;
final int BALL_RADIUS = 50;

final int POS_MIN = BORDER + BALL_RADIUS;
final int POS_MAX = 800 - BORDER - BALL_RADIUS;

final float RATE_MAX = 4;
final float RATE_MIN = 0.25;

Ball ball;
Audio audio;
Display display;

void setup() {
  size(800, 800); 
  
  ball = new Ball();
  audio = new Audio();
  display = new Display();
      
}


void draw() {
  
  display.drawBorder();
  display.showText(); 
  
  display.clearCenter(); 

  ball.updatePosition();
  ball.collisionDetect();
  ball.display();
  
}