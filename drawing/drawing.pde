//Ronald Liu
//paint app
PImage meme; //image for the stamp tool
float memeS; //size of the stamp
boolean isOnMeme; //if stamp tool is on or off
int w = 1100, h = 800, UIHeight = 100, UILineHeight = 5; //
float onef = map(2, 1, 5, 0, UIHeight), twof = map(3, 1, 5, 0, UIHeight), threef = map(4, 1, 5, 0, UIHeight); //slice the UI in 5, onef is the second line, twof is the middle, and threef is the 4th line
Slider sRed = new Slider(onef, 48, 48+100, 10, 0, 255), sGreen = new Slider(twof, 48, 48+100, 10, 0, 255), sBlue = new Slider(threef, 48, 48+100, 10, 0, 255), sWidth = new Slider(twof, 950, 950+100, 10, 20, 100);//the sliders
Color red = new Color(255, 0, 0), green = new Color(0, 255, 0), blue = new Color(0, 0, 255), pink = new Color(255, 0, 255), yellow   = new Color(255, 255, 0), lightblue = new Color(0, 255, 255), pinkish = new Color(255, 128, 128);
Color lightgreen = new Color(128, 255, 128), purple = new Color(128, 128, 255), white = new Color(255, 255, 255), black = new Color(0, 0, 0), grey = new Color(128, 128, 128); //the colors used 
color indicator; //indicator's color
ArrayList<ColorButton> colorButtons = new ArrayList<ColorButton>(); 
void setup() {
  size(1100, 800);
  colorButtons.add(new ColorButton(200, twof, twof, white)); //add all the color button's into an array list 
  colorButtons.add(new ColorButton(250, twof, twof, black));
  colorButtons.add(new ColorButton(300, twof, twof, red));
  colorButtons.add(new ColorButton(350, twof, twof, green));
  colorButtons.add(new ColorButton(400, twof, twof, blue));
  colorButtons.add(new ColorButton(450, twof, twof, pink));
  colorButtons.add(new ColorButton(500, twof, twof, yellow));
  colorButtons.add(new ColorButton(550, twof, twof, lightblue));
  background(255);
  textSize(22);
  textAlign(CENTER, CENTER);
  meme = loadImage("3.png"); //load image
  isOnMeme = false;
}
void draw() {
  noStroke();
  fill(200); // grey
  rect(0, 0, width, UIHeight); //white rect
  fill(0); //black 
  rect(0, UIHeight, width, UILineHeight); //black line 
  fill(255, 0, 0); //red
  text("R", 24, onef-2); 
  fill(0, 255, 0);
  text("G", 24, twof-2);
  fill(0, 0, 255);
  text("B", 24, threef-2); //text for rgb
  sRed.update(); //update sliders
  sBlue.update();
  sGreen.update();
  sWidth.update();
  if (isOnMeme) { //if stamp tool is on
    image(meme, 775-memeS/2, twof-memeS/2, memeS, memeS); //draw the stamp in the indicator spot
  } else {
    indicator = color(sRed.value, sGreen.value, sBlue.value); //indicator's color sets to the color picked
    fill(indicator);
    stroke(indicator);
    strokeWeight(sWidth.value); 
    line(775, twof, 775, twof); //draw the indicator
  }
  for (ColorButton cb : colorButtons) { //all the color buttons
    cb.update();
  }
  //image 
  fill(255);
  //meme button
  stroke(0);
  if (mouseX>840&&mouseX<840+twof+20&mouseY>onef-10&&mouseY<onef-10f+twof+20) stroke(255, 255, 0); //stamp tool tactile
  rect(850-10, onef-10, twof+20, twof+20);
  image(meme, 850, onef, twof, twof);
  strokeWeight(5);
  if (mouseX>600&&mouseX<700&mouseY>onef&&mouseY<onef+twof) stroke(grey.c); //new button tactile
  else stroke(black.c);
  fill(white.c); 
  rect(600, onef, 100, twof); //new button
  fill(black.c); 
  text("NEW", 600+50f, twof); 
  memeS = sWidth.value; //set the size to the slider's value
  stroke(sRed.value, sGreen.value, sBlue.value);
  strokeWeight(sWidth.value);
}
void mouseClicked() {
  for (ColorButton cb : colorButtons) cb.clicked(); //check each button
  if (mouseX>600&&mouseX<700&mouseY>onef&&mouseY<onef+twof) { //check if the new button is clicked
    stroke(255);
    fill(255);
    rect(0, 129, w, h);
  }
}
void mouseDragged() { 
  if (isOnMeme) image(meme, mouseX-memeS/2, mouseY-memeS/2, memeS, memeS); //if the stamp tool is on, draw the stamp
  else {
    if (mouseY>UIHeight+UILineHeight) { //if mouse is not in the tool box
      fill(sRed.value, sGreen.value, sBlue.value); //draw the lines
      line(pmouseX, pmouseY, mouseX, mouseY);
    }
  }
  sRed.move(); //update the sliders
  sBlue.move();
  sGreen.move();
  sWidth.move();
}
void mouseReleased() {
  sRed.move(); //update the sliders
  sBlue.move();
  sGreen.move();
  sWidth.move();
  for (ColorButton cb : colorButtons) cb.clicked(); //update the color buttons
  if (mouseX>840&&mouseX<840+twof+20&mouseY>onef-10&&mouseY<onef-10f+twof+20) isOnMeme=!isOnMeme;  //check when the stamp tool is clicked
}
class Slider { //slider class
  float x;
  float y; 
  float startX;
  int endX;
  int r;
  float value;
  float startV;
  float endV;
  Slider(float y, float startX, int endX, int r, int startV, int endV ) { //constructor for y, start x, end x, radius or the circle, map's startv and map's endv
    this.y = y;
    this.startX = startX;
    this.endX = endX;
    this.r = r;
    this.startV = startV;
    this.endV = endV;
    x = (startX+endX)/2;
  }
  void update() { //update the values of the slider
    strokeWeight(5);
    if (mouseX > startX && mouseX < endX && mouseY > y-r/2 && mouseY < y+r/2) stroke(grey.c); //when hovering, change appearnce
    else stroke(0);
    fill(255);
    line(startX, y, endX, y); //draw the line
    circle(x, y, r); //the circle
    value = map(x, startX, endX, startV, endV); //calulate the value
  }
  void clicked(float v) { //when clicked 
    x = map(v, startV, endV, startX, endX);
    update();
  }
  void move() { //when moved, move the x of the circle
    if (mouseX > startX && mouseX < endX && mouseY > y-r/2 && mouseY < y+r/2) x = mouseX;
  }
}
class ColorButton { //color button class
  float x;
  float y;
  float radius;
  Color c;
  ColorButton(float x, float y, float radius, Color c) { //constructor for the x, y, radius postions and the color
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.c = c;
  }
  void update() { 
    strokeWeight(5); 
    if (dist(x, y, mouseX, mouseY)<radius/2) stroke(grey.c); //if mouse is hovering, change appearance
    else stroke(black.c); 
    fill(c.c); //fill the button's color
    circle(x, y, radius);
  }
  void clicked() { 
    if (dist(x, y, mouseX, mouseY)<radius/2) { //if clicked on the button
      sRed.clicked(c.r); //set the slider's rgb
      sGreen.clicked(c.g);
      sBlue.clicked(c.b);
      isOnMeme=false; //also turn off stamp tool
    }
  }
}
public class Color { //custom color class so that i can set the rgb slider's values when the button is clicked
  color c;
  float r;
  float g;
  float b;
  Color(float r, float g, float b) {
    this.r = r;
    this.g = g;
    this.b = b;
    c = color(r, g, b);
  }
}
