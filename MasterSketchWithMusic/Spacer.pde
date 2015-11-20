class Spacer extends DefaultSketch
{
  
  AudioPlayer song;
  
  Spacer() //could have dropNum as input
  {
  }
  
  void Setup(){
    //song = minim.loadFile("data/ambience1.wav");
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
    background(0);
  }
}