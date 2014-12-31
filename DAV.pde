import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
AudioMetaData meta;
BeatDetect beat;
int  r = 200;
float rad = 70;

void setup()
{
  size(displayWidth, displayHeight);
  minim = new Minim(this);
  // change the mp3 source to change the mp3
  player = minim.loadFile("Aware.mp3");
  meta = player.getMetaData();
  beat = new BeatDetect();
  player.loop();
  background(-1);
  colorMode(RGB, 1);
  noCursor();
}

void draw()
{ 
  float t = map(mouseX, 0, width, 0, 1);
  beat.detect(player.mix);
  fill(#3ba4dc, 40);
  noStroke();
  rect(0, 0, width, height);
  translate(width/2, height/2);
  noFill();
  fill(1, 10);
  if (beat.isOnset()) rad = rad*0.9;
  else rad = 70;
  ellipse(0, 0, 2*rad, 2*rad);
  stroke(-1, 75);
  int bsize = player.bufferSize();
  for (int i = 0; i < bsize - 1; i+=5)
  {
    float x = (r)*cos(i*2*PI/bsize);
    float y = (r)*sin(i*2*PI/bsize);
    float x2 = (r + player.left.get(i)*100)*cos(i*2*PI/bsize);
    float y2 = (r + player.left.get(i)*100)*sin(i*2*PI/bsize);
    line(x, y, x2, y2);
  }
  beginShape();
  noFill();
  stroke(-1, 70);
  for (int i = 0; i < bsize; i+=30)
  {
    float x2 = (r + player.left.get(i)*100)*cos(i*2*PI/bsize);
    float y2 = (r + player.left.get(i)*100)*sin(i*2*PI/bsize);
    vertex(x2, y2);
    pushStyle();
    stroke(4);
    strokeWeight(2);
    point(x2, y2);
  }
  endShape();
}
boolean sketchFullScreen() {
  return true;
}

void keyPressed() {
  if(key==' ')exit();
  if(key=='s')saveFrame("###.jpeg");
}
