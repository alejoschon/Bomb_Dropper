
class Canion {
  float x = 0;
  float y;
  float tam = 30;
  color colorcito;
  PImage canion;
  Canion () {
    x = width/2 ;
    y = height;
    canion = loadImage ("canion.png");
  }

  void dibujar() {
    noStroke();
    imageMode(CENTER);
    image(canion, x, y);
  }

  void mover() {
    if ( x < width+tam/2) {
      if ( key == CODED) {
        if ( keyCode == RIGHT) {
          x = x+11 ;
        }
      }
    }
    if ( x > 0-tam/2) {
      if ( key == CODED) {
        if ( keyCode == LEFT) {
          x = x-11;
        }
      }
    }
  }
  //esta es la que cierra el objeto
  //escribir TODO arriba de esto
}