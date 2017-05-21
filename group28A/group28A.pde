import processing.video.*;

int currentLineWipeTransition = 0;
int speedWipeTransition = 4;

int currentFadeTransition = 0;
int currentDissolveTransition = 0;
int speedFadeTransition = 2;

int xCoord = 0;
int yCoord = 0;

Movie movie1;
Movie movie2;
PImage sky;

int imageWidth = 960;
int imageHeight = 540;

void setup(){
  size(960,540);
  movie1 = new Movie(this, "PCMLab11-1.mov");
  movie2 = new Movie(this, "PCMLab11-2.mov");
  sky = loadImage ("sky.jpg");
  
  movie1.loop();
  movie2.loop();
  
  movie1.volume(0);
  movie2.volume(0);
  
}

void draw(){
  
  clear();
  
  if(movie1.available()){
   movie1.read(); 
  }
  if(movie2.available()){
    movie2.read();
  }
  
  if (keyPressed) {
    if (key == 'a' || key == 'A') {
      if(xCoord - 25 > 0)
        xCoord -= 25;
      else
        xCoord = 0;
    }
    if (key == 'd' || key == 'D') {
      if(xCoord + 25 < imageWidth)
        xCoord += 25;
      else
        xCoord = imageWidth-1;
    }
    if (key == 'w' || key == 'W') {
      if(yCoord - 25 > 0)
        yCoord -= 25;
      else
        yCoord = 0;
    }
    if (key == 's' || key == 'S') {
      if(yCoord + 25 < imageHeight)
        yCoord += 25;
      else
        yCoord = imageHeight-1;
    }
    println("xCoord: " + xCoord);
    println("yCoord: " + yCoord);
  }

  
  //scale up the image, so both videos have the same size (resize didnt work for a reason to enlarge the image)
  PImage movie1Upscale = createImage(imageWidth, imageHeight, RGB);
  movie1Upscale.copy(movie1, 0, 0, imageWidth, imageHeight, 0, 0, imageWidth, imageHeight);
  
  chromaKey(movie2);
  
  //FADE
  //fade(movie1Upscale);
  
  //SPECIAL
  //special(movie1Upscale, movie2);
  
  image(movie1Upscale,0,0);
  //image(movie2,0,0);
  
  //make a TRANSITION after 2 seconds
  if((int)movie1.time() >= 2){
    //wipe(movie1Upscale, movie2);
    //dissolve(movie1Upscale, movie2);
  }
  
}

void wipe(PImage movie1, PImage movie2){
  PImage result = createImage(imageWidth, imageHeight, RGB);
  result.set(0, 0, movie2.get(0,0,currentLineWipeTransition,imageHeight));
  
  currentLineWipeTransition += speedWipeTransition;
  
  image(result,0,0);
}

void fade(PImage movie1){ 
  image(movie1,0,0);
  tint(255,0 + currentFadeTransition);
 
  if(currentFadeTransition < 255)
    currentFadeTransition += speedFadeTransition; 
}

void dissolve(PImage movie1, PImage movie2){
  image(movie1,0,0);
  tint(255,0 + currentDissolveTransition);
  
  image(movie2,0,0);
  tint(255, 255 - currentDissolveTransition);
  
  currentDissolveTransition += speedFadeTransition; 
}

void special(PImage movie1, PImage movie2){
  
  loadPixels();  
  for (int y = 0; y < yCoord; y++) {
    for(int x = 0; x < xCoord; x++){
      int aux = x + y * imageWidth;
      movie1.pixels[aux] = movie2.pixels[aux];
    }
  }
  updatePixels();
}

void chromaKey(PImage m){
  loadPixels();  
  for (int y = 0; y < imageHeight; y++) {
    for(int x = 0; x < imageWidth; x++){
      int aux = x + y * imageWidth;
      float r = red(m.pixels[aux]);
      float g = green(m.pixels[aux]);
      float b = blue(m.pixels[aux]);
      if((r < 210 && g > 200 && b < 255))
      {
        m.pixels[aux] = sky.pixels[aux];
      }
    }
  }
  updatePixels();
}