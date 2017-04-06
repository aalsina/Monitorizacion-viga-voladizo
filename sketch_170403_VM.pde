import processing.serial.*;
Serial myPort; // Create object from Serial class
float sigma;
float tau;
float VM0;
float VM1;
float VM2;

int fy=355*100;//S355 MPa (N/cm^2)
String title="Viga Simple en Voladizo: Carga Puntual F Genérica";
String subtitle1="Sección Empotramiento: Tensiones de Von Mises";
String subtitle2="Acero S355";

String dim="Dimensiones Viga:";
String altura="Altura: 0.5 cm";
String ancho="Ancho: 2 cm";
String longitud="Longitud: 45 cm";

String carga="Carga F Aplicada:";
String dist="Distancia Aplicación respecto al Empotramiento:";



void setup() 
{
size(1200,850);
frameRate(4);


//OPENS PORT COMUNICATION
printArray(Serial.list());
myPort=new Serial(this,Serial.list()[0],9600); // Open whatever port is the one you're using.
myPort.bufferUntil('\n');

}
void draw() 
{
 background(255,255,255);
 textSize(32);
 fill(0,0,255);
 text(title,100,80);
 textSize(28);
 fill(0,0,255);
 text(subtitle1,100,170);
 textSize(26);
 fill(0,0,0);
 text(subtitle2,100,250);
 
 textSize(24);
 fill(0,0,0);
 text(dim,100,600);
 textSize(22);
 fill(0,0,0);
 text(altura,100,650);
 textSize(22);
 fill(0,0,0);
 text(ancho,100,700);
 textSize(22);
 fill(0,0,0);
 text(longitud,100,750);
 
 textSize(24);
 fill(0,0,0);
 text(carga,500,600);
   textSize(26);
   fill(0,0,0);
   text("N",650,650);
 
 textSize(24);
 fill(0,0,0);
 text(dist,500,700);
   textSize(26);
   fill(0,0,0);
   text("cm",650,750);

 textSize(16);
 fill(0,0,0);
 text("VM",920,320);
   textSize(16);
   fill(0,0,0);
   text("MPa",1040,320);
 textSize(16);
 fill(0,0,0);
 text("VM",920,360);
   textSize(16);
   fill(0,0,0);
   text("MPa",1040,360);
  textSize(16);
 fill(0,0,0);
 text("VM",920,400);
   textSize(16);
   fill(0,0,0);
   text("MPa",1040,400);

 

 String inString=myPort.readStringUntil('\n');
   if (inString !=null) {
     float[] values=float(split(inString,','));
     
     textSize(30);
     fill(50);
     text(values[0],500,750); //distancia
     
     textSize(30);
     fill(50);
     text(values[1],500,650); //presio

 VM0=map(values[2],0,fy,0,255);
 VM1=map(values[3],0,fy,0,255);
 VM2=map(values[4],0,fy,0,255);
 
fill(VM0,0,0);
rect(100,300,800,40);

fill(VM1,0,0);
rect(100,340,800,40);

fill(VM2,0,0);
rect(100,380,800,40);

fill(VM1,0,0);
rect(100,420,800,40);

fill(VM0,0,0);
rect(100,460,800,40);

 textSize(16);
 fill(0,0,0);
 text(values[2]/100,960,320);
 textSize(16);
 fill(0,0,0);
 text(values[3]/100,960,360);
  textSize(16);
 fill(0,0,0);
 text(values[4]/100,960,400);

 }
 
 
 


}