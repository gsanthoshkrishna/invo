CREATE DATABASE invo;

USE invo;

CREATE TABLE bucket (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    duration INT
);



-- Insert some sample data
INSERT INTO bucket (name, description, duration) VALUES
('Bucket 1', 'Description for bucket 1', 30),
('Bucket 2', 'Description for bucket 2', 45);

INSERT INTO items (name, description, bucket_id) VALUES
('Item 1', 'Description for item 1', 1),
('Item 2', 'Description for item 2', 2);

CREATE TABLE daily_indicators(
    id INT AUTO_INCREMENT PRIMARY KEY,
    date varchar(15),
    indicator varchar(30),
    indicator_id int,
    remarks varchar(30),
    ind_change varchar(20),
    user_id int
)

CREATE TABLE indicators (
  id int DEFAULT NULL,
  name varchar(30) DEFAULT NULL
);

create table invo_user (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name varchar(20), 
    user_id varchar(10), 
    status int,

);
insert into invo_user values(null,'Lakshmi','lakshmi',1,'123');
insert into invo_user values(null,'Raji','raji',1,'raji123');
insert into invo_user values(null,'Neelima','neelima',1,'n123');



create table assign_task(     
    id INT AUTO_INCREMENT PRIMARY KEY,     
    user_id int,     
    task_id int,
    status int,     
    FOREIGN KEY (user_id) REFERENCES invo_user(id) 
);
insert into assign_task values (null,1,1,1);
insert into assign_task values (null,1,1,2);
insert into assign_task values (null,2,1,1);
insert into assign_task values (null,2,1,2);
/*
This is a master table of invo tasks.
*/
CREATE TABLE invo_task(
    id INT AUTO_INCREMENT PRIMARY KEY,
	name varchar(20),
	description varchar(100),
	bucket_id INT,
	bucket_name varchar(20),
	remarks varchar(30),
	recuring int,
    day_of_week varchar(20),
    FOREIGN KEY (bucket_id) REFERENCES bucket(id)    
)
insert into invo_task values(null, 'Daily Market Update','Daily Market Update',1, 'invo','0','test')

/*
Updated table names 
invo_task_list -> daily_task 
daily_task -> daily_task_status
*/
/*
This is to store day wise tasks to be done.
*/
CREATE TABLE daily_task(
    id INT AUTO_INCREMENT PRIMARY KEY,
	name varchar(20),
    description varchar(100),
	task_id INT,
	remarks varchar(30),
    bucket_id INT, 
    bucket_name varchar(20),
	status ENUM('Open', 'Progress', 'Done','Error'),
    task_date date,
    next_task_date date,
    owner varchar(20),
    FOREIGN KEY (task_id) REFERENCES invo_task(id)    
) 

-- Sample daily task insertion.'Weekly Mkt Summary',
insert into daily_task VALUES(NULL,'Daily Market Summary','test desc',1,'test remarks',1,'invo', 'Open',CURDATE(),DATE_ADD(CURDATE(),INTERVAL 7 DAY))

select t.name, t.description, t.id,t.remarks,t.bucket_id,t.bucket_name,'Open',CURDATE(),DATE_ADD(CURDATE(),INTERVAL 7 DAY) , u.name
from    assign_task a, 
        invo_task t, 
        invo_user u 
where   t.id = a.task_id and 
        u.id = a.user_id and
        (t.day_of_week like CONCAT('%',DAYOFWEEK(CURDATE()),'%') or t.day_of_week like '%0%');


create table tr_daily_changes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    tr_date date,
    tr_open int,
    tr_close int,
    tr_low int,
    tr_high int,
    user_id int
)


alter table invo_user add column passwd varchar(20) ;
alter table items add column count int;

/*
This table to create a watch list and also 
to display what are existing shares count and buckets
*/
create table watchlist(
    name varchar(30),
    buckets varchar(100),
    count int,
    script varchar(10),
    script_name varchar(20)
)

create table scripts(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name varchar(20),
    code varchar(20),
    sector varchar(20),
    exchange ENUM('NSE', 'BSE')
)


alter table daily_indicators add column user_name varchar(20) after user_id


/*in instance*/
alter table tr_daily_changes add column user_name varchar(20)


alter table invo_task add column user_name varchar(20);
create table bucket_details(
    name varchar(50),
    script varchar(20),
    exchange varchar(10),
    quantity int,
    last_updated date,
    avg_price decimal(10,2),
    current_price decimal(10,2)
)

alter table items add column bucket varchar(50)
alter table tr_share add column bucket varchar(50)

create table tr_account(
    id INT AUTO_INCREMENT PRIMARY KEY,
    account varchar(20), 
    debt int, 
    credit int, 
    date date, 
    remarks varchar(50)

)

create table account(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name varchar(20),
    description varchar(30)
)


alter table invo_user add column user_type int;

alter table invo_task modify name varchar(200);
alter table invo_task modify description text;

alter table daily_task modify name varchar(200);
alter table daily_task modify description text;

drop table invo_task_list;

create table daily_script_updates(
    id INT AUTO_INCREMENT PRIMARY KEY,
	timestamp varchar(10),
	companyName varchar(50), 
	currentValue varchar(50), 
	changeValue varchar(50), 
	pchange varchar(50), 
	updatedOn varchar(20), 
	securityID varchar(50), 
	scripCode int, 
	scriptGroup varchar(50), 
	faceValue varchar(50), 
	industry varchar(50), 
	previousClose varchar(50), 
	previousOpen varchar(50), 
	dayHigh varchar(50), 
	dayLow varchar(50), 
	52weekHigh varchar(50), 
	52weekLow varchar(50), 
	weightedAvgPrice varchar(50), 
	totalTradedValue varchar(50),
	totalTradedUnit varchar(10),
	totalTradedQuantity varchar(50), 
	2WeekAvgQuantity varchar(50), 
	marketCapFull varchar(50), 
	marketCapFreeFloat varchar(50), 
	marketCapFreeFloatUnit varchar(10)

)


/* New */
drop table tr_share;

CREATE TABLE tr_share (
    id INT AUTO_INCREMENT PRIMARY KEY,
    script_code varchar(10),
    name VARCHAR(255),
    description TEXT,
    quantity INT,
    price INT,
    tr_date date,
    exchange varchar(10),
    bucket_id INT,
    FOREIGN KEY (bucket_id) REFERENCES bucket(id)
);
/* nohup python3 app.py & > /dev/null &  */      

CREATE TABLE `buyer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
)

CREATE TABLE seller (
  `id` int AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(50),
  `email` varchar(50),
  `phone` varchar(20),
  `city` varchar(20)
)




/******* Tables list********

==========Account=========
acc_item     
account      
tr_account   
tr_budget    

==========INVO============
invo_user    

invo_task    
daily_task   
assign_task  

items        
bucket       
bucket_details
tr_share       

indicators   
daily_indicators    

study_note   
study_note_file     

daily_script_updates
scripts          
watchlist    
=============Inventory=======
update_inventory    
update_inventory_bkp
inventory_item      
buyer        
item
itembkp         
item_details 
















**************************/