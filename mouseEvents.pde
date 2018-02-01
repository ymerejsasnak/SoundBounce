void mousePressed() {

  if (mouseButton == LEFT) {
    border.locateClick(mouseX, mouseY);   
    
  } else if (mouseButton == RIGHT) {
    audio.recordToggle();
  }
  
}


void mouseWheel(MouseEvent e) {
   ball.adjustAngle(e.getCount() / 10.0);
}


void mouseReleased() {
  ball.setReleased();
}


void mouseDragged() {
  if (ball.getPressed()) {
    ball.followMouse(mouseX, mouseY);
  }
}