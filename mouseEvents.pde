void mousePressed() {
  
  //if (ball.mouseOver(mouseX, mouseY))
  
    if (mouseButton == LEFT) {
      ball.setPressed(mouseX, mouseY);
    }
    else if (mouseButton == RIGHT) {
      ball.angleNudge(); 
    }
    else if (mouseButton == CENTER) {
      audio.recordToFile();
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