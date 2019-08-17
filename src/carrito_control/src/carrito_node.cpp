#include <ros/ros.h>
#include <std_msgs/Float32MultiArray.h>
#include <std_msgs/Int64.h>
#define BW 0.235	// Ancho de la base del robot [m]
#define Pi 3.1415926
#define D 23.50000	// Distancia entre llantas [cm]
#define Cll 41.469 // Circunferencia de las llantas [cm]
#define k 0.1	// Constante de desfase del perfil de velocidad trapezoidal
#define vm 0.50	// Velocidad máxima [m/s]
#define ppr 3200.0	// Pulsos por revolución de los encoders del motor
bool act = false;
volatile float enc[2]={0.0,0.0};
// Función que llama al encoder 1
void callbackDer(const std_msgs::Int64::ConstPtr& msg){
	enc[1] = (float)(msg -> data)/ppr;
	printf("%li\n",msg->data);
}
// Función que llama al encoder 2
void callbackIzq(const std_msgs::Int64::ConstPtr& msg){
	enc[0] = (float)(msg -> data)/ppr;
	act = true;
	printf("%li\n",msg->data);
}
int main(int argc, char ** argv){
	ros::init(argc, argv, "carrito_node");	// Se inicializa ROS
	ros::NodeHandle nh;	// Manipulador de nodos
	ros::Rate rate(20);
	// Se instancian subscriptores y publicadores
	ros::Subscriber encoizq = nh.subscribe("/encoIzq",1,callbackIzq); 
	ros::Subscriber encoder = nh.subscribe("/encoDer",1,callbackDer);
	ros::Publisher pubVelMotor = nh.advertise<std_msgs::Float32MultiArray>("/motor_speeds",1);
	int disOffset;
	std_msgs::Float32MultiArray msg; // Variable "msg"
	msg.data.resize(2);	//  Indica el tamaño de la variable
	while(ros::ok()){
		int comp = 1; // Variable con la que se selecciona el perfil de velocidad trapezoidal o las leyes de control de velocidad
		if(comp==1){
			float dist,angle;
			printf("\n Giro Avance: ");
			scanf("%f",&angle);
			angle*=-1.9; // Factor de correción 
			scanf("%f",&dist);
			dist *= 0.9;
		/*-----------------------------------------------------------------Giro---------------------------------------------------*/	
			float angulo = angle;
			act = false;
			// Se le piden los datos de velocidad y giro
			while(!act && ros::ok()){
				printf("Esperando nuevos datos! %f \n",enc[0]);
				ros::spinOnce();
				rate.sleep();
			}
			// Parámetros usados en el perfil trapezoidal de velocidad
			float posDer0 = enc[1]; // Posición actual del encoder derecho
			float posIzq0 = enc[0];	// Posición actual del encoder izquierdo
			float posIzqFin = posIzq0 + ((D*Pi*angulo)/(Cll*360.0)); // Posición final del encoder a la que se quiere llegar
			float posDerFin = posDer0 + ((D*Pi*angulo)/(Cll*360.0));
			float delta  = posIzqFin - posIzq0;	// Distancia a avanzar
			float limite1 = (delta/3.0)+posIzq0; // Primer segmento que debe recorrer el robot
			float limite2 = (delta*(2.0/3.0))+posIzq0;
			printf("%f %f \n",enc[0],limite1);
			/*---------------------------------Perfil trapezoidal para giros con ángulos negativos--------------------------------*/
			if(angulo>0){
				while(enc[0]<limite1 && ros::ok()){
					printf("%f %f \n",enc[0],limite1);
					// Se ejecuta las ecuaciones de la primera parte del perfil trapezoidal 
					msg.data[0] = k + (3.0 * (vm - k)*(fabs(enc[0] - posIzq0)/(delta)));
			    msg.data[1] = -msg.data[0];
	       	pubVelMotor.publish(msg); // Se publican los valores
					ros::spinOnce();
					rate.sleep();		
				}
				while(enc[0]<limite2 && ros::ok()){
					// Se ejecuta las ecuaciones de la segunda parte del perfil trapezoidal
					msg.data[0] = vm;
					msg.data[1] = -vm;	
		      pubVelMotor.publish(msg);
					ros::spinOnce();
					rate.sleep();		
				}
				while(enc[0]<posIzqFin && ros::ok()){
					printf("%f %f \n",enc[0],posIzqFin);
					// Se ejecuta las ecuaciones de la tercera parte del perfil trapezoidal
					msg.data[0] = vm - (3.0*(vm-k)*((fabs(enc[0]-posIzq0)/(delta))-(2.0/3.0)));
					msg.data[1] = -msg.data[0];
		      pubVelMotor.publish(msg);
					ros::spinOnce();
					rate.sleep();		
				}
			}else{
				/*---------------------------------Perfil trapezoidal para giros con ángulos positivos--------------------------------*/
				while(enc[0]>limite1 && ros::ok()){ 
					msg.data[0] = (-k - (3.0 * (vm - k) * (-fabs(enc[0] - posIzq0)/(delta))));
					msg.data[1] = - msg.data[0];
					pubVelMotor.publish(msg);
					ros::spinOnce();
					rate.sleep();
				}
				while(enc[0]>limite2 && ros::ok()){
					msg.data[0] = -vm;
					msg.data[1] = vm;
					pubVelMotor.publish(msg);
					ros::spinOnce();
					rate.sleep();
				}
				while(enc[0]>posIzqFin && ros::ok()){
					msg.data[0] = -(((vm-k)/(delta*0.33333*-1))*(enc[0]-posIzqFin)) - k;
					msg.data[1] = -msg.data[0];
					pubVelMotor.publish(msg);
					ros::spinOnce();
					rate.sleep();
				}
			}
			printf("termine de girar!!!");
			// Se setean en 0 los valores de los encoders en 0
			msg.data[0] = 0.0;
			msg.data[1] = 0.0;
			pubVelMotor.publish(msg);
			ros::spinOnce();
			rate.sleep();
			ros::Duration(1.0).sleep();
			printf("Empiezo a avanzar");
			/*--------------------------------------------------------------Avance----------------------------------------------------*/
			float av = 10;
			av = dist;
			act = false;
			while(!act && ros::ok()){
				printf("Esperando nuevos datos! %f \n",enc[0]);
				ros::spinOnce();
				rate.sleep();
			}
			// Parámetros usados en el perfil trapezoidal
			posIzq0 = enc[0];
			posDer0 = enc[1];
			posIzqFin = posIzq0 + (av/Cll);
			posDerFin = posDer0 + (av/Cll);
			delta = av/Cll;	// Distancia a recorrer
			limite1 = (delta/3.0) + posIzq0;
			limite2 = (delta*(2.0/3.0))+posIzq0;
			printf("%f %f \n",enc[0],limite1);
			/*-------------------------------------Perfil trapezoidal para avance positivo-------------------------------------------*/
			if(av>0){
				printf("Adelante->>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
				printf("delta: %.4f \n",delta);
				msg.data[0] = k; // Desfase de inicio del perfil trapezoidal
				msg.data[1] = k;
				pubVelMotor.publish(msg);
				ros::spinOnce();
				rate.sleep();
				while(enc[0]<limite1  && ros::ok()){
					printf("%f %f %f \n",enc[0],limite1,msg.data[1]);
					float error =fabs(enc[0]- posIzq0); 
					printf("\n**********%f-------------\n",error);
					// Ecuaciones de la primera parte del perfil trapezoidal
					msg.data[0] = k + (3.0 * (vm - k)*(fabs(enc[0] - posIzq0)/(delta)));
					msg.data[1] = msg.data[0];
					pubVelMotor.publish(msg);
					ros::spinOnce();
					rate.sleep();
				}
				while(enc[0]<limite2 && ros::ok()){
					printf("%f %f %f\n",enc[0],limite2,vm);
					// Ecuaciones de la segunda parte del perfil trapezoidal
					msg.data[0] = vm;
					msg.data[1] = msg.data[0];
					pubVelMotor.publish(msg);
					ros::spinOnce();
					rate.sleep();
				}
				while(enc[0]<posIzqFin && ros::ok()){
					printf("%f %f %f\n",enc[0],posIzqFin,msg.data[1]);
					// Ecuaciones de la tercera parte del perfil trapezoidal
					msg.data[0] = vm - (3.0*(vm-k)*((fabs(enc[0]-posIzq0)/(delta))-(2.0/3.0)));
					msg.data[1] = msg.data[0];
					pubVelMotor.publish(msg);
					ros::spinOnce();
					rate.sleep();
				}
			} else{
				/*-------------------------------------Perfil trapezoidal para avance negativo-------------------------------------------*/
				printf("Reversa");
				while(enc[0]>limite1 && ros::ok()){
					printf("%f %f %f\n",enc[0],limite1,msg.data[0]);
					printf("\n ********%f*****+ \n",(enc[0]-posIzq0));
					// Ecuaciones de la primera parte del perfil trapezoidal
					msg.data[0] =(-k - (3.0 * (vm - k) * (-fabs(enc[0] - posIzq0)/(delta))));
					msg.data[1] = msg.data[0];
					pubVelMotor.publish(msg);
					ros::spinOnce();
					rate.sleep();
				}
				while(enc[0]>limite2 && ros::ok()){
					printf("%f %f %f\n",enc[0],limite2,-vm);
					// Ecuaciones de la segunda parte del perfil trapezoidal
					msg.data[0] = -vm;
					msg.data[1] = msg.data[0];
					pubVelMotor.publish(msg);
					ros::spinOnce();
					rate.sleep();
				}
				while(enc[0]>posIzqFin && ros::ok()){
					printf("%f %f %f\n",enc[0],posIzqFin,msg.data[1]);
					// Ecuaciones de la tercera parte del perfil trapezoidal
					msg.data[0] = -(((vm-k)/(delta*0.33333*-1))*(enc[0]-posIzqFin)) - k;
					msg.data[1] = msg.data[0];
					pubVelMotor.publish(msg);
					ros::spinOnce();
					rate.sleep();
				}
			}
			// Se setean los encoders en 0
			msg.data[0] = 0;
			msg.data[1] = 0;
			pubVelMotor.publish(msg);
			printf("Enviado\n");
			ros::spinOnce();
			rate.sleep();
		}else{
			/*----------------------------Control de posición con leyes de control vistas en el diplomado----------------------------*/
			float Wmax = vm/BW;
			float alpha = 0.1;	//Se asume una alpha de modo que la parte lineal tiene a cero
			float beta = 0.01;
			float angulo = 360;
			//Giro
			float posIzq0 = enc[0];
			float posDer0 = enc[1];
			float posIzqFin = posIzq0 + ((D*Pi*angulo)/(Cll*360.0));
			float posDerFin = posDer0 + ((D*Pi*angulo)/(Cll*360.0));
			float error = posIzqFin - enc[0];	
			while(error > 0.0 && ros::ok()){
				msg.data[0] =-(BW*0.5*Wmax)*((2/(1+exp(error/beta)))-1);
				msg.data[1] =(BW*0.5*Wmax)*((2/(1+exp(error/beta)))-1) ;
				pubVelMotor.publish(msg);
				error = posIzqFin - enc[0];
				printf("%f %f\n",msg.data[0],error);
				ros::spinOnce();
				rate.sleep();
			}
			getchar();
		}	
	}
	return 0;
}
