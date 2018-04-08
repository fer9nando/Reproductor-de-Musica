import ddf.minim.*;
import ddf.minim.analysis.*;
import javax.swing.*;
import java.awt.*;
import javax.swing.JFileChooser;

PFont font;
PShape network,network2,network3,network4;
Minim minim;
AudioPlayer player;
AudioMetaData meta;
BeatDetect beat;
float rad = 70;
int colorter2=(int)random(256);
int colorsecond2=(int)random(256);
int colortree2=(int)random(256);

 int colorter3=(int)random(256);
int colorsecond3=(int)random(256);
int colortree3=(int)random(256);

int colorter4=(int)random(256);
int colorsecond4=(int)random(256);
int colortree4=(int)random(256);

int colorter=(int)random(256);
int colorsecond=(int)random(256);
int colortree=(int)random(256);

int angle=0;
int angle2=360;
boolean circulacion=true;
boolean circulacion2=false; 
int radius = 304;
int numLines = 512;
float nx = 0;
float ny = 0;

void setup()
{
  size(1300, 700);
  /*Imagenes*/
  network = loadShape("play-button.svg");
  network.disableStyle();
  network2 = loadShape("pause-button.svg");
  network2.disableStyle();
  network3 = loadShape("exchange.svg");
  network3.disableStyle();
  network4 = loadShape("open.svg");
  network4.disableStyle();
  
  minim = new Minim(this);
  //player = minim.loadFile("Galan.mp3",512);
  //player = minim.loadFile("Cerebro.mp3",512);
  //player = minim.loadFile("Animals.mp3",512);
  //player = minim.loadFile("Amor.mp3",512);

  background(-1);
  frameRate(20);
  noFill();
  font = loadFont("LucidaSans.vlw");
  textFont(font);
}

boolean ultimoFotograma=false;
void draw()
{ 
  if(Nombre=="")
  {
    clear();
  }
  else if(SumaDeFrecuencias()!=64)//cuando deja de existir movimiento se desvanece
  {
    clear();
    if(frameCount%50==0)//para cambiar colores
    {
      cambiarColores();
    }
    LineasCircunferencia();
    circulos();
    MediosCirculos();
    CuartosCirculos();
    puntosCentrales();
  }
  else
  {
    clear();
    LineasCircunferencia();
    circulos();
    MediosCirculos();
    CuartosCirculos();
    puntosCentrales();
  }
  botones();
}

/*  Lineas de la circunferencia  */
void LineasCircunferencia()
{
  pushMatrix();
  pushStyle();
  stroke(random(80,256), 20);
  strokeWeight(5);
  float angle3=0.0;
  translate(width/2, 350);
  for(int i = 0; i <  player.bufferSize() - 1; i++){
    float x1, x2, y1, y2;
    x1 = radius * cos(angle3);
    y1 = radius * sin(angle3);
    x2 = x1 + ((player.left.get(i)+1)*128) * cos(angle3+PI/2);
    y2 = y1 + ((player.left.get(i)+1)*128) * sin(angle3+PI/2);
    line(x1, y1, x2, y2);
    angle3+=TWO_PI/numLines;
  }
  popStyle();
  popMatrix();
  nx+=.05;
  ny+=.01;
}

/*    Circulos pequeños afuera de la circunferencia    */
void circulos()
{
    int bsize = player.bufferSize();
    pushMatrix();
    /*    Rotacion de circulos izquierda o derecha*/
    if(angle2>360)
    {
    angle2=360;
    circulacion2=false;
    }
    if(angle2<0)
    {
    angle2=0;
    circulacion2=true;
    }
    translate(width/2, 350);
    if(circulacion2==true)
     rotate(radians(angle2++));
    else
     rotate(radians(angle2--));

  for (int i = 0; i < bsize; i+=30)
  {
    float x2 = (350 + player.left.get(i)*100)*cos(i*2*PI/bsize);
    float y2 = (350 + player.left.get(i)*100)*sin(i*2*PI/bsize);
    pushStyle();
    int aux=(int)((player.left.get(i))*24);
    if(aux<0)
      aux=aux*-1;
    int tam=(int)random(aux,aux+1);
    strokeWeight(tam);
    stroke(colorter2,colorsecond2,colortree2);
    point(x2, y2);
    popStyle();
    
    x2 = (400 + player.left.get(i)*100)*cos(i*2*PI/bsize);
    y2 = (400 + player.left.get(i)*100)*sin(i*2*PI/bsize);
    pushStyle();
    aux=(int)((player.left.get(i))*44);
    if(aux<0)
      aux=aux*-1;
    tam=(int)random(aux,aux+1);
    strokeWeight(tam);
    stroke(colorter3,colorsecond3,colortree3);
    point(x2, y2);
    popStyle();
    
    x2 = (470 + player.left.get(i)*100)*cos(i*2*PI/bsize);
    y2 = (470 + player.left.get(i)*100)*sin(i*2*PI/bsize);
    pushStyle();
    aux=(int)((player.left.get(i))*64);
    if(aux<0)
      aux=aux*-1;
    tam=(int)random(aux,aux+1);
    strokeWeight(tam);
    stroke(colorter4,colorsecond4,colortree4);
    point(x2, y2);
    popStyle();

  }
   popMatrix();
}

