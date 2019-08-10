// Auto-generated. Do not edit!

// (in-package imu.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class ImuValuesRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.readings = null;
      this.degrees = null;
    }
    else {
      if (initObj.hasOwnProperty('readings')) {
        this.readings = initObj.readings
      }
      else {
        this.readings = '';
      }
      if (initObj.hasOwnProperty('degrees')) {
        this.degrees = initObj.degrees
      }
      else {
        this.degrees = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ImuValuesRequest
    // Serialize message field [readings]
    bufferOffset = _serializer.string(obj.readings, buffer, bufferOffset);
    // Serialize message field [degrees]
    bufferOffset = _serializer.bool(obj.degrees, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ImuValuesRequest
    let len;
    let data = new ImuValuesRequest(null);
    // Deserialize message field [readings]
    data.readings = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [degrees]
    data.degrees = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.readings.length;
    return length + 5;
  }

  static datatype() {
    // Returns string type for a service object
    return 'imu/ImuValuesRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'eee453f9dfb8e3b509254c34abfb388e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string readings
    bool degrees
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ImuValuesRequest(null);
    if (msg.readings !== undefined) {
      resolved.readings = msg.readings;
    }
    else {
      resolved.readings = ''
    }

    if (msg.degrees !== undefined) {
      resolved.degrees = msg.degrees;
    }
    else {
      resolved.degrees = false
    }

    return resolved;
    }
};

class ImuValuesResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.data = null;
    }
    else {
      if (initObj.hasOwnProperty('data')) {
        this.data = initObj.data
      }
      else {
        this.data = new std_msgs.msg.Float32MultiArray();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ImuValuesResponse
    // Serialize message field [data]
    bufferOffset = std_msgs.msg.Float32MultiArray.serialize(obj.data, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ImuValuesResponse
    let len;
    let data = new ImuValuesResponse(null);
    // Deserialize message field [data]
    data.data = std_msgs.msg.Float32MultiArray.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Float32MultiArray.getMessageSize(object.data);
    return length;
  }

  static datatype() {
    // Returns string type for a service object
    return 'imu/ImuValuesResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e8dd8c36b943fec9ff4f1f0860344475';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    # dim[0].label  = "height"
    # dim[0].size   = 480
    # dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)
    # dim[1].label  = "width"
    # dim[1].size   = 640
    # dim[1].stride = 3*640 = 1920
    # dim[2].label  = "channel"
    # dim[2].size   = 3
    # dim[2].stride = 3
    #
    # multiarray(i,j,k) refers to the ith row, jth column, and kth channel.
    
    ================================================================================
    MSG: std_msgs/MultiArrayDimension
    string label   # label of given dimension
    uint32 size    # size of given dimension (in type units)
    uint32 stride  # stride of given dimension
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ImuValuesResponse(null);
    if (msg.data !== undefined) {
      resolved.data = std_msgs.msg.Float32MultiArray.Resolve(msg.data)
    }
    else {
      resolved.data = new std_msgs.msg.Float32MultiArray()
    }

    return resolved;
    }
};

module.exports = {
  Request: ImuValuesRequest,
  Response: ImuValuesResponse,
  md5sum() { return '275b655e231692d8ecb55e38089bec1b'; },
  datatype() { return 'imu/ImuValues'; }
};
