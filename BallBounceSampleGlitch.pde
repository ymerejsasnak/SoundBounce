// maybe load sound 4 times (or 4 diff sounds?), 1 for each side
// then can assign forward or reverse
// can assign pitch range (or other possible stuff???)
// but keep it simple and finish it soon!
// add recording of course

import beads.*;


final int BORDER = 30;



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

void mousePressed() {
  
  //if (ball.mouseOver(mouseX, mouseY))
  
    if (mouseButton == LEFT)
    {
      ball.setPressed(mouseX, mouseY);
    }
    else if (mouseButton == RIGHT)
    {
      ball.angleNudge(); 
    }
}


void mouseReleased()
{
  ball.setReleased(); 
}


void mouseDragged()
{
  if (ball.getPressed())
  {
    ball.followMouse(mouseX, mouseY); 
  }
}