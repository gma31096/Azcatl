#include <ros/ros.h>
#include <tf/transform_listener.h>
#include <geometry_msgs/Twist.h>
#include <simple_move/SimpleMove.h>

ros::Publisher pubCmdVel;
tf::StampedTransform transform;
tf::Quaternion q;
tf::TransformListener *transformListener;

// Función que llama al servicio
bool simpleMoveCallback(simple_move::SimpleMove::Request &req , simple_move::SimpleMove::Response &resp){
 	ros::Rate rate(30);
	bool listo = false;
	while(ros::ok() && !listo){
		printf("se solicito:\n distancia: %f\n  angulo: %f\n",req.distance,req.angle);	
		listo = true;	
	}
	printf("Temine el servicio\n");
}

int main(int argc,char ** argv){
	ros::init(argc,argv,"simple_move_node");
	ros::NodeHandle nh;
	ros::Rate rate(30);
	// Se instancía e servicio "simpleMoveService" del nodehandle que a su vez invoca la función simpleMoveCallback cuando se detona el servicio 
	ros::ServiceServer simpleMoveService = nh.advertiseService("simple_move",simpleMoveCallback);

	while(ros::ok){
		ros::spinOnce();
		rate.sleep();
	}
	return 0;
} 
