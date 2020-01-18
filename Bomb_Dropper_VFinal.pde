String estado = "inicio";
boolean juego = false;
//Objetos
Canion can;
Bala bal;
Nave nav;
ArrayList<Bomba> bombas;
ArrayList<Bomba> superbombas;
//otros
float navX;
float bombY;
boolean disparo = false;
// Timer
int startTime; 
int currentTime = 0;
int t= 30;
//Fondos
PImage fondo1, fondo2;
PImage nivel2, inicio, creditos;
PImage ganaste, perdiste1, perdiste2;

//Tipografia
PFont font;
// Sonido
//Cargar libreria Minim 
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
Minim minim; // instancia de la clase Minim
AudioSample piumpium;// instancia de la clase AudioSample
AudioPlayer avioncito;
AudioPlayer guerra;
AudioPlayer ateam;
AudioPlayer win;
AudioPlayer playing;
AudioPlayer lose;
AudioSample bombasound;
AudioSample bombacayendo;
// VIDAS
int vidas = 5;
// PUNTAJE
int puntos = 0;
//Contador
PImage metal;
PImage vida;
PImage bombadestruida;
//Timer
PImage reloj;
void setup() {
  size(400, 600);

  //Declaración de Objetos
  can = new Canion();
  bal = new Bala();
  nav = new Nave(50);
  bombas = new ArrayList<Bomba>();
  superbombas = new ArrayList<Bomba>();
  //Tipografia
  font= loadFont("AmericanCaptain-60.vlw");
  textFont(font);
  //Fondos
  fondo1 = loadImage("fondo1.png");
  fondo2 = loadImage("fondo2.png");
  nivel2 = loadImage("nivel2.jpg");
  inicio= loadImage("inicio.jpg");
  creditos = loadImage("creditos.jpg");
  ganaste= loadImage("ganaste.jpg");
  perdiste1= loadImage("perdiste1.jpg");
  perdiste2= loadImage("perdiste2.jpg");
  // Timer
  startTime = millis();
  reloj= loadImage("reloj.png");
  //Sonido
  //se declara la clase Minim para usar sus métodos:
  minim = new Minim(this);
  //cargamos el archivo desde la carpeta data
  piumpium = minim.loadSample("disparo.mp3");
  avioncito = minim.loadFile("avion.mp3");
  guerra = minim.loadFile("guerra.mp3");
  ateam = minim.loadFile("ateam.mp3");
  win = minim.loadFile("win.mp3");
  playing = minim.loadFile("playing.mp3");
  lose = minim.loadFile("lose.mp3");
  bombasound = minim.loadSample("bombasound.mp3");
  bombacayendo = minim.loadSample("bombacayendo.mp3");
  //Contador
  metal = loadImage("metal.png");
  vida = loadImage("vida1.png");
  bombadestruida = loadImage("bombadestruida.png");
}

