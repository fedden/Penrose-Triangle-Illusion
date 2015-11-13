class Square {
  
  color left,right,top;
  int size;
  PVector midPoint;
  
  Square(color _left, color _right, color _top, int _size) {
    left = _left;
    right = _right;
    top = _top;
    midPoint = new PVector(0,0);
    size = _size;
  }
  
  void update(PVector _mid) {
    //update midpoint to where we want it to be
    midPoint.set(_mid);  
  }
  
  void display(int _size) {
    noStroke();
    
    size = _size;
    
    //left side
    fill(left);
    beginShape();
    vertex(midPoint.x,midPoint.y + size);
    vertex(midPoint.x,midPoint.y);
    vertex(midPoint.x - cos(radians(30)) * size, midPoint.y  - sin(radians(30)) * size);
    vertex(midPoint.x - cos(radians(30)) * size, midPoint.y - sin(radians(30)) * size + size);
    endShape(CLOSE);
    
    //right side
    fill(right);
    beginShape();
    vertex(midPoint.x,midPoint.y + size);
    vertex(midPoint.x,midPoint.y);
    vertex(midPoint.x + cos(radians(30)) * size, midPoint.y - sin(radians(30)) * size);
    vertex(midPoint.x + cos(radians(30)) * size, midPoint.y - sin(radians(30)) * size + size);
    endShape(CLOSE);
    
    //top side    
    fill(top);
    beginShape();
    vertex(midPoint.x,midPoint.y - size);
    vertex(midPoint.x - cos(radians(30)) * size, midPoint.y + sin(radians(30)) * size - size);
    vertex(midPoint.x,midPoint.y);
    vertex(midPoint.x + cos(radians(30)) * size, midPoint.y + sin(radians(30)) * size - size);
    endShape(CLOSE);
  }
}