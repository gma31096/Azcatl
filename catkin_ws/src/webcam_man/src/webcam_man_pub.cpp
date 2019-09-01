#include <ros/ros.h>
#include <opencv2/opencv.hpp>
#include <sensor_msgs/Image.h>
#include <cv_bridge/cv_bridge.h>
#include <image_transport/image_transport.h>

int width = 320;
int height = 240;

int main(int argc,char **argv){
	printf("Start web cam Node \n");
	ros::init(argc,argv,"webcam_man_pub");
	ros::NodeHandle nh;
	ros::Rate rate(50);
	image_transport::ImageTransport it(nh);
	image_transport::Publisher pubImage=it.advertise("/webcam_image",1);
	cv::VideoCapture capture;
	capture.set(cv::CAP_PROP_FRAME_WIDTH, width);
	capture.set(cv::CAP_PROP_FRAME_HEIGHT, height);
	capture.set(cv::CAP_PROP_FPS,10);
	capture.set(cv::CAP_PROP_BUFFERSIZE,3);
	cv::Mat frame;
        capture.open(0);
	int i = 0;
	while(ros::ok()){
		printf("%d\n",i++);
		capture.read(frame);
		sensor_msgs::ImagePtr msg = cv_bridge::CvImage(std_msgs::Header(),"bgr8",frame).toImageMsg();
		pubImage.publish(msg);
		ros::spinOnce();
		rate.sleep();
	}	
	return 0;
}
