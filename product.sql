CREATE TABLE `products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(45) DEFAULT NULL,
  `product_price` double DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `sixfoottiger`.`products`(`product_name`,`product_price`) VALUES('Product 4',5.99);

CREATE DEFINER=`root`@`localhost` PROCEDURE `push_message2`(p1   DOUBLE,  p2   DOUBLE,  p3 BIGINT)
BEGIN
 DECLARE cmd TEXT;
 DECLARE result VARCHAR(255);
 SET cmd = 'curl "http://127.0.0.1:8600/mysql-push/push.cfc?method=sendPush"';
 SET result = sys_exec(cmd);
END

DROP TRIGGER products_AFTER_INSERT;
DROP TRIGGER products_AFTER_DELETE;
DROP TRIGGER products_AFTER_UPDATE;

DELIMITER $$
CREATE TRIGGER `sixfoottiger`.`products_AFTER_DELETE` AFTER DELETE ON `products`
FOR EACH ROW
BEGIN
	DECLARE cur1 CURSOR FOR select sys_exec('curl "http://127.0.0.1:8600/mysql-push/push.cfc?method=sendPush"');
	OPEN cur1;
    INSERT INTO product_log(log_text) VALUES(CONCAT('delete: ',OLD.product_id));
END$$;

DELIMITER $$
CREATE TRIGGER `sixfoottiger`.`products_AFTER_INSERT` AFTER INSERT ON `products`
FOR EACH ROW
BEGIN
	DECLARE cur1 CURSOR FOR select sys_exec('curl "http://127.0.0.1:8600/mysql-push/push.cfc?method=sendPush"');
	OPEN cur1;
    INSERT INTO product_log(log_text) VALUES(CONCAT('insert: ',NEW.product_id));
END$$;

DELIMITER $$
CREATE TRIGGER `sixfoottiger`.`products_AFTER_UPDATE` AFTER UPDATE ON `products`
FOR EACH ROW
BEGIN
	DECLARE cur1 CURSOR FOR select sys_exec('curl "http://127.0.0.1:8600/mysql-push/push.cfc?method=sendPush"');
	OPEN cur1;
    INSERT INTO product_log(log_text) VALUES(CONCAT('UPDATE: ',NEW.product_id));
END$$;

show variables like 'plugin_dir';

DROP FUNCTION IF EXISTS sys_eval;
DROP FUNCTION IF EXISTS sys_exec;
DROP FUNCTION IF EXISTS sys_get;
DROP FUNCTION IF EXISTS sys_set;

CREATE FUNCTION sys_eval RETURNS STRING SONAME 'lib_mysqludf_sys.dll';
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
