class Rain extends DefaultSketch
{
  Drop myDrop;
  ArrayList drops = new ArrayList();
  float current;
  float reseed = random(0, .2);
  //int dropNum = 100;
  int dropNum;
  float yOffset;
  float xOffset;
  
  AudioPlayer song;
  
  Rain(int numberDrops, float yOff, float xOff) //could have dropNum as input
  {
    background(0);
    dropNum = numberDrops;
    yOffset = yOff;
    xOffset = xOff;

    //setting size in main
    drops.add(new Drop());
    current = millis();
  }
  
  void Setup(){
    song = minim.loadFile("data/rain.wav");
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
    blur(20); //cahnge value for amount of dots left on screen
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
        if (rand>10 && drops.size()<dropNum){
            drops.add(new Drop());
        }
      }
    }
  }
  
  void blur(float trans){
    noStroke();
    fill(0, trans);
    rect(0,0, width,height);
  }
  
  public class Drop{
    PVector position, pposition, speed;
    float col;
    
    public Drop(){
      position = new PVector(random(-100,width+100), 0);
      pposition = position;
      speed = new PVector(0,0);
      col = random(100, 255); //random alpha (opacity)
    }
    
    void draw(){
      //stroke(255, col);
      //strokeWeight(2);
      //line(position.x, position.y, pposition.x, pposition.y);
      ellipse(position.x, position.y, 3, 3);
      fill(col);    
    }
    
    void calculate(){
      pposition = new PVector(position.x, position.y);
      gravity();
    }
    
    void gravity(){
      speed.y += yOffset; //.2; //speed increases as falls
      speed.x += xOffset; //.02; //positive makes rain go to right, neg to left. can be changed for degree of angle
      position.add(speed);
    }
  }
}