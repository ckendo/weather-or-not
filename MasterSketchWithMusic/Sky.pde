class Sky extends DefaultSketch
{
  int Y_AXIS = 1;
  int X_AXIS = 2;
  color c1, c2, c3;
  color temp1, temp2;
  int currentDuration;
  float amt;
  int duration; //duration in seconds
  int thisSwapTime;
  color thisStart;
  color thisEnd;
  
  AudioPlayer song;
  
  Sky(color start, color end, int swapTime) //could have dropNum as input
  {
    duration = 10;

    // Define colors
    thisStart = start;
    thisEnd = end;
    thisSwapTime = swapTime;
  
    setGradient(0, 0, width, height, color(255, 255, 255), thisStart, Y_AXIS);

    amt = 0;
  }
  
  void Setup(){
    song = minim.loadFile("data/ambience1.wav");
  }
  
  void PlayAudio(){
    if (song != null){
      song.play((int)random(song.length()));
      song.loop();
      song.shiftGain(-80, 13, 1000); 
    }
  }
  
  void StopAudio(){
    if (song != null){
      song.shiftGain(song.getGain(), -80, 1000);
    }
  }

  //@Override
  void Draw()
  {
    setGradient(0, 0, width, height, temp1, temp2, Y_AXIS);

    int time = millis();
    if ((time - currentDuration) > thisSwapTime){
      temp1 = color(255, 255, 255);
      temp2 = lerpColor(thisStart, thisEnd, amt);
  
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
}