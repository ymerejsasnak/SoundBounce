// cleanup, comments, etc
// make sounds to use


// maybe have 8 loadable sounds (split each side in half? -- color code things to easily load multiple sounds with corners)

// maybe load 2/3/4 of each sound and cycle the triggering (ie multiple voices per sampler)
// ?? limit soundfile length ?? or add envelop?



import beads.*;
import java.io.File;


final int BORDER = 30;
final int BALL_RADIUS = 50;

final int POS_MIN = BORDER + BALL_RADIUS;
final int POS_MAX = 800 - BORDER - BALL_RADIUS;

final float RATE_MIN = .95;
final float RATE_MAX = 1.1;

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