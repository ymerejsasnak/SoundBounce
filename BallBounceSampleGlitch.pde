// maybe load 2 of each sound and crossfade with each new trigger so less glitchy with longer sounds?
// add recording
// any other ideas or is that fine?
// cleanup, adjustments, finish, share, etc.



import beads.*;


final int BORDER = 30;


float tempmin = .75;
float tempmax = 1.5;


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
  
  fill(0, 20);
  rect(BORDER, BORDER, width - BORDER * 2, height - BORDER * 2);

  ball.updatePosition();
  ball.collisionDetect();
  ball.display();

  
}