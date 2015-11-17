class Stars extends DefaultSketch
{
  Drop myDrop;
  ArrayList drops = new ArrayList();
  float current;
  float reseed = random(0, .2);
  //int dropNum = 100;
  int dropNum;
  float yOffset;
  int xDivisor;
  color starColor;
  AudioPlayer song;
  
  Stars(int numOfDrops, float yOff, int xDiv, color dropColor) //could have dropNum as input
  {
    //background(0, 0, 30);
    dropNum = numOfDrops;
    yOffset= yOff;
    xDivisor = xDiv;
    starColor = dropColor;

    //setting size in main
    /*drops.add(new Drop());
    current = millis();*/
  }
  
  void Setup(){
    background(0, 0, 30);
    drops.add(new Drop());
    current = millis();
    
    song = minim.loadFile("data/starsblurpad.wav");
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
      blur(30); //cahnge value for amount ofts left on screen
      if((millis()-current)/1000>reseed&& drops.size()<dropNum){
        drops.add(new Drop());
        float reseed = random(0, .2);
        current = millis();
      }
      for (int i = 0; i < drops.size(); i++){
        Drop dropT = (Drop) drops.get(i); //get rain at index from ArrayList
        dropT.calculate();
        dropT.draw();
        if (dropT.position.y>height){
          
          drops.remove(i);
          float rand = random(0,100);
          if (rand>5 && drops.size()<dropNum){
              drops.add(new Drop());
          }
        }
      }
  }
  
  void blur(float trans){
    noStroke();
    fill(0,0,30, trans);
    rect(0,0, width,height);
  }
  
  public class Drop{
    PVector position, pposition, speed;
    float col, xposition;
    
    public Drop(){
      xposition = random(-width - 300,width);
      //position = new PVector(random(-400,width), 0);
      position = new PVector(xposition, 0);
      pposition = position;
      speed = new PVector(0,0);
      col = random(100, 255); //random alpha (opacity)
    }
    
    void draw(){
      stroke(starColor, col);//stroke(255,255,150, col);
      strokeWeight(2);
      line(position.x, position.y, pposition.x, pposition.y);
      //ellipse(position.x, position.y, 3, 3);
      //fill(col);    
    }
    
    void calculate(){
      pposition = new PVector(position.x, position.y);
      gravity();
    }
    
    void gravity(){
      speed.y += yOffset; //.1; //speed increases as falls
      speed.x += position.y/xDivisor; //position.y/900;
    
      position.add(speed);
    }
  }
}