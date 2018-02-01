class Border {
  
  Border() {
    
  }
  
  void drawBorder() {
    
    stroke(50);
    
    // fileload bars for the 4 sides
    fill(200);
    rect(BORDER, 0, width - BORDER * 2, BORDER);
    rect(BORDER, height - BORDER, width - BORDER * 2, BORDER);
    rect(0, BORDER, BORDER, height - BORDER * 2);
    rect(width - BORDER, BORDER, BORDER, height - BORDER * 2);
    
    // top left corner button
    fill(0, 100, 0);
    rect(0, 0, BORDER, BORDER);
    
    // top right
    fill(0, 100, 100);
    rect(width - BORDER, 0, BORDER, BORDER);
    
    // bottom left
    fill(100, 0, 0);
    rect(0, height - BORDER, BORDER, BORDER);
    
    // bottom right
    fill(0, 0, 100);
    rect(width - BORDER, height - BORDER, BORDER, BORDER);
  }
  
  
  void locateClick(int _mouseX, int _mouseY){
    // left bar
    if (_mouseX < BORDER && _mouseY > BORDER && _mouseY < height - BORDER) {
      audio.loadSample(0);
    // right bar
    } else if (_mouseX > width - BORDER && _mouseY > BORDER && _mouseY < height - BORDER ) {
      audio.loadSample(1);
    // top bar
    } else if (_mouseY < BORDER && _mouseX > BORDER && _mouseX < width - BORDER) {
      audio.loadSample(2);
    // bottom bar
    } else if (_mouseY > height - BORDER && _mouseX > BORDER && _mouseX < width - BORDER) {
      audio.loadSample(3);
      
    // top left corner
    } else if (_mouseX < BORDER && _mouseY < BORDER) {
      audio.adjustRateMin(.05);
    // top right
    } else if (_mouseX > BORDER - width && _mouseY < BORDER) {
      audio.adjustRateMax(.1);
    // bottom left
    } else if (_mouseX < BORDER && _mouseY > height - BORDER) {
      audio.adjustRateMin(-.05);
    // bottom right
    } else if (_mouseX > width - BORDER && _mouseY > height - BORDER) {
      audio.adjustRateMax(-.1);
    
    } else {
      ball.setPressed(mouseX, mouseY);
    } 
  }
}