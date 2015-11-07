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
  float col;
  
  public Drop(){
    position = new PVector(random(0,width), 0);
    pposition = position;
    speed = new PVector(0,0);
    col = random(100, 255); //random alpha (opacity)
  }
  
  void draw(){
    stroke(255, col);
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
    speed.y += .2; //speed increases as falls
    speed.x += .02; //positive makes rain go to right, neg to left. can be changed for degree of angle
    position.add(speed);
  }
}