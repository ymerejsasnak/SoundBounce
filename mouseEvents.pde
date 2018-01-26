void mousePressed() {


  if (mouseButton == LEFT) {
    if (mouseX < BORDER) {
      audio.loadSample(0);
    } else if (mouseX > width - BORDER) {
      audio.loadSample(1);
    } else if (mouseY < BORDER) {
      audio.loadSample(2);
    } else if (mouseY > width - BORDER) {
      audio.loadSample(3);
      
    } else {
      ball.setPressed(mouseX, mouseY);
    }
    
  } else if (mouseButton == RIGHT) {
    audio.recordToFile();
  }
}


void mouseWheel(MouseEvent e) {
   ball.angleNudge(e.getCount() / 10.0);
}


void mouseReleased() {
  ball.setReleased();
}


void mouseDragged() {
  if (ball.getPressed()) {
    ball.followMouse(mouseX, mouseY);
  }
}