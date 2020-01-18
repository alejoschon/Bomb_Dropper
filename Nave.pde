
class Nave {
  float x;
  float y; 
  float tam = 60;
  PImage nave;

  Nave (float y_) {
    y = y_;
    nave = loadImage("nave.png");
  }

  void dibujar () {
    //rectMode(CENTER);
    //rect(x, y, tam, tam/2);
    imageMode(CENTER);
    image (nave, x, y);
  }

  void mover() {
    x++;
    if ( x >= width+55) {
      x = 0;
    }
  }




  //NO ESCRIBIR NADA ABAJO
}