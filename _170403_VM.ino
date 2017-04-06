float lectura;
float b; // ancho viga (cm)
float h; // altura viga (cm)
float I; // Inercia viga (cm^4)
float D; // distancia (cm)
float Mb; // Momento empotramiento (N*cm)
float Vb; // Cortante (N)
float F; // Fuerza aplicada(N)
float Sigma[5];
float Tau[5];
float VonMises[5]; // (N/cm^2)
float y0=0.2;
float y1=0.1;
float y2=0;
float y3=-0.1;
float y4=-0.2;

void setup() {
Serial.begin(9600);
pinMode(13,OUTPUT);
pinMode(12,OUTPUT);
b=2.0; // (cm)
h=0.5; // (cm)

}
void loop() {
int lectura=analogRead(A1); // posicion
int sensorValue = analogRead(A0); //lectura presion

 
D=pow(3027.4 / lectura, 1.2134); // conversión a centimetro
F=((0.0033*sensorValue-2.1936)*10)*20; //Newtons -> Escalamos x20 la Fuerza
if (F<0)
{
F=0;
}
I=(b*pow(h,3))/12;
Mb=-F*D;
Vb=-F;

Sigma[0]=-Mb*y0/I;
Sigma[1]=-Mb*y1/I;
Sigma[2]=-Mb*y2/I;
Sigma[3]=-Mb*y3/I;
Sigma[4]=-Mb*y4/I;

Tau[0]=Vb/(2*I)*(pow(h,2)/4-pow(y0,2));
Tau[1]=Vb/(2*I)*(pow(h,2)/4-pow(y1,2));
Tau[2]=Vb/(2*I)*(pow(h,2)/4-pow(y2,2));
Tau[3]=Vb/(2*I)*(pow(h,2)/4-pow(y3,2));
Tau[4]=Vb/(2*I)*(pow(h,2)/4-pow(y4,2));

VonMises[0]=sqrt(pow(Sigma[0],2)+3*pow(Tau[0],2));
VonMises[1]=sqrt(pow(Sigma[1],2)+3*pow(Tau[1],2));
VonMises[2]=sqrt(pow(Sigma[2],2)+3*pow(Tau[2],2));
VonMises[3]=sqrt(pow(Sigma[3],2)+3*pow(Tau[3],2));
VonMises[4]=sqrt(pow(Sigma[4],2)+3*pow(Tau[4],2));



//Serial.print(sensorValue);//presion
//Serial.print(",");
Serial.print(D);//posicion
Serial.print(",");
Serial.print(F);
Serial.print(",");

//Serial.print(Mb);
//Serial.print(",");
//Serial.print(Vb);
//Serial.print(",");

Serial.print(VonMises[0]);
Serial.print(",");
Serial.print(VonMises[1]);
Serial.print(",");
Serial.print(VonMises[2]);
Serial.print(",");
Serial.print(VonMises[3]);
Serial.print(",");
Serial.print(VonMises[4]);
Serial.print(",");


Serial.println();
delay(250); // delay in between reads for stability


if (D > 22.5)
{digitalWrite(13,HIGH);
 digitalWrite(12,LOW);// do something here
}
else 
{digitalWrite(12,HIGH);
 digitalWrite(13,LOW);// do something here
}
}
