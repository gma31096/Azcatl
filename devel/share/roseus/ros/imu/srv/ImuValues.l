;; Auto-generated. Do not edit!


(when (boundp 'imu::ImuValues)
  (if (not (find-package "IMU"))
    (make-package "IMU"))
  (shadow 'ImuValues (find-package "IMU")))
(unless (find-package "IMU::IMUVALUES")
  (make-package "IMU::IMUVALUES"))
(unless (find-package "IMU::IMUVALUESREQUEST")
  (make-package "IMU::IMUVALUESREQUEST"))
(unless (find-package "IMU::IMUVALUESRESPONSE")
  (make-package "IMU::IMUVALUESRESPONSE"))

(in-package "ROS")



(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass imu::ImuValuesRequest
  :super ros::object
  :slots (_readings _degrees ))

(defmethod imu::ImuValuesRequest
  (:init
   (&key
    ((:readings __readings) "")
    ((:degrees __degrees) nil)
    )
   (send-super :init)
   (setq _readings (string __readings))
   (setq _degrees __degrees)
   self)
  (:readings
   (&optional __readings)
   (if __readings (setq _readings __readings)) _readings)
  (:degrees
   (&optional __degrees)
   (if __degrees (setq _degrees __degrees)) _degrees)
  (:serialization-length
   ()
   (+
    ;; string _readings
    4 (length _readings)
    ;; bool _degrees
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _readings
       (write-long (length _readings) s) (princ _readings s)
     ;; bool _degrees
       (if _degrees (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _readings
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _readings (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _degrees
     (setq _degrees (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass imu::ImuValuesResponse
  :super ros::object
  :slots (_data ))

(defmethod imu::ImuValuesResponse
  (:init
   (&key
    ((:data __data) (instance std_msgs::Float32MultiArray :init))
    )
   (send-super :init)
   (setq _data __data)
   self)
  (:data
   (&rest __data)
   (if (keywordp (car __data))
       (send* _data __data)
     (progn
       (if __data (setq _data (car __data)))
       _data)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Float32MultiArray _data
    (send _data :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Float32MultiArray _data
       (send _data :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Float32MultiArray _data
     (send _data :deserialize buf ptr-) (incf ptr- (send _data :serialization-length))
   ;;
   self)
  )

(defclass imu::ImuValues
  :super ros::object
  :slots ())

(setf (get imu::ImuValues :md5sum-) "275b655e231692d8ecb55e38089bec1b")
(setf (get imu::ImuValues :datatype-) "imu/ImuValues")
(setf (get imu::ImuValues :request) imu::ImuValuesRequest)
(setf (get imu::ImuValues :response) imu::ImuValuesResponse)

(defmethod imu::ImuValuesRequest
  (:response () (instance imu::ImuValuesResponse :init)))

(setf (get imu::ImuValuesRequest :md5sum-) "275b655e231692d8ecb55e38089bec1b")
(setf (get imu::ImuValuesRequest :datatype-) "imu/ImuValuesRequest")
(setf (get imu::ImuValuesRequest :definition-)
      "string readings
bool degrees
---
std_msgs/Float32MultiArray data

================================================================================
MSG: std_msgs/Float32MultiArray
# Please look at the MultiArrayLayout message definition for
# documentation on all multiarrays.

MultiArrayLayout  layout        # specification of data layout
float32[]         data          # array of data


================================================================================
MSG: std_msgs/MultiArrayLayout
# The multiarray declares a generic multi-dimensional array of a
# particular data type.  Dimensions are ordered from outer most
# to inner most.

MultiArrayDimension[] dim # Array of dimension properties
uint32 data_offset        # padding elements at front of data

# Accessors should ALWAYS be written in terms of dimension stride
# and specified outer-most dimension first.
# 
# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]
#
# A standard, 3-channel 640x480 image with interleaved color channels
# would be specified as:
#
# dim[0].label  = \"height\"
# dim[0].size   = 480
# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)
# dim[1].label  = \"width\"
# dim[1].size   = 640
# dim[1].stride = 3*640 = 1920
# dim[2].label  = \"channel\"
# dim[2].size   = 3
# dim[2].stride = 3
#
# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.

================================================================================
MSG: std_msgs/MultiArrayDimension
string label   # label of given dimension
uint32 size    # size of given dimension (in type units)
")

(setf (get imu::ImuValuesResponse :md5sum-) "275b655e231692d8ecb55e38089bec1b")
(setf (get imu::ImuValuesResponse :datatype-) "imu/ImuValuesResponse")
(setf (get imu::ImuValuesResponse :definition-)
      "string readings
bool degrees
---
std_msgs/Float32MultiArray data

================================================================================
MSG: std_msgs/Float32MultiArray
# Please look at the MultiArrayLayout message definition for
# documentation on all multiarrays.

MultiArrayLayout  layout        # specification of data layout
float32[]         data          # array of data


================================================================================
MSG: std_msgs/MultiArrayLayout
# The multiarray declares a generic multi-dimensional array of a
# particular data type.  Dimensions are ordered from outer most
# to inner most.

MultiArrayDimension[] dim # Array of dimension properties
uint32 data_offset        # padding elements at front of data

# Accessors should ALWAYS be written in terms of dimension stride
# and specified outer-most dimension first.
# 
# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]
#
# A standard, 3-channel 640x480 image with interleaved color channels
# would be specified as:
#
# dim[0].label  = \"height\"
# dim[0].size   = 480
# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)
# dim[1].label  = \"width\"
# dim[1].size   = 640
# dim[1].stride = 3*640 = 1920
# dim[2].label  = \"channel\"
# dim[2].size   = 3
# dim[2].stride = 3
#
# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.

================================================================================
MSG: std_msgs/MultiArrayDimension
string label   # label of given dimension
uint32 size    # size of given dimension (in type units)
")



(provide :imu/ImuValues "275b655e231692d8ecb55e38089bec1b")


