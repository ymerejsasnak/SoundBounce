class Ball {

  float x, y;
  float startX, startY;
  float speed;
  float angle;
  
  boolean pressed;
  
  Ball() {
    x = width/2;
    y = height/2;
    speed = 0;
    angle = random(360);
  }
  
  
  boolean mouseOver(int _mouseX, int _mouseY) {
    return dist(_mouseX, _mouseY, x, y) < BALL_RADIUS;
    
  }
  
  
  void followMouse(int _mouseX, int _mouseY) {
    x = _mouseX;
    y = _mouseY;
  }
  
  
  void setPressed(int _mouseX, int _mouseY) {
    followMouse(_mouseX, _mouseY);
    pressed = true; 
    speed = 0;
    startX = _mouseX;
    startY = _mouseY;
  }
  
  
  void setReleased() {
    if (pressed) {
      pressed = false; 
      speed = dist(x, y, startX, startY) / 2;
      angle = atan2(startY - y, startX - x);
    }
  }
  
  
  boolean getPressed() {
    return pressed;  
  }
  
  
  void angleNudge(float direction) {
    angle += direction;  
  }
  
  
  void updatePosition() {
    x += cos(angle) * speed;
    y += sin(angle) * speed;
  }
  
  
  void collisionDetect() {
    
    if (x < POS_MIN) { 
      x = POS_MIN;
      angle = PI - angle;
      audio.triggerSampler(0, y);
    } else if (x > POS_MAX) { 
      x = POS_MAX;
      angle = PI - angle;
      audio.triggerSampler(1, y);
    }
    
    if (y < POS_MIN) { 
      y = POS_MIN;
      angle = TAU - angle;
      audio.triggerSampler(2, x);
    } else if (y > POS_MAX) { 
      y = POS_MAX;
      angle = TAU - angle;
      audio.triggerSampler(3, x);
    }   
  }
  

  void display() {

    fill(200);
    noStroke();
    ellipse(x, y, BALL_RADIUS * 2, BALL_RADIUS * 2);
    
    if (pressed) {
      stroke(150);
      line(x, y, startX, startY); 
    }
  }
  
}