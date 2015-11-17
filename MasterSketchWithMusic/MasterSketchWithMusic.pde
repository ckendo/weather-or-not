import ddf.minim.*;

ArrayList sketches = new ArrayList();
Sketch currentSketch;
int currentSketchIdx;
int currentDuration;
boolean newStart; //if a sketch is just starting

Minim minim;

interface Sketch
{
  public void Draw();
  public int GetDuration();
  public void SetDuration(int d);
  public void Setup();//TODO:REMOVE();
  public void PlayAudio();
  public void StopAudio();
}

abstract class DefaultSketch implements Sketch
{
  protected int m_duration = 10;

  public abstract void Setup();
  
  public abstract void PlayAudio();
  
  public abstract void StopAudio();
  
  public abstract void Draw();
  //@Override
  public int GetDuration()
  {
    return m_duration;
  }
  //@Override
  public void SetDuration(int d)
  {
    m_duration = d;
  }
}

void setup()
{
  //fullScreen();
  size(600, 600);
  
  minim = new Minim(this);
  
  newStart = true;
  
  Sketch dr1 = new Rain(100, .2, .02); //takes in number of drops
  dr1.SetDuration(5);
  sketches.add(dr1);
  
  Sketch dr2 = new Stars(100, .1, 900, color(255, 255, 150)); //drops, speed, direction/curve
  dr2.SetDuration(5);
  sketches.add(dr2);
  
  Sketch dr3 = new Lightning();
  dr3.SetDuration(5);
  sketches.add(dr3);  
  
  Sketch dr5 = new Rain(300, .2, -.04); //takes in number of drops
  dr5.SetDuration(5);
  sketches.add(dr5);
  
  Sketch dr4 = new Stars(200, .8, -400, color(255, 219, 226)); //drops, speed, direction/curve
  dr4.SetDuration(5);
  sketches.add(dr4);
  
  Sketch dr6 = new Lightning();
  dr6.SetDuration(5);
  sketches.add(dr6);  
  
  Sketch dr7 = new Rain(100, .7, .08); //takes in number of drops
  dr7.SetDuration(5);
  sketches.add(dr7);
  
  Sketch dr8 = new Stars(200, 5, 100, color(5, 123, 181)); //drops, speed, direction/curve
  dr8.SetDuration(5);
  sketches.add(dr8);
}

void draw()
{
  currentSketch = (Sketch) sketches.get(currentSketchIdx);

  if (newStart){
    currentSketch.Setup();
    currentSketch.PlayAudio();
    newStart = false;
  }
  
  currentSketch.Draw();
  int time = millis() / 1000;
  if (time - currentDuration > currentSketch.GetDuration())
  {
    currentSketch.StopAudio();  
    
    currentSketchIdx++;
    currentDuration = time;
    if (currentSketchIdx == sketches.size())
    {
      //noLoop();
      currentSketchIdx = 0; //start from the beginning
    }
    //currentSketch = (Sketch) sketches.get(currentSketchIdx);
    
    newStart = true;
  }
}