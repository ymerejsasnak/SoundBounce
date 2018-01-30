// cleanup, comments, etc
// make sounds to use


// LAST BUG? - issue with killing old samplers if non-wave file selected (ie, take it out of the try block or reassign then kill?)

// option to adjust pitch range (from zero to a couple octaves?)  (preset ranges selectable at corners)


import beads.*;
import java.io.File;


final int BORDER = 30;
final int BALL_RADIUS = 50;

final int POS_MIN = BORDER + BALL_RADIUS;
final int POS_MAX = 800 - BORDER - BALL_RADIUS;

final float RATE_MIN = 1;
final float RATE_MAX = 1;


Ball ball;
Audio audio;


void setup() {
  size(800, 800);
  background(200);
  noStroke();
  
  ball = new Ball();
  audio = new Audio();
}


void draw() {
  
  fill(0, 50);
  rect(BORDER, BORDER, width - BORDER * 2, height - BORDER * 2);

  ball.updatePosition();
  ball.collisionDetect();
  ball.display();
  
}