class Northern extends DefaultSketch
{
  
  AudioPlayer song;
  int numPoints = 70000;
 
  int[] x;
  int[] y;
   
  int circ = 0;
  int sqr = 30;
  float c;
  float c1;
  float c2;
  int currentDuration;
   
  int xPosition;
  int yPosition;
 
  Northern()
  {
  }
  
  void Setup(){
    song = minim.loadFile("data/stars2.mp3");
    x = new int[numPoints];
    y = new int[numPoints]; 
    xPosition = (int) random(0, width/2);
    yPosition = (int) random(0, height/2);
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
    smooth();
 
    background(0,0,30);
    noStroke();
    c= random(0, 800);
    c1 = random(0,255);
    c2= random(0,600);
       
    //if ( mousePressed ) {
    int time = millis();
    if (time - currentDuration > 50){
      
        x[circ] = xPosition;
        y[circ] = yPosition;
        
        if (circ <= 15000){
          xPosition += random(1, 5);
          yPosition += random(-15, 15);
        } else if (circ > 15000 && circ <= 30000){
          xPosition -= random(1, 5);
          yPosition += random(-15, 18);
        } else if (circ > 30000 && circ <= 35000){
          xPosition -= random(1, 5);
          yPosition -= random(-15, 18);
        } else if (circ > 35000 && circ <= 55000){
          xPosition += random(1, 5);
          yPosition += random(-16, 14);
        } else if (circ > 55000 && circ <= numPoints){
          xPosition += random(1, 5);
          yPosition -= random(-16, 14);
        }
        
        circ += 100;
        sqr += 1;
        
        if ( circ == numPoints ) {
          circ = 100;
          xPosition = (int) random(300, 600);
          yPosition = (int) random(150, 450);
        }
        if ( sqr >= 730 ) {
          sqr = 30;
        }
          currentDuration = time;
      }
    //}
    
    int i = 0;
    while ( i <= circ ) {
      if (i <= 20000){
        ellipse( c, c2, 1, 1 );
        ellipse( x[i], y[i], 2,sqr );
        i = i + 20;
        fill(255, 131, 250, 127);
      } else if ((i > 2000) && (i <= 40000)) {
        ellipse( c, c2, 1, 1 );
        ellipse( x[i], y[i], 2, sqr );
        i = i + 20;
        fill(0, 255, 255, 127);
      } else if ((i > 40000) && (i < numPoints)) {
        ellipse( c, c2, 1, 1 );
        ellipse( x[i], y[i], 2, sqr );
        i = i + 20;
        fill(127, 255, 212, 127);
      } else if(i == numPoints){
        i = 0;
      }
    }
  }
}