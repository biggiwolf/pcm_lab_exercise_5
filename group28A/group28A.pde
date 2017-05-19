import processing.video.*;

int currentLineWipeTransition = 0;
int speedWipeTransition = 4;

int currentFadeTransition = 0;
int speedFadeTransition = 1;

Movie movie1;
Movie movie2;

int imageWidth = 960;
int imageHeight = 540;

void setup(){
  size(960,540);
  movie1 = new Movie(this, "PCMLab11-1.mov");
  movie2 = new Movie(this, "PCMLab11-2.mov");
  
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

  
  //scale up the image, so both videos have the same size (resize didnt work for a reason to enlarge the image)
  PImage movie1Upscale = createImage(imageWidth, imageHeight, RGB);
  movie1Upscale.copy(movie1, 0, 0, imageWidth, imageHeight, 0, 0, imageWidth, imageHeight);
  
  image(movie1Upscale,0,0);
    
  //make a transition after 2 seconds
  if((int)movie1.time() >= 2){
    //wipe(movie1Upscale, movie2);
    fade(movie1Upscale, movie2);
  }
  
}

void wipe(PImage movie1, PImage movie2){
  PImage result = createImage(imageWidth, imageHeight, RGB);
  result.set(0, 0, movie2.get(0,0,currentLineWipeTransition,imageHeight));
  
  currentLineWipeTransition += speedWipeTransition;
  
  image(result,0,0);
}

void fade(PImage movie1, PImage movie2){
  
  image(movie1,0,0);
  tint(255,0 + currentFadeTransition);
  
  image(movie2,0,0);
  tint(255, 255 - currentFadeTransition);
  
  currentFadeTransition += speedFadeTransition; 
}