float prevX = -20;

class Bala {
  float x;
  float y;
  float tam; 
  String disparada = "no";
  PImage bala;
  Bala () {

    y = height;

    bala = loadImage("bala.png");
  }


  void dibujar () {

    pushStyle();
    imageMode(CENTER);
    image(bala, prevX, y);
    popStyle();

    if (y == -30) {
      disparada = "no";
    }
    if (disparada.equals("no")) {
      y = height;
    }
  }
  void equis () {
    prevX = can.x;
  }

  void disparo () {

    //println(y);
    if (disparada.equals("si")) {
      y = y - 10;
    } else { 
      y = height+25;
    }
  }



  //FIN DEL OBJETO
}