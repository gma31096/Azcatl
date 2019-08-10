; Auto-generated. Do not edit!


(cl:in-package imu-srv)


;//! \htmlinclude ImuValues-request.msg.html

(cl:defclass <ImuValues-request> (roslisp-msg-protocol:ros-message)
  ((readings
    :reader readings
    :initarg :readings
    :type cl:string
    :initform "")
   (degrees
    :reader degrees
    :initarg :degrees
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ImuValues-request (<ImuValues-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ImuValues-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ImuValues-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name imu-srv:<ImuValues-request> is deprecated: use imu-srv:ImuValues-request instead.")))

(cl:ensure-generic-function 'readings-val :lambda-list '(m))
(cl:defmethod readings-val ((m <ImuValues-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader imu-srv:readings-val is deprecated.  Use imu-srv:readings instead.")
  (readings m))

(cl:ensure-generic-function 'degrees-val :lambda-list '(m))
(cl:defmethod degrees-val ((m <ImuValues-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader imu-srv:degrees-val is deprecated.  Use imu-srv:degrees instead.")
  (degrees m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ImuValues-request>) ostream)
  "Serializes a message object of type '<ImuValues-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'readings))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'readings))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'degrees) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ImuValues-request>) istream)
  "Deserializes a message object of type '<ImuValues-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'readings) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'readings) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'degrees) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ImuValues-request>)))
  "Returns string type for a service object of type '<ImuValues-request>"
  "imu/ImuValuesRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ImuValues-request)))
  "Returns string type for a service object of type 'ImuValues-request"
  "imu/ImuValuesRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ImuValues-request>)))
  "Returns md5sum for a message object of type '<ImuValues-request>"
  "275b655e231692d8ecb55e38089bec1b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ImuValues-request)))
  "Returns md5sum for a message object of type 'ImuValues-request"
  "275b655e231692d8ecb55e38089bec1b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ImuValues-request>)))
  "Returns full string definition for message of type '<ImuValues-request>"
  (cl:format cl:nil "string readings~%bool degrees~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ImuValues-request)))
  "Returns full string definition for message of type 'ImuValues-request"
  (cl:format cl:nil "string readings~%bool degrees~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ImuValues-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'readings))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ImuValues-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ImuValues-request
    (cl:cons ':readings (readings msg))
    (cl:cons ':degrees (degrees msg))
))
;//! \htmlinclude ImuValues-response.msg.html

(cl:defclass <ImuValues-response> (roslisp-msg-protocol:ros-message)
  ((data
    :reader data
    :initarg :data
    :type std_msgs-msg:Float32MultiArray
    :initform (cl:make-instance 'std_msgs-msg:Float32MultiArray)))
)

(cl:defclass ImuValues-response (<ImuValues-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ImuValues-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ImuValues-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name imu-srv:<ImuValues-response> is deprecated: use imu-srv:ImuValues-response instead.")))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <ImuValues-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader imu-srv:data-val is deprecated.  Use imu-srv:data instead.")
  (data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ImuValues-response>) ostream)
  "Serializes a message object of type '<ImuValues-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'data) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ImuValues-response>) istream)
  "Deserializes a message object of type '<ImuValues-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'data) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ImuValues-response>)))
  "Returns string type for a service object of type '<ImuValues-response>"
  "imu/ImuValuesResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ImuValues-response)))
  "Returns string type for a service object of type 'ImuValues-response"
  "imu/ImuValuesResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ImuValues-response>)))
  "Returns md5sum for a message object of type '<ImuValues-response>"
  "275b655e231692d8ecb55e38089bec1b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ImuValues-response)))
  "Returns md5sum for a message object of type 'ImuValues-response"
  "275b655e231692d8ecb55e38089bec1b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ImuValues-response>)))
  "Returns full string definition for message of type '<ImuValues-response>"
  (cl:format cl:nil "std_msgs/Float32MultiArray data~%~%================================================================================~%MSG: std_msgs/Float32MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%float32[]         data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding elements at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ImuValues-response)))
  "Returns full string definition for message of type 'ImuValues-response"
  (cl:format cl:nil "std_msgs/Float32MultiArray data~%~%================================================================================~%MSG: std_msgs/Float32MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%float32[]         data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding elements at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ImuValues-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'data))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ImuValues-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ImuValues-response
    (cl:cons ':data (data msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ImuValues)))
  'ImuValues-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ImuValues)))
  'ImuValues-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ImuValues)))
  "Returns string type for a service object of type '<ImuValues>"
  "imu/ImuValues")