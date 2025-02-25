import json
import mysql.connector
from datetime import date
mysql = mysql.connector.connect(
  host="localhost",
  user="root",
  password="Pass@123",
  database="invo",
  consume_results=True
)

def job_daily_task_creation():
    print("Inserting daily jobs")
    cur = mysql.cursor()
    #insert tasks for tasks whose next_task_date is today.
    cur.execute(
    """insert into daily_task 
    select NULL, t.name, t.description, t.id,t.remarks,t.bucket_id,t.bucket_name,'Open',CURDATE(),DATE_ADD(CURDATE(),INTERVAL 7 DAY) , u.name
    from
        assign_task a, 
        invo_task t, 
        invo_user u 
    where   
        t.id = a.task_id and 
        u.id = a.user_id and
        (t.day_of_week like CONCAT('%',DAYOFWEEK(CURDATE()),'%') or t.day_of_week like '%0%')
        """
    )

    mysql.commit()
    cur.close()


job_daily_task_creation()