/*    Cambio de colores    */
void cambiarColores()
{
  colorter=(int)random(256);
  colorsecond=(int)random(256);
  colortree=(int)random(256);
  
  colorter2=(int)random(256);
  colorsecond2=(int)random(256);
  colortree2=(int)random(256);
      
  colorter3=(int)random(256);
  colorsecond3=(int)random(256);
  colortree3=(int)random(256);
 
  colorter4=(int)random(256);
  colorsecond4=(int)random(256);
  colortree4=(int)random(256);

}

/*    Para Verificar que aun existe una frecuencia y la cancion aun no a terminado*/
float SumaDeFrecuencias()
{
  float suma=0.0;
  int contaux=0;
  for(int counter = 0; counter < player.bufferSize() - 1; counter+=10){
    suma=suma+(player.left.get(counter)+1)*64;
    contaux++;
  }
  return (float)suma/contaux;
}

//    Impresion de medios circulos    //
void MediosCirculos()
{
   pushMatrix();
   stroke(colorter4,colorsecond4,colortree4,255);
   translate(650, 350);
   for(int counter = 0; counter < player.bufferSize() - 1; counter+=10){ 
     arc(0,0,counter+100,counter+100,-radians((player.left.get(counter)+1)*64)+PI,PI);
     arc(0,0,counter+100,counter+100,PI,radians((player.left.get(counter)+1)*64)+PI);
     arc(0,0,counter+100,counter+100,-radians((player.left.get(counter)+1)*64),0);
     arc(0,0,counter+100,counter+100,0,radians((player.left.get(counter)+1)*64));
   
   }
   popMatrix();
}

/*    Cuartos de circulo    */
void CuartosCirculos()
{
    pushMatrix();
    if(angle>360)
    {
    angle=360;
    circulacion=false;
    }
    if(angle<0)
    {
    angle=0;
    circulacion=true;
    }
    translate(width/2, 350);
    if(circulacion==true)
      rotate(radians(angle++));
    else
      rotate(radians(angle--));
    noFill();
    stroke(colorter,colorsecond,colortree);
    for(int counter = 0; counter < player.bufferSize() - 1; counter+=10){ 
      arc(0,0,counter+100,counter+100,0,radians((player.left.get(counter)+1)*64));
      arc(0,0,counter+100,counter+100,PI,radians((player.left.get(counter)+1)*64)+PI);
      arc(0,0,counter+100,counter+100,PI+HALF_PI,radians((player.right.get(counter)+1)*64)+PI+HALF_PI);
      arc(0,0,counter+100,counter+100,HALF_PI,radians((player.right.get(counter)+1)*64)+HALF_PI);
    }
    popMatrix();
}

