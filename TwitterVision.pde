ArrayList<Node> nodeList = new ArrayList<Node>();
Map<String, String> hashtags;
Map<String, String> tweets;
ArrayList<String> keywords = new ArrayList<String>();
boolean animating = false;
boolean panimation = false;
float zoomX;
float zoomY;
float frame;
int backR;
int backG;
int backB;
int rayCount;
Trends trends;
TweetCrawler tc;
float springAmount;
boolean springAnimation, closed;
Node nodeClicked;
LeapController leap;
Tweet TOne, TTwo, TThree;
ArrayList<Integer> woeids = new ArrayList<Integer>();
import java.io.*;
import java.util.*;


void setup()
{
  woeids.add(23424977); //USA
  woeids.add(2490383); //Seattle, works
  woeids.add(2487956); //San Francisco, works
  closed = false;
  //leap = new LeapController();
  size(1000, 900);
  tc = new TweetCrawler();
  println(keywords);
  recreateNode();
  repopulate(keywords, 125);
}

void draw()
{
  if (trends!=null)
  {
    for (int i = 0; i < trends.getTrends().length; i++) {
      keywords.add(trends.getTrends()[i].getName());
    }
  }
  /*if (leap.getDistance()<50&&!closed) {
   println("closed");
   closed = true;
   } else if (leap.getDistance()>50&&closed)
   {
   println("opened");
   closed = false;
   click((int)map(leap.getX(), -120, 62, 0, width), (int)map(leap.getY(), 75, 250, height, 0));
   }*/
  if (animating)
  {
    if (frame < 30)
    {
      fill(nodeClicked.getR(), nodeClicked.getG(), nodeClicked.getB());
      //println(frame);
      ellipse(nodeClicked.getX(), nodeClicked.getY(), 100*frame/30*22, 100*frame/30*22);
      fill(0);

      frame++;
      if (frame > 30)
        repopulate(keywords, 325);
    } else
    {
      animating = false;
      frame = 0;
      recreateNode();
      springAnimation = true;
    }
  } else if (springAnimation) 
  {
    if (frame>40)
    {
      frame = 0;
      springAnimation = false;
    } else {
      background(nodeClicked.getR(), nodeClicked.getG(), nodeClicked.getB());
      repopulate(keywords, (int)(125-125*(40-frame)/40*cos((frame/40*PI*4)%(2*PI))));
      //rect(width/2, height/2, 40-40*(40-frame)/40*cos((frame/40*PI*4)%(2*PI)), 40-40*(40-frame)/40*cos((frame/40*PI*4)%(2*PI)));
      //textSize(48*frame/40+1);
      animating = false;
      //nodeList = new ArrayList<Node>();
      frame++;
      fill(0);
    }
  } else
    repopulate(keywords, 125);
  pushStyle();
  stroke(255, 0, 0);
  //ellipse(map(leap.getX(), -120, 62, 0, width), map(leap.getY(), 75, 250, height, 0), 5, 5); 
  popStyle();
}

class Tweet {
  String user, body;
  PImage avi;
  Tweet(String s, String b, PImage p) {
    user = s;
    body = b;
    avi = p;
    avi.resize(50, 50);
  }
  PImage getAvi() {
    return avi;
  }
}
class Node
{
  String keyword;
  float xLoc;
  float yLoc;
  float size;
  int r;
  int g;
  int b;
  int textR;
  int textB;
  int textG;

  Node()
  {
    keyword = "";
    size = 125;
    r = (int)(random(255)+(255*2))/3;
    g = (int)(random(255)+(255*2))/3;
    b = (int)(random(255)+(255*2))/3;
  }

  Node(String s, float x, float y, float sz)
  {
    keyword = s;
    xLoc = x;
    yLoc = y;
    size = sz;
  }

  Node(float x, float y, float sz)
  {
    keyword = "";
    xLoc = x;
    yLoc = y;
    size = sz;
  }

  void setText(String s)
  {
    keyword = s;
  }
  void drawNode(float x, float y, int sz)
  {

    xLoc = x;
    yLoc = y;
    fill(this.r, this.g, this. b);
    stroke(r/2, g/2, b/2);
    strokeWeight(5);
    textSize(sz/6);
    ellipse(xLoc, yLoc-10, sz, sz);
    textAlign(CENTER);
    textR = r/2;
    textG = g/2;
    textB = b/2;
    fill(textR, textG, textB);
    if (keyword.length() > 0)
      text(keyword.replace("\n", " "), xLoc-70, yLoc-40, 130, 150);
  }

