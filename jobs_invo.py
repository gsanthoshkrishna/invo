import json,sys
import mysql.connector
from datetime import date,datetime
from bsedata.bse import BSE

config_data = {}

env_val = sys.argv[1]
file_name = "config-"+env_val+".json"
print("file:"+file_name)
with open(file_name, 'r') as config_file:
    config_data = json.load(config_file)
    db_name = config_data['database']

mysql = mysql.connector.connect(
  host="localhost",
  user="root",
  password="Pass@123",
  database=db_name,
  consume_results=True
)

def job_daily_task_creation():
    print("Inserting daily jobs")
    cur = mysql.cursor()
    #insert tasks for tasks whose next_task_date is today.
    #TODO temporarily used distinct to eliminate duplicates. check the sql correctly.
    cur.execute(
    """insert into daily_task 
    select distinct NULL, t.name, t.description, t.id,t.remarks,t.bucket_id,t.bucket_name,'Open',CURDATE(),DATE_ADD(CURDATE(),INTERVAL 7 DAY) , u.name
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


def update_invo_scripts():
    b = BSE()
    dt = datetime.today().strftime('%Y%m%d')
    quotes = ["530517", "533206","500180","543265"]
    columns = ["timestamp","companyName","currentValue","changeValue","pChange","updatedOn","securityID","scripCode","scriptGroup","faceValue","industry","previousClose","previousOpen","dayHigh","dayLow","52weekHigh","52weekLow","weightedAvgPrice","totalTradedValue","totalTradedUnit","totalTradedQuantity","2WeekAvgQuantity","marketCapFull","marketCapFreeFloat","marketCapFreeFloatUnit"]
    insert_values = []
    for qt in quotes:
        q_vals = (dt,)
        q = b.getQuote(qt)
        q_keys = list(q.keys())
        print(f"======{qt}=========")
        print(q)
        for cname in columns:
            if cname in q_keys:
                q_vals = q_vals + (q[cname],)             
            elif cname == "changeValue":
                q_vals = q_vals + (q["change"],)
            elif cname == "scriptGroup":
                q_vals = q_vals + (q["group"],)
            elif cname == "totalTradedUnit":
                q_vals = q_vals + ("NA",)
            elif cname == "marketCapFreeFloatUnit":
                q_vals = q_vals + ("NA",)
            elif cname == "updatedOn":
                q_vals = q_vals + (datetime.today().strftime('%Y-%m-%d'),)                
            else:
                print(cname+" Key not available")
        insert_values.append(q_vals)
    print(insert_values)
    insert_multiple_rows('daily_script_updates', columns, insert_values)




# Insert multiple rows into the table
def insert_multiple_rows( table_name, columns, values_list):
    cursor = mysql.cursor()
    sql = f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES ({', '.join(['%s'] * len(columns))})"
    print(sql)
    cursor.executemany(sql, values_list)
    mysql.commit()
    print(f"{len(values_list)} records inserted into {table_name}.")

def get_latest_scripts(pScript_list):
    b = BSE(update_codes = True)
    b.getScripCodes()


#TODO temporarily disabled this. 
#job_daily_task_creation()
update_invo_scripts()

