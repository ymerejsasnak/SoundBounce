void mousePressed() {

  //if (ball.mouseOver(mouseX, mouseY))

  if (mouseButton == LEFT) {
    ball.setPressed(mouseX, mouseY);
    
  } else if (mouseButton == RIGHT) {
    audio.recordToFile();
  }
}


void mouseWheel(MouseEvent e)
{
   ball.angleNudge(e.getCount() / 10.0);
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