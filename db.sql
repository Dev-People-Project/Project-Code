CREATE DATABASE if NOT EXISTS mydb1;
USE mydb1;
CREATE TABLE if NOT EXISTS users(
	user_id INT(10) AUTO_INCREMENT,
	user_name VARCHAR(20) NOT NULL,
	phone_number VARCHAR(20) NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE if NOT EXISTS organization(
	org_id INT(10) AUTO_INCREMENT,
	company VARCHAR(50) NOT NULL,
	manager_name VARCHAR(50) NOT NULL,
	manage_phone_number varchar(20) NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (org_id)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE if NOT EXISTS festival(
	festival_id INT(10) AUTO_INCREMENT,
	festival_name VARCHAR(30) NOT NULL,
	org_id INT(10) NOT NULL,
	period VARCHAR(20) NULL,
	location VARCHAR(10) NOT NULL,
	url VARCHAR(50) NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (festival_id),
	FOREIGN KEY (org_id) REFERENCES organization(org_id) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE if NOT EXISTS store(
	store_id INT(10) AUTO_INCREMENT,
	festival_id INT(20) NOT NULL,
	store_name VARCHAR(20) NOT NULL,
	store_description VARCHAR(150) NULL,
	contact_number VARCHAR(15) NULL,
	category VARCHAR(20) NOT NULL,
	license_number VARCHAR(20) NOT NULL,
	location_number VARCHAR(20) NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (store_id),
	FOREIGN KEY (festival_id) REFERENCES festival(festival_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE if NOT EXISTS menu(
	menu_id INT(20) AUTO_INCREMENT,
	store_id INT(20) NOT NULL,
	menu_name VARCHAR(20) NOT NULL,
	menu_price VARCHAR(10) NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (menu_id),
	FOREIGN KEY (store_id) REFERENCES store(store_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE if NOT EXISTS orders(
	order_id INT(20) AUTO_INCREMENT,
	user_id INT(10) NOT NULL,
	store_id INT(10) NOT NULL,
	menu_name VARCHAR(40) NOT NULL,
	total_qty INT(10) DEFAULT 1,
	total_price INT(30) NOT NULL,
	payment VARCHAR(20) DEFAULT 'Card',
	requests VARCHAR(100) NULL,
	order_time DATETIME DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (order_id),
	FOREIGN KEY(user_id) REFERENCES users(user_id) ON UPDATE CASCADE,
	FOREIGN KEY(store_id) REFERENCES store(store_id) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE if NOT EXISTS order_detail(
	order_detail_id INT(10) AUTO_INCREMENT,
	order_id INT(20) NOT NULL,
	menu_id INT(20) NOT NULL,
	food_price INT(30) NOT NULL,
	order_state VARCHAR(20) DEFAULT '주문중',
	food_qty INT(10) DEFAULT 1,
	PRIMARY KEY (order_detail_id),
	FOREIGN KEY (order_id) REFERENCES orders(order_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (menu_id) REFERENCES menu(menu_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;