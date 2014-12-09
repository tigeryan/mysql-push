CREATE TABLE `products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(45) DEFAULT NULL,
  `product_price` double DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER $$
CREATE PROCEDURE push_message (p1   DOUBLE,  p2   DOUBLE,  p3 BIGINT)
BEGIN
 DECLARE cmd CHAR(255);
 DECLARE result CHAR(255);
 SET cmd = CONCAT('curl https://pubsub.pubnub.com/publish/demo/demo/0/mysql_triggers/0/%22',p1, ',' ,p2, ',' ,p3,'%22');




 SET result = sys_eval(cmd);
END$$;


CREATE DEFINER=`root`@`localhost` PROCEDURE `push_message`(p1   DOUBLE,  p2   DOUBLE,  p3 BIGINT)
BEGIN
 DECLARE cmd TEXT;
 DECLARE result VARCHAR(255);
 SET cmd = 'curl -H \'Content-Type: application/json\' -d \'{"data":"{\"message\":\"hello world\"}","name":"my_event","channel":"test_channel"}\' "http://api.pusherapp.com/apps/99452/events?" "body_md5=8a3501faef6636ca9a5ebbe6f31b5409&" "auth_version=1.0&" "auth_key=7af9fad3df855a1968e5&" "auth_timestamp=1418064913&" "auth_signature=2d729f8def4fb21c8364b45ad426840d39427744f5f4c998946aed208a30aec4&";
 SET result = sys_eval(cmd)';
END



DELIMITER $$
CREATE PROCEDURE push_message (p1   DOUBLE,  p2   DOUBLE,  p3 BIGINT)
BEGIN
 DECLARE cmd TEXT;
 DECLARE result CHAR(255);
 SET cmd = 'curl -H \'Content-Type: application/json\' -d \'{"data":"{\"message\":\"hello world\"}","name":"my_event","channel":"test_channel"}\' "http://api.pusherapp.com/apps/99452/events?" "body_md5=8a3501faef6636ca9a5ebbe6f31b5409&" "auth_version=1.0&" "auth_key=7af9fad3df855a1968e5&" "auth_timestamp=1418064913&" "auth_signature=2d729f8def4fb21c8364b45ad426840d39427744f5f4c998946aed208a30aec4&"';
 SET result = sys_eval(cmd);
END$$;


SELECT sys_eval('c:/windows/curl -H \'Content-Type: application/json\' -d \'{"data":"{\"message\":\"hello world\"}","name":"my_event","channel":"test_channel"}\' "http://api.pusherapp.com/apps/99452/events?" "body_md5=8a3501faef6636ca9a5ebbe6f31b5409&" "auth_version=1.0&" "auth_key=7af9fad3df855a1968e5&" "auth_timestamp=1418064913&" "auth_signature=2d729f8def4fb21c8364b45ad426840d39427744f5f4c998946aed208a30aec4&"')

CALL push_message(0,0,0);


Error Code: 1126. Can't open shared library 'lib_mysqludf_sys.dll' (errno: 193 )



DROP FUNCTION IF EXISTS sys_eval;
DROP FUNCTION IF EXISTS sys_exec;
DROP FUNCTION IF EXISTS sys_get;
DROP FUNCTION IF EXISTS sys_set;

CREATE FUNCTION sys_eval RETURNS STRING SONAME 'C:\Program Files\MySQL\MySQL Server 5.6\lib\plugin\lib_mysqludf_sys.dll';
CREATE FUNCTION sys_exec RETURNS STRING SONAME 'lib_mysqludf_sys.dll';
CREATE FUNCTION sys_get  RETURNS STRING SONAME 'lib_mysqludf_sys.dll';
CREATE FUNCTION sys_set  RETURNS STRING SONAME 'lib_mysqludf_sys.dll';

DROP FUNCTION IF EXISTS preg_capture;
DROP FUNCTION IF EXISTS preg_check;
DROP FUNCTION IF EXISTS preg_position;
DROP FUNCTION IF EXISTS preg_replace;
DROP FUNCTION IF EXISTS preg_rlike;
DROP FUNCTION IF EXISTS lib_mysqludf_preg_info;

CREATE FUNCTION preg_capture            RETURNS STRING SONAME 'lib_mysqludf_preg.dll';
CREATE FUNCTION preg_check              RETURNS STRING SONAME 'lib_mysqludf_preg.dll';
CREATE FUNCTION preg_position           RETURNS STRING SONAME 'lib_mysqludf_preg.dll';
CREATE FUNCTION preg_replace            RETURNS STRING SONAME 'lib_mysqludf_preg.dll';
CREATE FUNCTION preg_rlike              RETURNS STRING SONAME 'lib_mysqludf_preg.dll';
CREATE FUNCTION lib_mysqludf_preg_info  RETURNS STRING SONAME 'lib_mysqludf_preg.dll';
