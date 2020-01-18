
class Bomba {
  float x;
  float y ;
  float resistencia;
  float tam;
  boolean vivo ;
  int golpes = 0;
  PImage bomba, bomba2, boom;
  float vel;

  Bomba(float resistencia_, float x_, float y_, float vel_) {
    resistencia = resistencia_;
    y = y_;
    x = x_;
   vel = vel_;
    vivo = true;
    bomba = loadImage("bomba.png");
    bomba2 = loadImage("bomba2.png");
    boom = loadImage("boom.png");
  }
  //Resistencia bomba
  void resistencia() {
    if (resistencia == 2) {

      //ACA TENGO QUE IR ACTUALIZANDO LA COLISION TMB
      pushStyle();
      //fill(0, 0, 255);
      popStyle();
      if (prevX >= x-18 && prevX <= x+18 && bal.y >= y-18 && bal.y <= y+18 && vivo) {
        golpes++;
      }
    }
   
  }

  void dibujar () {
    if (vivo) {

      pushStyle();

      imageMode(CENTER);
      if(resistencia == 1){
      image(bomba, x, y);
      } else if(resistencia == 2){
        image(bomba2,x,y);
      }

      popStyle();
    }
    if( y >= height){
      image(boom,x,y);
    }
  }

  void disparo () {
    if (vivo) {
      y = y + vel;
    }
  }

  void equis() {
    navX = nav.x;
  }
void boom (){
  if(vivo && y == height-18){
 image(boom,x,y);   
  }
}


  boolean colision() {

    // println( "bala:", bal.x, bal.y, "bomba", x, y);

    if (prevX >= x-18 && prevX <= x+18 && bal.y >= y-18 && bal.y <= y+18 && vivo) {
     
      return true;
    } else {
      return false;
    }
  }

  void morir() {
    vivo = false;
  }

  boolean resta() {
    if (y >= height/2) {
      return true;
    } else {
      return false;
    }
  }
  //NO ESCRIBIR ABAJO DE ESTO
}