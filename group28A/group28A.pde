import processing.video.*;

int currentLineWipeTransition = 0;
int speedWipeTransition = 4;

int speedFadeTransition = 4;

Movie movie1;
Movie movie2;

int imageWidth2 = 960;
int imageHeight2 = 540;

int imageWidth1 = 320;
int imageHeight1 = 240;

void setup(){
  size(960,540);
  movie1 = new Movie(this, "PCMLab11-1.mov");
  movie2 = new Movie(this, "PCMLab11-2.mov");
  
  movie1.play();
  movie2.play();
  
  movie2.volume(0);
  
}

void draw(){
  if(movie1.available()){
   movie1.read(); 
  }
  if(movie2.available()){
    movie2.read();
  }
  //scale up the image, resize doesnt work for a reason to enlarge the image
  PImage current = movie1;
  PImage result = createImage(imageWidth2, imageHeight2, RGB);
  result.copy(movie1, 0, 0, imageWidth2, imageHeight2, 0, 0, imageWidth2, imageHeight2);
  
  result.set(0, 0, movie2.get(0,0,currentLineWipeTransition,imageHeight2));
  currentLineWipeTransition += speedWipeTransition;
  
  PImage movie2Copy = createImage(imageWidth2, imageHeight2, RGB);
  movie2Copy.copy(movie2,0,0,imageWidth2, imageHeight2, 0, 0, imageWidth2, imageHeight2);
  
  image(result,0,0);
  tint(255,122);
  image(movie2Copy,0,0);
  tint(255,50);

  wipe(movie1, movie2);
  
  
  //current.resize(400,0);
  //current.resize(960,0);
  //image(movie1,0,0, imageWidth2, imageHeight2);
  //image(movie2,10,10, imageWidth2, imageHeight2);
  
  
  //make a transition after 4 seconds
  //if((int)movie1.time() >= 2){
   //   image(wipe(movie1, movie2),0,0, imageWidth2, imageHeight2);
  //}
  //image(current,0,0);
}

PImage wipe(PImage movie1, PImage movie2){
  PImage result = createImage(imageWidth2, imageHeight2, RGB);
  //result.copy(movie1, 0, 0, currentLineWipeTransition, imageHeight2, 0, 0, currentLineWipeTransition, imageHeight2);
  result.copy(movie1, 0, 0, currentLineWipeTransition, imageHeight2, 0, 0, currentLineWipeTransition, imageHeight2);
  currentLineWipeTransition += speedWipeTransition;
  result.resize(imageWidth2, imageHeight2);
  image(result ,0 ,0);
  return result;
}