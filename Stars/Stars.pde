Drop myDrop;
ArrayList drops = new ArrayList();
float current;
float reseed = random(0, .2);
int dropNum = 100;

// set up function
void setup() {
  size(600, 600);
  background(0,0,30);
  /*
  xPos = 300;
  yPos = 0;
  speed = 0;
  up = 5;
  gravity = 0.2;
  drops = new ArrayList<Drop>();
  */
  //myDrop = new Drop(255, xPos, yPos);
  //myDrop.display();
  //drops.add(myDrop);
  drops.add(new Drop());
  current = millis();
}
 
// draw function
void draw() {
  blur(30); //cahnge value for amount of dots left on screen
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
  
  //xPos = int(random(0, 600));
  //display ball
  //background(0);
  //fill(255);
  
  //myDrop = new Drop(255, xPos, yPos, 5, up);
  //myDrop.display();
  
  //drops.add(myDrop);
  /*for (Drop drop : drops){
    //drop.display();
  }*/
  
  //ellipse(xPos, yPos, 5, 5);
 
  //display ground
  //fill(255);
  //noStroke();
  //rect(0, 530, 600, 200);
 
  // Site from www.learningprocessing.com
  //yPos = yPos + speed;
  //speed = speed + gravity;
  //up = up + gravity*4;
   
}

void blur(float trans){
  noStroke();
  fill(0,0,30, trans);
  rect(0,0, width,height);
}