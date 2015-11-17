public class Drop{
  /*color c;
  float xpos;
  float ypos;
  float across;
  float up;*/
  /*
  public Drop(color tempC, float tempXpos, float tempYpos, float tempWidth, float tempHeight){
      c = tempC;
      xpos = tempXpos;
      ypos = tempYpos;
      across = tempWidth;
      up = tempHeight;
  }
  
  void display(){
    //ellipseMode(CENTER);
    fill(c);
    ellipse(xpos, ypos, 5, up);
  }
  */
  
  PVector position, pposition, speed;
  float col, xposition;
  
  public Drop(){
    xposition = random(-width - 300,width);
   // position = new PVector(random(-400,width), 0);
    position = new PVector(xposition, 0);
    pposition = position;
    speed = new PVector(0,0);
    col = random(100, 255); //random alpha (opacity)
  }
  
  void draw(){
    stroke(255,255,150, col);
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
    speed.y += .1; //speed increases as falls
    //bends
    //if(position.y <200){
    // speed.x += .07; //positive makes rain go to right, neg to left. can be changed for degree of angle
    //} else {
    // speed.x += -.07;
    //}
    
    //changes direction everytime crosses middle
    //if(position.x <300){
    //speed.x += position.y/600;
    //} else {
    //speed.x += -position.y/600;
    //}
   
    //crosses once in middle
    //if(xposition <300){
    //speed.x += position.y/600;
    //} else {
    //speed.x += -position.y/600;
    //}
   
    //increases x velocity as y velocity increases
    speed.x += position.y/900;
    
    position.add(speed);
  }
}