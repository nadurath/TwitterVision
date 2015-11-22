ArrayList<Node> nodeList = new ArrayList<Node>();
Map<String,String> hashtags;
ArrayList<String> keywords = new ArrayList<String>();
boolean animating = false;
boolean panimation = false;
float zoomX;
float zoomY;
float frame;
int backR;
int backG;
int backB;
float springAmount;
boolean springAnimation;
Node nodeClicked;
LeapController leap;

import java.io.*;
import java.util.*;

void setup()
{
  leap = new LeapController();
  size(800, 800);
  TweetCrawler tc = new TweetCrawler();
  hashtags = tc.search("#yolo");
  Collection<String> values = hashtags.values();
  Object[] tweetVals = values.toArray();
  for(Object o: tweetVals)
    keywords.add((String)o);
  println(values);
  recreateNode();
  repopulate(keywords, 125);
  
}

void draw()
{
  pushStyle();
  fill(255,0,0);
  ellipse(leap.getX(),leap.getY(),5,5);
  popStyle();
  if (animating)
  {
    if (frame < 30)
    {
      fill(nodeClicked.getR(), nodeClicked.getG(), nodeClicked.getB());
      //println(frame);
      ellipse(nodeClicked.getX(), nodeClicked.getY(), 100*frame/30*20, 100*frame/30*20);//change 40 if it grows too fast
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
      println("Something");
      //rect(width/2, height/2, 40-40*(40-frame)/40*cos((frame/40*PI*4)%(2*PI)), 40-40*(40-frame)/40*cos((frame/40*PI*4)%(2*PI)));
      //textSize(48*frame/40+1);
      animating = false;
      //nodeList = new ArrayList<Node>();
      frame++;
    }
  } else
    repopulate(keywords, 125);
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
  void drawNode(float x, float y,int sz)
  {

    xLoc = x;
    yLoc = y;
    fill(this.r, this.g, this. b);
    stroke(r/2, g/2, b/2);
    strokeWeight(5);
    textSize(sz/6);
    ellipse(xLoc, yLoc, sz, sz);
    textAlign(CENTER);
    textR = r/2;
    textG = g/2;
    textB = b/2;
    fill(textR, textG, textB);
    if(keyword.length() > 0)
      text(keyword.replace("\n"," "), xLoc, yLoc);
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
  if (!animating)
  {
    for (Node a : nodeList)
    {
      //println(a.getText() + "," + a.getX() + "," + a.getY());
      if (dist(mouseX, mouseY, a.getX(), a.getY()) < 75)
      {
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
  for (int i = 0; i<15; i++)
  {
    Node n1 = new Node();
    nodeList.add(n1);
  }
  for (Node a:nodeList)
  {
    a.setText(keywords.get((int)random(keywords.size())));
    //a.setR((int)(random(255)+(255*2))/3);
    //a.setG((int)(random(255)+(255*2))/3);
    //a.setB((int)(random(255)+(255*2))/3);
  }
}

void repopulate(ArrayList<String> related, int sz)
{
  if (springAnimation)
    println(sz);
  animating = false;
  if (nodeClicked == null)
    background(100);
  else
    background(nodeClicked.getR(), nodeClicked.getG(), nodeClicked.getB());
  pushMatrix();
  translate(width/2, height/2);
  for (int i=0; i<15; i++)
  {
    float posx=325*sin(TWO_PI/15.0*i);
    float posy=325*cos(TWO_PI/15.0*i);
    //draw object number i
    nodeList.get(i).drawNode(posx, posy,sz);
  }
  popMatrix();
}

void keyReleased()
{
  if (key == DELETE)
  {
    recreateNode();
    repopulate(keywords, 125);
  }
}