PImage blueberry;
PImage bg, topPipe, botPipe;
int y, Vy, bgx;
boolean gameState;
int[] px, py;
int score = 0;
import processing.sound.*;
SoundFile file, splat;

void setup(){
  size(600, 600);
  blueberry = loadImage("blueberry.PNG");
  bg = loadImage("pancakes.PNG");
  topPipe = loadImage("bluePipe2.png");
  botPipe = loadImage("bluePipe.png");
  file = new SoundFile(this, "squeak.mp3");
  splat = new SoundFile(this, "splat.mp3");
  Vy = 0;
  y = 0;
  score = 0;
  px = new int[3];
  py = new int[3];
  for (int i = 0; i < 3; i++) {
    px[i] = width + width/3*i;
    py[i] = int(random(200, height-200));
  }
  gameState = true;
}
void draw() {
  if (gameState){
    BG();
    blueberry();
    pipes();
    checkCrash();
    counter();
  }
}

void checkCrash() {
  for (int i = 0; i <px.length; i++) {
    if (px[i]< 75 + blueberry.width && px[i]> 35 && y - py[i]> 110) {
      gameState = false;
      splat.play();
      background(0);
      fill(255);
      textSize(50);
      text("You lost", 200, 200);
      text("Restart", 210, 400);
    }
    if (px[i]< 75 + blueberry.width && px[i]> 35 && py[i]- y > 110) {
      gameState = false;
      splat.play();
      background(0);
      fill(255);
      textSize(50);
      text("You lost", 200, 200);
      text("Restart", 210, 400);
    }
  }
}
void counter() {
  fill(255);
  textSize(25);
  text("Score: " + score, 10, 30);
}
void pipes() {
  for (int i = 0; i < px.length; i++) {
    px[i] = px[i] - 3;
    image(topPipe, px[i]-25, py[i] - topPipe.height-100);
    image(botPipe, px[i]-25, py[i] + 100);
    if (px[i] < -50) {
      px[i]= width + 50;
      py[i]= int(random(100, height-100));
      score++;
    }
  }
}
void BG() {
  image(bg, bgx, 0, width, height);
  image(bg, bgx + width, 0, width, height);
  bgx-=1; //bgx = bgx - 1
  if (bgx < -width) {
    bgx = 0;
  }
}
void blueberry() {
  image(blueberry, 50, y);
  y += Vy;
  Vy++;
  if (y > height-blueberry.height) {
    y = height-blueberry.height;
  }
}
void mousePressed() {
  if (!gameState) {
    if (mouseX>210 && mouseX < 410 && mouseY>400 && mouseY <450) {
      setup();
      gameState = true;
    }
  } else {
    file.play();
    Vy = -13;
  }
}
void Start() {
  background(34);
  fill(0);
  textSize(100);
  text("Start", 300, 300);
}
