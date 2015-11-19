/**
 * Simple Linear Gradient 
 */

// Constants
int Y_AXIS = 1;
int X_AXIS = 2;
color c1, c2, c3;
color temp1, temp2;
int currentDuration;
float amt;
int duration; //duration in seconds

void setup() {
  size(640, 360);
  duration = 10;

  // Define colors
  c1 = color(110, 219, 255);
  c2 = color(7, 0, 138);
  c3 = c1;
  
  setGradient(0, 0, width, height, color(255, 255, 255), c3, Y_AXIS);

  amt = 0;
  
  //noLoop();
}

void draw()
{
  setGradient(0, 0, width, height, temp1, temp2, Y_AXIS);

  int time = millis();
  if ((time - currentDuration) > 200){
    //background(c3);
    //c3 = lerpColor(c1, c2, amt);
    //temp2 = temp1;
    temp1 = color(255, 255, 255);
    temp2 = lerpColor(c1, c2, amt);

    amt += ((float) duration/1000);
    //c2 = color(random(0, 150), 35, 6);
    currentDuration = time;
  }
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}