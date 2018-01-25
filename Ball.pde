class Ball 
{
  
  int radius;
  float x, y;
  float startX, startY;
  float speed;
  float angle;
  
  boolean pressed;
  
  Ball()
  {
    radius = 50;
    x = width/2;
    y = height/2;
    speed = 0;
    angle = random(360);
  }
  
  
  boolean mouseOver(int _mouseX, int _mouseY)
  {
    return dist(_mouseX, _mouseY, x, y) < radius;
    
  }
  
  
  void followMouse(int _mouseX, int _mouseY)
  {
    x = _mouseX;
    y = _mouseY;
  }
  
  
  void setPressed(int _mouseX, int _mouseY)
  {
    pressed = true; 
    speed = 0;
    startX = _mouseX;
    startY = _mouseY;
  }
  
  
  void setReleased()
  {
    if (pressed)
    {
      pressed = false; 
      speed = dist(x, y, startX, startY) / 2;
      angle = atan2(startY - y, startX - x);
    }
  }
  
  
  boolean getPressed()
  {
    return pressed;  
  }
  
  
  void angleNudge()
  {
    angle += randomGaussian();  
  }
  
  
  void updatePosition()
  {
    x += cos(angle) * speed;
    y += sin(angle) * speed;
    
   
  }
  
  
  void collisionDetect()
  {
    
    
    if (x < BORDER + radius)
    { 
      x = BORDER + radius;
      angle = PI - angle;
      
      audio.trigger(0, map(y, height - BORDER - radius, BORDER + radius, tempmin, tempmax));
    }
    
    else if (x > width - BORDER - radius)
    { 
      x = width - BORDER - radius;
      angle = PI - angle;
      
      audio.trigger(1, map(y, height - BORDER - radius, BORDER + radius, tempmin, tempmax));
    }
    
    if (y < BORDER + radius)
    { 
      y = BORDER + radius;
      angle = TAU - angle;
      
      audio.trigger(2, map(x, BORDER + radius, width - BORDER - radius, tempmin, tempmax));
      
    }
    else if (y > height - BORDER - radius) 
    { 
      y = height - BORDER - radius;
      angle = TAU - angle;
      
      audio.trigger(3, map(x, BORDER + radius, width - BORDER - radius, tempmin, tempmax));
    }
    
  }
  

  void display()
  {
    fill(200);
    ellipse(x, y, radius * 2, radius * 2);
    
    if (pressed)
    {
      stroke(150);
      line(x, y, startX, startY); 
    }
  }
  
}