/*Puntos que se muestran en el circulo pequeño*/
void puntosCentrales()
{
  pushMatrix();
  stroke(-1, 50);
  translate(width/2, 350);
  int bsize = player.bufferSize();
  fill(random(10,50));
  arc(0,0,80,80,0,PI*2);
  noFill();
  for (int i = 0; i < bsize; i+=1)
  {
    float x2 = (player.left.get(i)*70)*cos(i*2*PI/bsize);
    float y2 = (player.left.get(i)*70)*sin(i*2*PI/bsize);
    pushStyle();
    stroke(-1);
    strokeWeight(2);
    point(x2, y2);
    popStyle();
  }
  popMatrix();
}
boolean escalaPlay=false,escalaPause=false,escalaStop=false,escalaAbrir=false;
/*    Mostar botones    */
void botones()
{
  /*      Boton play      */
  if(escalaPlay==false)
  {
  fill(255,50);
  arc(650,675,50,50,0,PI*2);
  fill(255);
  shape(network,625,650,50,50);
  noFill();
  }
  else
  {
    fill(255,50);
    arc(655,670,60,60,0,PI*2);
    fill(255);
    shape(network,625,640,60,60);
    fill(255,100);
    rect(mouseX,mouseY,50,15);
    fill(0);
    text("Play",mouseX+15,mouseY+10);
    noFill();
  }
   /*      Boton pause      */
  if(escalaPause==false)
  {
  fill(255,50);
  arc(595,675,40,40,0,PI*2);
  fill(255);
  shape(network2,575,655,40,40);
  noFill();
  }
  else
  {
    fill(255,50);
    arc(595,670,45,45,0,PI*2);
    fill(255);
    shape(network2,574,649,45,45);
    fill(255,100);
    rect(mouseX,mouseY,50,15);
    fill(0);
    text("Pause",mouseX+15,mouseY+10);
    noFill();
  }
  
   /*      Boton reinicio      */
  if(escalaStop==false)
  {
  fill(255,50);
  arc(705,675,40,40,0,PI*2);
  fill(255);
  shape(network3,685,655,40,40);
  noFill();
  }
  else
  {
    fill(255,50);
    arc(705,670,45,45,0,PI*2);
    fill(255);
    shape(network3,682,649,45,45);
    fill(255,100);
    rect(mouseX,mouseY,70,15);
    fill(0);
    text("Reiniciar",mouseX+15,mouseY+10);
    noFill();
  }
  
    /*      Boton open      */
  if(escalaAbrir==false)
  {
  fill(255,50);
  arc(545,677,32,32,0,PI*2);
  fill(255);
  shape(network4,535,665,25,25);
  noFill();
  }
  else
  {
    fill(255,50);
    arc(545,675,37,37,0,PI*2);
    fill(255);
    shape(network4,530,655,35,35);
    fill(255,100);
    rect(mouseX,mouseY,50,15);
    fill(0);
    text("Abir",mouseX+15,mouseY+10);
    noFill();
  }
  
}

/*    Botones pasar encima mouse  */
void mouseMoved() {
  //Play
  if(mouseX>625&&mouseX<675&&mouseY>650&&mouseY<700)
  {
    escalaPlay=true;
    cursor(HAND);
    noFill();
  }
  else
  {
    cursor(ARROW);
    escalaPlay=false;
  }
  
  //Pause
   if(mouseX>575&&mouseX<615&&mouseY>640&&mouseY<690)
  {
    escalaPause=true;
    cursor(HAND);
    noFill();
  }
  else
  {
    cursor(ARROW);
    escalaPause=false;
  }
  
  //stop
   if(mouseX>680&&mouseX<720&&mouseY>640&&mouseY<690)
  {
    escalaStop=true;
    cursor(HAND);
    noFill();
  }
  else
  {
    cursor(ARROW);
    escalaStop=false;
  }
  
    //escalaAbrir//////////////////////////////////////////////////////////////////////////////////////////////////////////////
   if(mouseX>530&&mouseX<560&&mouseY>650&&mouseY<690)
  {
    escalaAbrir=true;
    cursor(HAND);
    noFill();
  }
  else
  {
    cursor(ARROW);
    escalaAbrir=false;
  }
  
}

boolean clickPlay=false;
/*    Click Botones    */
void mouseClicked() {
   if(mouseX>625&&mouseX<675&&mouseY>650&&mouseY<700)
  {
    playsong();
  }
  if(mouseX>575&&mouseX<615&&mouseY>640&&mouseY<690)
  {
    pausesong();
  }
  if(mouseX>680&&mouseX<720&&mouseY>640&&mouseY<690)
  {
    rewindsong();
  }
  if(mouseX>530&&mouseX<560&&mouseY>650&&mouseY<690)
  {
    abrirCancion();
  }
}




void playsong()//falta verificacion
{
  if(Nombre!="")
    player.play();
}

void pausesong()
{
  if(Nombre!="")
    player.pause();
}

void rewindsong()
{
  if(Nombre!="")
    player.rewind();
}
String Nombre="";
void abrirCancion()
{
  JFileChooser file=new JFileChooser();
  int status = file.showOpenDialog(null);
  
  if (status == JFileChooser.APPROVE_OPTION) {
    if(Nombre!="")
     player.pause();
      if((""+file.getSelectedFile())!="")
      {
      Nombre=""+file.getSelectedFile();
      player = minim.loadFile(Nombre,512);
      player.play();
      }
  }
 else if (status == JFileChooser.CANCEL_OPTION) {
System.out.println("cancelado");
}

}