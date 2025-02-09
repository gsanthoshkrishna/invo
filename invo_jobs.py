import json
mysql = mysql.connector.connect(
  host="localhost",
  user="root",
  password="Pass@123",
  database="invo",
  consume_results=True
)

"select  from daily_task where task_date = CURDATE()"

"insert into daily_task VALUES(NULL,'Daily Market Summary','test desc',1,'test remarks',1,'invo', 'Open',CURDATE(),DATE_ADD(CURDATE(),INTERVAL 7 DAY))"
