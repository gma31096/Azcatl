
(cl:in-package :asdf)

(defsystem "imu-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "ImuValues" :depends-on ("_package_ImuValues"))
    (:file "_package_ImuValues" :depends-on ("_package"))
  ))