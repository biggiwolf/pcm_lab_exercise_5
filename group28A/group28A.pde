import processing.video.*;

Movie movie1;
Movie movie2;

void setup(){
  size(960,540);
  movie1 = new Movie(this, "PCMLab11-1.mov");
  movie2 = new Movie(this, "PCMLab11-2.mov");
  movie1.play();
  movie2.play();
  
}

void draw(){
  if(movie1.available()){
   movie1.read(); 
  }
  if(movie2.available()){
    movie2.read();
  }
  image(movie1,0,0);
  image(movie2,10,10);
}