void draw() {

  //println(estado);
  //println(bal.x);
  //println(currentTime);
  //println(vidas);
  textAlign(CENTER);
  textSize(20);

  //INICIO
  if (estado.equals("inicio")) {
    ateam.play();
    //TODO ESTO SE VA A IR PARA PONER UNA IMAGEN//FONDO QSY
    background (255, 0, 0);
    image(inicio, 0, 0);
    juego = false;
    //reiniciar tiempo
    currentTime = 0;
    startTime = millis();
  }
  //NIVEL1
  if (estado.equals("nivel1")) {

    ateam.close();
    playing.play();
    guerra.play();
    imageMode(CORNER);
    image(fondo1, 0, 0);
    //Contador
    imageMode(CENTER);
    image(metal, 38, 32);
    image(metal, 358, 32);
    image(bombadestruida, 351, 32);
    image(metal, 38, height-48);
    image(vida, 32, height-48);


    // TIMER?
    currentTime = t - (millis() - startTime)/1000;
    //println(currentTime);
    image(reloj, 30, 33);
    text(currentTime, 50, 40);
    if (currentTime == 0) {
      estado = "nivel2";
    }


    if (disparo) {
      bal.disparo();
    }
    // VIDAS
    text(vidas, 50, height-40); 
    // Puntos
    text(puntos, width-32, 40); 
    //Arreglo de Objetos/Bombas

    for (int i= bombas.size()-1; i >= 0; i--) {
      Bomba bomba = bombas.get(i);

      bomba.dibujar();
      bomba.disparo();
      bomba.boom();
      navX = nav.x;

      //COLISION 
      if (bomba.colision()) {
        puntos++;
        bomba.morir();
        bal.y = -30;
      } else {
      }

      if (bomba.y > height) {
        vidas = vidas-1;
        bombas.remove(i);
        bombasound.trigger();
      }
    }
    if (nav.x > 55 && nav.x < width-55 ) {
      if (random(1)>0.99) {
        bombacayendo.trigger();
        bombas.add( new Bomba(1, navX, nav.y, 1.5));
      }
    }

    //Poner metodos
    bal.dibujar();
    can.dibujar();
    nav.dibujar();
    nav.mover();
  }
  //NIVEL2
  if (estado.equals("nivel2")) {
    if (juego == false) {
      imageMode(CORNER);
      image(nivel2, 0, 0);
      vidas = 5;
      //reiniciar tiempo
      currentTime = 0;
      startTime = millis();
    } else {
      imageMode(CORNER);
      image(fondo2, 0, 0);
      //Contador
      imageMode(CENTER);
      image(metal, 38, 32);
      image(metal, 358, 32);
      image(metal, 38, height-48);
      image(vida, 32, height-48);
      image(bombadestruida, 351, 32);
      // TIMER?
      currentTime = t - (millis() - startTime)/1000;
      //  println(currentTime);
      image(reloj, 30, 33);
      text(currentTime, 50, 40);

      if (disparo) {
        bal.disparo();
      }
      //VIDAS
      text(vidas, 50, height-40); 
      // Puntos
      text(puntos, width-32, 40); 

      //BOMBA CON DOBLE RESISTENCIA
      //Arreglo de Objetos/Bombas
      for (int i= superbombas.size()-1; i >= 0; i--) {
        Bomba superbomba = superbombas.get(i);
        superbomba.dibujar();
        superbomba.disparo();
        superbomba.resistencia();
        // guarda valores de bombas
        navX = nav.x;
        bombY = superbomba.y;
        ;
        //println(superbomba.golpes);
        //COLISION 
        if (superbomba.colision()) {
          puntos++;
          if (superbomba.golpes == 2) {
            superbomba.morir();
          }
          bal.y = -30;
        } else {
        }
        if (superbomba.y > height) {
          vidas = vidas-1;
          superbombas.remove(i);
          bombasound.trigger();
        }
      }
      if (random(1)<0.01) {
        //ACA SONIDO BOMBA
        bombacayendo.trigger();
        if (nav.x > 55 && nav.x < width-55 ) {
          superbombas.add( new Bomba(2, navX, nav.y, 1));
        }
      }
      //Arreglo de Objetos/Bombas

      for (int i= bombas.size()-1; i >= 0; i--) {
        Bomba bomba = bombas.get(i);

        bomba.dibujar();
        bomba.disparo();
        bomba.boom();
        navX = nav.x;

        //COLISION 
        if (bomba.colision()) {
          puntos++;
          bomba.morir();
          bal.y = -30;
        } else {
        }

        if (bomba.y > height) {
          vidas = vidas-1;
          bombas.remove(i);
          bombasound.trigger();
        }
      }
      if (nav.x > 55 && nav.x < width-55 ) {
        if (random(1)>0.99) {
          bombacayendo.trigger();
          bombas.add( new Bomba(1, navX, nav.y, 1.5));
        }
      }
      // Métodos
      bal.dibujar();
      can.dibujar();
      nav.dibujar();
      nav.mover();
    }
  }
  //GANASTE
  if (estado.equals("ganaste")) {
    guerra.close();
    playing.close();
    win.play();
    //Esto se va a ir tambien
    background(0);
    pushStyle();
    textAlign(CENTER);
    textSize(40);
    imageMode(CORNER);
    image(ganaste, 0, 0);
    //text("you won :))))))", width/2, height/2);
    //text("toca la tecla arriba ", width/2, height/2+40);
    fill(#792201);
    text("Puntaje final: "+puntos, width/2, height/2+40);
    popStyle();
  }
  //PERDISTE
  if (estado.equals("perdiste")) {
    lose.play();
    guerra.close();
    playing.close();
    //Esto se va a ir tambien
    imageMode(CORNER);
    image(perdiste2, 0, 0);
    //background(0);
    pushStyle();
    fill(#792201);
    textAlign(CENTER);
    textSize(40);
    //text("game over bitch", width/2, height/2);
    //text("toca la tecla arriba ", width/2, height/2+40);
    text("Puntaje final: "+puntos, width/2, height/2+40);
    popStyle();
  }
  //CONDICIONES DE GANAR Y PERDER
  if ( vidas <= 0) {
    estado = "perdiste";
  } else if ( vidas != 0 && currentTime < 0) {
    estado = "ganaste";
  }
  //CREDITOS
  if (estado.equals("creditos")) {
    imageMode(CORNER);
    image(creditos, 0, 0);
  }
  //println(juego);
}


void keyPressed() {
  //INICIO A N1
  if (estado.equals("inicio")) {
    puntos = 0;


    if ( keyCode == ENTER) {
      estado = "nivel1";
      nav.x = 0;
    }
  }

  if ( juego == false && keyCode == ENTER && estado.equals("nivel2") ) {
    juego = true;
  }
  //DISPARO
  if ( estado.equals("nivel1") || estado.equals("nivel2")) {

    can.mover();
    if ( key == ' ') {
      if (bal.disparada == "no") {
        bal.equis();
      }
      disparo = true;
      bal.disparada = "si";
      bal.equis();
      piumpium.trigger(); // se dispara el sonido cuando se aprieta una tecla
    }
  }

  //PERDISTE o GANASTE
  if (estado.equals("perdiste") ||estado.equals("ganaste")) {
    if ( keyCode == DOWN) {
      estado = "creditos";
      win.close();
      lose.close();
    }
    vidas = 5;
  }
  //CREDITOS
  if (estado.equals("creditos")) {
    //reiniciar tiempo
    currentTime = 0;
    startTime = millis();
    if ( keyCode == ENTER) {
      estado = "inicio";
    }
  }
}

//SALTEAR NIVEL
/*if (estado.equals("nivel1") || estado.equals("nivel2")) {
 if (key == CODED) {
 if (keyCode == UP) {
 estado = "perdiste";
 }
 if (keyCode == DOWN) {
 estado = "ganaste";
 }
 }
 }
 }
 */

//escribimos el metodo stop(), que se llama al cerrarse el programa
void stop() {
  piumpium.stop();
  minim.stop();
  super.stop();
}