  float getX()
  {
    return xLoc+(width/2);
  }

  float getY()
  {
    return yLoc+(height/2);
  }

  String getText()
  {
    return keyword;
  }

  int getR()
  {
    return r;
  }
  int getG()
  {
    return g;
  }
  int getB()
  {
    return b;
  }
  void setR(int re)
  {
    r = re;
  }
  void setG(int gr)
  {
    g = gr;
  }
  void setB(int bl)
  {
    b = bl;
  }
}


void mouseClicked()
{
  click(mouseX, mouseY);
}

void click(int x, int y) {
  if (!animating)
  {
    for (Node a : nodeList)
    {
      //println(a.getText() + "," + a.getX() + "," + a.getY());
      if (dist(x, y, a.getX(), a.getY()) < 75)
      {
        println("click recieved");
        panimation = true;
        zoomX = a.getX();
        zoomY = a.getY();
        println(a.getText());
        backR = a.getR();
        backG = a.getG();
        backB = a.getB();
        nodeClicked = a;
        animating = true;
        frame = 0;
      }
    }
  }
}



void recreateNode()
{ 
  trends = tc.getTrends(woeids.get((int)random(woeids.size())));
  keywords = new ArrayList<String>();
  if (trends!=null)
  {
    for (int i = 0; i < trends.getTrends().length; i++) {
      keywords.add(trends.getTrends()[i].getName());
    }
  } else
    for (int i = 0; i<10; i++)
      keywords.add("Error: Rate limit exceeded.");
  for (int i = 0; i<10; i++)
  {
    Node n1 = new Node();
    nodeList.add(n1);
  }
  rayCount = 0;
  for (int i = 0; i<10; i++)
  {
    nodeList.get(i).setText(keywords.get(i));
  }
  if (nodeClicked!=null)
  {
    tweets = tc.search(nodeClicked.getText());
    TOne = new Tweet((String)tweets.keySet().toArray()[0], tweets.get((String)tweets.keySet().toArray()[0]), loadImage(tc.getPic((String)tweets.keySet().toArray()[0])));
    TTwo = new Tweet((String)tweets.keySet().toArray()[1], tweets.get((String)tweets.keySet().toArray()[1]), loadImage(tc.getPic((String)tweets.keySet().toArray()[1])));
    TThree = new Tweet((String)tweets.keySet().toArray()[2], tweets.get((String)tweets.keySet().toArray()[2]), loadImage(tc.getPic((String)tweets.keySet().toArray()[2])));
  }
  rayCount = 0;
}

void repopulate(ArrayList<String> related, int sz)
{
  if (springAnimation)
    println(sz);
  animating = false;
  if (nodeClicked == null)
    background(255);
  else
  {
    background(nodeClicked.getR(), nodeClicked.getG(), nodeClicked.getB());
    fill(nodeClicked.getR(), nodeClicked.getG(), nodeClicked.getB());
    ellipse(width/2, height/2, 600, 600);
    fill(0);
    String rel = nodeClicked.getText();
    text(rel, width/2, height/2-200);
    textAlign(LEFT);
    String user = (String)tweets.keySet().toArray()[0];
    showTweet(width/2+20, height/2-140, user, tweets.get(user), TOne.getAvi());
    user = (String)tweets.keySet().toArray()[1];
    showTweet(width/2+20, height/2, user, tweets.get(user), TTwo.getAvi());
    user = (String)tweets.keySet().toArray()[2];
    showTweet(width/2+20, height/2+120, user, tweets.get(user), TThree.getAvi());
  }
  pushMatrix();
  translate(width/2, height/2);
  for (int i=0; i<10; i++)
  {
    float posx=325*sin(TWO_PI/10.0*i);
    float posy=325*cos(TWO_PI/10.0*i);
    //draw object number i
    nodeList.get(i).drawNode(posx, posy, sz);
  }
  popMatrix();
}
void showTweet(int x, int y, String user, String body, PImage avi) {
  pushStyle();
  fill(255, 0, 0);
  text(user, x-200, y);
  fill(0);
  textSize(12);
  text(body.replace("\n", " "), x-140, y+10, 300, 300);
  image(avi, x-200, y+10);
  popStyle();
}
void keyReleased()
{
  if (key == DELETE)
  {
    nodeClicked = null;
    recreateNode();
    repopulate(keywords, 125);
  }
}