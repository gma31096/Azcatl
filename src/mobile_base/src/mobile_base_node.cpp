/*-------------------------------------------------------------
Medrano Albarran Gerardo
Merino Texta Rogelio de Jesus

Mayo 2019

/*--------------------------------------------------------------*/

#include <ros/ros.h>
#include <std_msgs/Int64.h>
#include <std_msgs/Float32MultiArray.h>
#include <std_msgs/Float32.h>
#include <geometry_msgs/Twist.h>
#include <sensor_msgs/JointState.h> 
#include <tf/transform_broadcaster.h>
#include <tf/transform_listener.h>

/*--------Variables de los encoders----------------*/
long currEncoderDer=0;
long currEncoderIzq=0;
long lastEncoderDer=0;
long lastEncoderIzq=0;
/*-----------Medidas del robot---------------------*/
#define BASE_WIDTH 0.235// Ancho de la base del robot
#define r 0.066 //radio de llanta en metros [m]
#define ppmet 7716.6 // Pulsos del encoder en un metro de distancia
/*------------------Posición y orientación----------*/
double robotX = 0.0;
double robotY = 0.0;
double robotT = 0.0;

void callbackEncoderDer(const std_msgs::Int64::ConstPtr &msg){
	currEncoderDer = msg->data;
}
void callbackEncoderIzq(const std_msgs::Int64::ConstPtr &msg){
	currEncoderIzq = msg->data;
}

ros::Publisher pubVelIzq;
ros::Publisher pubVelDer;
tf::TransformListener* tf_listener; // Se instancia la variable tf_listener

void callbackCmdVel(const geometry_msgs::Twist::ConstPtr& msg){
	float velDer = ((msg->linear.x)-(msg->angular.z)*BASE_WIDTH/2.0)/(2.0*3.14159*r);
	float velIzq = ((msg->linear.x)+(msg->angular.z)*BASE_WIDTH/2.0)/(2.0*3.14159*r);
	std_msgs::Float32 msgSend;
	msgSend.data=velIzq;
	pubVelIzq.publish(msgSend);
	msgSend.data = velDer;
	pubVelDer.publish(msgSend);
}
// Función que retorna el valor del ángulo dado en un rango de 0° a 180°
float normalizeAngle(float angle){
	while(angle > M_PI)	angle -= 2.0 * M_PI;
	while(angle > M_PI)	angle += 2.0 * M_PI;
	return angle;
}
void computeOdom(){
	long dIzq = currEncoderIzq - lastEncoderIzq;
	long dDer = currEncoderDer -lastEncoderDer;
	lastEncoderIzq = currEncoderIzq;
	lastEncoderDer = currEncoderDer;

	double disIzq = dIzq/ppmet; // Porcentaje de avance con relación a un metro de distancia
	double disDer = dDer/ppmet;

	double deltaTheta = (disDer-disIzq)/BASE_WIDTH; // Ángulo del robot
	double distX = (disIzq+disDer)/2.0; // Distancia promedio

	// Se actualizan las varuables con los valores desglosados en componentes
	robotT = normalizeAngle(robotT+deltaTheta);
	robotX += distX*cos(robotT);
	robotY += distX*sin(robotT);
}

int main(int argc, char** argv){
	ros::init(argc,argv,"mobile_base_node");
	ros::NodeHandle nh;
	ros::Rate rate(30);

	// Se instancian los subscriptores y publicadores
	ros::Subscriber subEncoD = nh.subscribe("/encoDer",1,callbackEncoderDer);
	ros::Subscriber subEncoI = nh.subscribe("/encoIzq",1,callbackEncoderIzq);
	ros::Subscriber subCmdVel = nh.subscribe("/cmd_vel",1,callbackCmdVel);
	ros::Publisher pubJointState = nh.advertise<sensor_msgs::JointState>("/joint_states",1);
	// Se invoca al método advertise
	pubVelIzq = nh.advertise<std_msgs::Float32>("/vel_motor_Izq",1);
	pubVelDer = nh.advertise<std_msgs::Float32>("/vel_motor_Der",1);
	// Se instancia un nuevo objeto "TransformListener"
	tf_listener = new tf::TransformListener();
	// Variables para la odometría en RVIZ
	std::string jointNames[2] = {"left_wheel_joint_connect","right_wheel_joint_connect"};
	float jointPositions[2] = {0.0,0.0};
	// Se introducen los nombres y los valores de los joints
	sensor_msgs::JointState jointState;
	jointState.name.insert(jointState.name.begin(),jointNames,jointNames+2);
	jointState.position.insert(jointState.position.begin(),jointPositions,jointPositions + 2);
	// Se instancia el locutor que envía los valores de los joints a RVIZ
	tf::TransformBroadcaster br;

	while(ros::ok){
		computeOdom(); // Se realiza la odometría
		// Se setea un vector con los valores leídos
		tf::Transform transform;
		transform.setOrigin(tf::Vector3(robotX,robotY,0));
		// Se setea un quaternion con el valor de ángulo
		tf::Quaternion q;
		q.setRPY(0,0,robotT);
		transform.setRotation(q); // Indica el ángulo a girar
		br.sendTransform(tf::StampedTransform(transform,ros::Time::now(),"odom","base_link")); // El locutor manda las variable a RVIZ
		pubJointState.publish(jointState); // Se publica el estado de los joints
		rate.sleep();
		ros::spinOnce();
	}
	return 0;
}
	
