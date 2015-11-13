// By Leon Fedden 2015

// Set colours
final color colorBackground = #FFF07A;
final color colorLeft = #5F233F;
final color colorRight = #AB3124;
final color colorTop = #D69830;

// Set Square size
int squareSize = 100;

// Set amount (not implimented properly yet (don't modify this)
final int amt = 9;

// Our array of squares
Square[] squares; 

// The midpoints of each square
PVector[] points;

// Distance between squares
int gridDist = 150; 

// How far the squares are linearily interpolated from their two points
float lerpAmount = 0;

// So the user can pause the animation
boolean paused = false;

// Declare slider
HScrollbar hs1, hs2;

void setup() {
  // Size
  size(800, 800);

  // Init arrays
  squares = new Square[amt];
  points = new PVector[amt];

  // Init square objects in the array
  for (int i = 0; i < amt; i++) {
    squares[i] = new Square(colorLeft, colorRight, colorTop, squareSize);
  }

  // Init scroll bar
  hs1 = new HScrollbar(width-width/4, height/8, width/4, 20, 16,false);
  hs2 = new HScrollbar(width-width/4, height/8 + 80, width/4, 20, 16,true);
  
  // For the text
  textAlign(CENTER);
}

void draw() {
  // Help text
  background(colorBackground);
  fill(colorTop);
  textSize(20);
  if (paused) {
    text("Press Any Key To Resume", width/2, 40);
  } else {
    text("Press Any Key To Pause", width/2, 40);
  }
  
  // Text for slider
  textSize(15);
  text("SPACING", width-168, 86);
  text("SIZE", width-185, 166);

  // Centre it a little depending on gridSize
  pushMatrix();
  translate(map(gridDist, 150, 200, 75, -50), map(gridDist, 150, 200, 0, -125));

  // Run the Penrose Triangle
  run();
  popMatrix();

  gridDist = floor(map(hs1.getPos(), 0, 1, 150, 200));
  squareSize = floor(map(hs2.getPos(), 0, 1, 70, 100));

  // Run the Sliderz
  hs1.update();
  hs1.display();
  hs2.update();
  hs2.display();
}

void keyPressed() {
  // Pause
  paused = !paused;
}

void run() {
  // If not paused increment lerp
  lerpAmount = (paused) ? lerpAmount : lerpAmount + 0.003;

  // Lerp around triangle grid
  points[0] = new PVector(lerp(gridDist, gridDist,                           lerpAmount), lerp(gridDist*3, gridDist*2, lerpAmount));
  points[1] = new PVector(lerp(gridDist, gridDist,                           lerpAmount), lerp(gridDist*2, gridDist, lerpAmount));
  points[2] = new PVector(lerp(gridDist, gridDist+cos(radians(30))*gridDist, lerpAmount), lerp(gridDist  , gridDist+sin(radians(30))*gridDist, lerpAmount));
  
  points[3] = new PVector(lerp(gridDist+cos(radians(30))*gridDist, gridDist+cos(radians(30))*gridDist*2, lerpAmount), lerp(gridDist+sin(radians(30))*gridDist, gridDist*2, lerpAmount));
  points[4] = new PVector(lerp(gridDist+cos(radians(30))*gridDist*2, gridDist+cos(radians(30))*gridDist*3, lerpAmount), lerp(gridDist*2, gridDist*2+sin(radians(30))*gridDist, lerpAmount));
  points[5] = new PVector(lerp(gridDist+cos(radians(30))*gridDist*3, gridDist+cos(radians(30))*gridDist*2, lerpAmount), lerp(gridDist*2+sin(radians(30))*gridDist, gridDist*3, lerpAmount));
  
  points[6] = new PVector(lerp(gridDist+cos(radians(30))*gridDist*2, gridDist+cos(radians(30))*gridDist, lerpAmount), lerp(gridDist*3, gridDist*3+sin(radians(30))*gridDist, lerpAmount));
  points[7] = new PVector(lerp(gridDist+cos(radians(30))*gridDist, gridDist, lerpAmount), lerp(gridDist*3+sin(radians(30))*gridDist, gridDist*4, lerpAmount));
  points[8] = new PVector(lerp(gridDist, gridDist, lerpAmount), lerp(gridDist*4, gridDist*3, lerpAmount));

  // Loop through 9 points
  for (int i = 0; i < 9; i++) {
    // Set the points to the CORRECT squares

    squares[i].update(points[i]);
    squares[i].display(squareSize);
  }

  // Depending on lerp position reset to 0
  if (lerpAmount > 1) { 
    lerpAmount = 0;
  }

  // Cover a nasty bit on the right
  fill(squares[0].right);
  beginShape();
  vertex(squares[0].midPoint.x, squares[0].midPoint.y + squares[0].size);
  vertex(squares[0].midPoint.x, squares[0].midPoint.y + squares[0].size/2);
  vertex(squares[0].midPoint.x + cos(radians(30)) * squares[0].size, squares[0].midPoint.y - sin(radians(30)) * squares[0].size + squares[0].size/2);
  vertex(squares[0].midPoint.x + cos(radians(30)) * squares[0].size, squares[0].midPoint.y - sin(radians(30)) * squares[0].size + squares[0].size);
  endShape(CLOSE);
  
  // And the left side too
  fill(squares[0].left);
  beginShape();
  vertex(squares[0].midPoint.x, squares[0].midPoint.y + squares[0].size);
  vertex(squares[0].midPoint.x, squares[0].midPoint.y + squares[0].size/2);
  vertex(squares[0].midPoint.x - cos(radians(30)) * squares[0].size, squares[0].midPoint.y  - sin(radians(30)) * squares[0].size + squares[0].size/2);
  vertex(squares[0].midPoint.x - cos(radians(30)) * squares[0].size, squares[0].midPoint.y - sin(radians(30)) * squares[0].size + squares[0].size);
  endShape(CLOSE);
}