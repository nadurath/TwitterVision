LeapController r;
void setup(){
  size(800,600);
  //background(0);
  r = new LeapController();
  fill(255);
  rectMode(CENTER);
}
void draw(){
      background(0);
      stroke(255);
      rect(0,0,200,200);
      rect(width/2,height/2,(float)r.getDistance()/120*500,(float)r.getDistance()/120*500);
      println(r.getX());
    
}