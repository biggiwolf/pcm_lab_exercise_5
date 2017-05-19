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

  
  //scale up the image, resize doesnt work for a reason to enlarge the image
  PImage movie1Upscale = createImage(imageWidth2, imageHeight2, RGB);
  movie1Upscale.copy(movie1, 0, 0, imageWidth2, imageHeight2, 0, 0, imageWidth2, imageHeight2);
  
  image(movie1Upscale,0,0);
    
  //make a transition after 2 seconds
  if((int)movie1.time() >= 2){
    wipe(movie1Upscale, movie2);
  //  fade(movie1Upscale, movie2);
  }
  
  /*
  movie1Upscale.set(0, 0, movie2.get(0,0,currentLineWipeTransition,imageHeight2));
  currentLineWipeTransition += speedWipeTransition;
  
  PImage movie2Copy = createImage(imageWidth2, imageHeight2, RGB);
  movie2Copy.copy(movie2,0,0,imageWidth2, imageHeight2, 0, 0, imageWidth2, imageHeight2); */
  
  
  /*
  image(movie1Upscale,0,0);
  tint(255,122);
  image(movie2Copy,0,0);
  tint(255,50);
*/
  

  //wipe(movie1, movie2);
  //fade(movie1Upscale, movie2);
  /*
  tint(255,122);
  image(movie1Upscale,0,0);
  //tint(255,122);
  */
  //tint(255,123);
  //image(movie2, 0,0);

  
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

void wipe(PImage movie1, PImage movie2){
  PImage result = createImage(imageWidth2, imageHeight2, RGB);
  //result.copy(movie1, 0, 0, currentLineWipeTransition, imageHeight2, 0, 0, currentLineWipeTransition, imageHeight2);
  result.set(0, 0, movie2.get(0,0,currentLineWipeTransition,imageHeight2));
  currentLineWipeTransition += speedWipeTransition;
  
  image(result,0,0);
}

void fade(PImage movie1, PImage movie2){
  
  tint(255,20);
  image(movie2,0,0);
  //tint(255,20);
  
}