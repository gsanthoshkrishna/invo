from flask import Flask, flash, render_template, request, redirect, url_for, session, jsonify, current_app
import mysql.connector, time, sys, json
from datetime import date, datetime
from flask_session import Session
from decimal import Decimal
from werkzeug.utils import secure_filename
from bsedata.bse import BSE




app = Flask(__name__)
db_name = ""
UPLOAD_FOLDER = 'study-notes/img'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['SESSION_TYPE'] = 'filesystem'
app.config['TEMPLATES_AUTO_RELOAD'] = True
Session(app)
config_data = {}


env_val = sys.argv[1]
print(env_val)
env_app_folder = sys.argv[2]
print(env_app_folder)
file_name = env_app_folder+"/config-"+env_val+".json"
print("file:"+file_name)
with open(file_name, 'r') as config_file:
    config_data = json.load(config_file)
    db_name = config_data['database']
# MySQL database configuration
mysql = mysql.connector.connect(
  host="localhost",
  user="root",
  password="Pass@123",
  database=db_name,
  consume_results=True
)

def insert_many_mysql_record(mysql,sql,rows_to_insert):
    print(sql)
    print(rows_to_insert)
    if not mysql.is_connected():
        print("Mysql connection disconnected")
        mysql = mysql.connector.connect(
            host="",
            user="root",
            password="Pass@123",
            database=db_name,
            consume_results=True
        )
    cursor = mysql.cursor()
    cursor.executemany(sql,rows_to_insert)
    mysql.commit()
    cursor.close()
    print("Ins Cnt:"+str(cursor.rowcount))
    print(cursor.rowcount)
    return cursor.rowcount

def insert_mysql_record(mysql,sql):
    print(sql)
    if not mysql.is_connected():
        print("Mysaql connection disconnected")
        mysql = mysql.connector.connect(
            host="localhost",
            user="root",
            password="Pass@123",
            database=db_name,
            consume_results=True
        )
    cursor = mysql.cursor()
    cursor.execute(sql)
    mysql.commit()
    t_id = cursor.lastrowid
    cursor.close()
    return t_id

@app.route('/upload-note', methods=['GET', 'POST'])
def upload_note():
    if request.method == 'POST':
        # Check if the post request has the file part
        if 'file' not in request.files:
            return 'No file part'
        
        file = request.files['file']
        
        # If user does not select file, browser also
        # submit an empty part without filename
        if file.filename == '':
            return jsonify({'notes':notes, 'ret_msg':"No file name."})
        
        if file:
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            return jsonify({'notes':notes, 'ret_msg':"File uploaded successfully"})

    return jsonify({'notes':notes, 'ret_msg':"Error while uploading file."})

@app.route('/job_daily_task_creation')
def job_daily_task_creation():
    print("Inserting daily jobs")
    cur = mysql.cursor()
    #first get the tasks which are in open status in invo_task.
    qry = """
    SELECT id,name,description,bucket_id,bucket_name,remarks,recuring,day_of_week,user_name,status
    FROM invo_task where status = 'Open' and (day_of_week like CONCAT('%',DAYOFWEEK(CURDATE()),'%') or day_of_week like '%0%')
    """
    print(qry)
    cur.execute(qry)
    tasks = cur.fetchall()
    for task in tasks:
        #Get the open tasks assigned owners.
        qry = f"SELECT user_id FROM assign_task where task_id = {task[0]}"
        print(task)
        print(qry)
        cur.execute(qry)
        assign_users = cur.fetchall()
        for a_usr in assign_users:
            #insert new tasks initially in daily_task.
            user_details = get_user_details(a_usr[0])
            #id,name,description,bucket_id,bucket_name,remarks,recuring,day_of_week,user_name,status
            #id,name,description,task_id,remarks,bucket_id,bucket_name,status,task_date,nxttsk,ownr
            insrt_qry = f"""insert into daily_task (name, description, task_id,bucket_id,bucket_name,status,task_date,next_task_date,owner) 
            values( '{task[1]}', '{task[2]}', '{task[0]}','{task[3]}','{task[4]}','Open',CURDATE(),DATE_ADD(CURDATE(),INTERVAL 1 DAY) , '{user_details[1]}' )            
            """
            insert_mysql_record(mysql,insrt_qry)
            #after successful insertion mark as in progress in invo_tasks;
            qry = f"update invo_task set status = 'Progress' where id = {task[0]}"
            insert_mysql_record(mysql,qry)

    
    #update the tasks of next_task_date is today.
    qry = """ insert into daily_task SELECT NULL,name, description,task_id,remarks,bucket_id,bucket_name,'Open',CURDATE(),DATE_ADD(CURDATE(),INTERVAL 1 DAY),owner
    FROM daily_task 
    where status = 'Open' and next_task_date = CURDATE()
    """
    insert_mysql_record(mysql,qry)
    #Update the pushed task to null to avoid repeated creation.
    qry = """
    update daily_task set next_task_date = NULL 
    where status = 'Open' and next_task_date = CURDATE()
    """
    insert_mysql_record(mysql,qry)
    return redirect("/")


@app.route('/login', methods=['GET', 'POST'])
def user_login():
    if request.method == "POST":
        print(request.form.get('name'))
        
        login_ret = get_user_info(request.form.get('name'),request.form.get('passwd'))
        if login_ret == 1:
            return redirect("/")
        #TODO temp add this below condition in above with OR
        if login_ret == 0:
            return redirect("/")
        if login_ret == 2:
            return render_template('login.html',msg="Invalid Credentials")
        if login_ret == -1:
            return render_template('login.html',msg="Invalid UserID")
    return render_template('login.html',msg="")

def get_user_info(user_id, pswd):
    cur = mysql.cursor()
    qry = "SELECT * FROM invo_user where user_id = '"+user_id+"'"
    print(qry)
    cur.execute(qry)
    users = cur.fetchall()
    ret_val = -1
    for usr in users:
        #first login
        if usr[4] is None:
            cur.execute("update invo_user set passwd = '"+pswd+"' where user_id = '"+user_id+"'")
            print("password updated")
            ret_val = 0
        if usr[4] == pswd:
            ret_val = 1
        else:
            #login failed creds.
            ret_val = 2
            return ret_val
        session['user_name'] = usr[1]
        session['user_id'] = usr[3]
        session['user_uid'] = usr[0]
        session['user_type'] = usr[5]

    cur.close()

    return ret_val
@app.route('/')
def index():
    if not session.get('user_name'):
        print("No Session name")
        return redirect('/login')
    name = session.get('user_name')
    return render_template('invo.html',name = name)

@app.route('/trackers')
def trackers():
    return render_template("/trackers.html")

@app.route('/daily_changes', methods=['GET', 'POST'])
def test_get_changes():
    print("in market changes")
    
    if request.method == 'POST':
        print("in Post")
        if request.is_json:
            data = request.get_json()
            if data.get('request_type') == 'ajax':
                print("In Ajax post")
                entry_date = data.get('date_value')
                cursor = mysql.cursor()
                cursor.execute("select tr_open, tr_open, tr_low, tr_close from tr_daily_changes where tr_date='"+entry_date+"' and user_name='"+str(session.get('user_id'))+"'")
                day_changes = cursor.fetchall()
                cursor.close()
                print('rendering test-get template')
                return render_template('tr_daily_changes.html', indicators=day_changes, current_date=entry_date)
            else:
                print("Post but not ajax")
        else:
            print("getting data for today")
            entry_date = request.form.get('date')
            #current_date = date.today().strftime('%Y-%m-%d')
            cursor = mysql.cursor()
            cursor.execute("select tr_open, tr_open, tr_low, tr_close from tr_daily_changes where tr_date='"+entry_date+"' and user_name='"+str(session.get('user_id'))+"'")
            day_changes = cursor.fetchall()
            cursor.close()
            print('rendering template for today')
            return render_template('tr_daily_changes.html', indicators=day_changes, current_date=entry_date)
    else:
        print("getting data for today")
        entry_date = date.today().strftime('%Y-%m-%d')
        cursor = mysql.cursor()
        sql = "select tr_open, tr_open, tr_low, tr_close from tr_daily_changes where tr_date='"+entry_date+"' and user_name='"+str(session.get('user_id'))+"'"
        print(sql)
        cursor.execute(sql)
        day_changes = cursor.fetchall()
        cursor.close()
        print('rendering template')
        return render_template('tr_daily_changes.html', indicators=day_changes, current_date=entry_date)

@app.route('/create-task', methods=['GET', 'POST'])
def create_task():
    if request.method == 'POST':
        print("Creating task")
        
        entry_date = request.form.get('date')
        t_user = request.form.get('user')
        t_name = request.form.get('task_name')
        t_desc = request.form.get('task_desc')
        t_recc = request.form.get('task_recc')
        t_bucket = request.form.get('task_bkt')

        sql_vals = "INSERT INTO invo_task (name, description ,bucket_id, day_of_week, user_name, status) VALUES ('%s', '%s','%s', '%s','%s','Open')" % (t_name, t_desc,t_bucket,t_recc,t_user)
        print('sql qry daily indicator:')
        t_id = insert_mysql_record(mysql,sql_vals)
        print("inserted task id"+str(t_id))
        user_details = get_user_details(t_user)
        print("user details")
        print(user_details)
        sql_vals = "INSERT INTO assign_task(user_id, task_id, status) VALUES ('%s','%s',1)" % (user_details[1], t_id)
        insert_mysql_record(mysql,sql_vals)
        return redirect('/create-task')
    else:
        cursor.execute("SELECT user_id,name from invo_user")
        users = cursor.fetchall()
        
        cursor.execute("SELECT id,name from bucket")
        bkts = cursor.fetchall()
        cursor.close()
        return render_template('add_task.html',current_date=date.today().strftime('%Y-%m-%d'),users=users, buckets=bkts)


@app.route('/daily-changes-update', methods=['GET', 'POST'])
def daily_changes_update():
    cursor = mysql.cursor()
    if request.method == 'POST':
        print("Posting Updates")
        
        entry_date = request.form.get('date')
        i_open = request.form.get('t_open')
        i_close = request.form.get('t_close')
        i_ch1 = request.form.get('s_ch1')
        i_ch_val1 = request.form.get('t_ch1')
        i_ch2 = request.form.get('s_ch2')
        i_ch_val2 = request.form.get('t_ch2')

        sql_vals = "INSERT INTO tr_daily_changes (tr_date, tr_open ,tr_close, "+i_ch1+","+i_ch2+", user_name) VALUES ('%s', '%s','%s', '%s','%s','%s')" % (entry_date,i_open, i_close,i_ch_val1,i_ch_val2,session.get('user_id'))
        print('sql qry daily indicator:')
        insert_mysql_record(mysql,sql_vals)
        print("rendering daily changes insert .")
        return redirect('/daily-changes-update')
        cursor = mysql.cursor()
    else:
        cursor.execute("SELECT * from tr_daily_changes")
        items = cursor.fetchall()
        cursor.close()
        return render_template('tr_daily_changes.html',current_date=date.today().strftime('%Y-%m-%d'))

@app.route('/invo_tasks')
def invo_tasks():
    qry = f"""
    SELECT  t.id, t.name, t.description, b.name, u.name, t.task_date, t.status, t.remarks
    FROM daily_task t , invo_user u, bucket b 
    WHERE 
        t.task_date <= CURDATE() and 
        t.status = 'open' and 
        t.owner = {str(session.get('user_uid'))} and 
        u.id = t.owner and 
        b.id = t.bucket_id
    """
    print("sessuserid:"+str(session.get('user_type')))
    if str(session.get('user_type')) == "1":
        qry = f"""
    SELECT  t.id, t.name, t.description, b.name, u.name, t.task_date, t.status, t.remarks
    FROM daily_task t , invo_user u, bucket b 
    WHERE 
        t.task_date <= CURDATE() and 
        t.status = 'open' and 
        u.id = t.owner and 
        b.id = t.bucket_id
    """

    cur = mysql.cursor()
    print(qry)
    cur.execute(qry)
    tasks = cur.fetchall()
    cur.close()
    return render_template('tasks.html', tasks=tasks)
@app.route('/watchlist')
def watch_list():
    cursor = mysql.cursor()
    cursor.execute("select script, script_name, count, buckets from watchlist")
    watch_scripts = cursor.fetchall()
    cursor.close()
    return render_template('watchlist.html', scripts=watch_scripts)

@app.route('/daily-changes')
def daily_changes():
    cursor = mysql.cursor()
    qry = "SELECT tr_date, tr_open, tr_close, tr_low, tr_high,user_id FROM tr_daily_changes where user_id = '"+str(session.get('user_id'))+"' and tr_daily_changes = '"+ch_date+"'"
    cursor.execute()
    details = cursor.fetchall()
    cursor.close()
    return render_template('daily_changes.html', details=details)

@app.route('/buckets')
def show_buckets():
    cursor = mysql.cursor()
    cursor.execute("SELECT name, description, duration FROM bucket where FIND_IN_SET('"+str(session.get('user_uid'))+"', enabled_user) > 0 or "+str(session.get('user_type'))+" = '1'")
    buckets = cursor.fetchall()
    cursor.close()
    return render_template('buckets.html', buckets=buckets)
@app.route('/buy-sell-load', methods=['GET', 'POST'])
def buy_sell_load():
    if request.method == "POST":
        print("In post action")
        action = request.form['action']
        act = "NA"
        name = ""
        if action.startswith('buy_'):
            item_id = action.replace('buy_', '')
            # Handle add action for row with sid
            print("SBuy button clicked for sid:"+item_id+":"+action)
            act = "buy"
        elif action.startswith('sell_'):
            
            item_id = action.replace('sell_', '')
            # Handle delete action for row with sid
            print("Sell button clicked for sid:"+item_id+":"+action)
            act = "sell"
        #This is a post call from items page for buy or sell button
        item_sql = "SELECT script_code,name,bucket, bucket_id FROM items where id='"+item_id+"'"
        print(item_sql)
        cursor = mysql.cursor()
        cursor.execute(item_sql)
        items = cursor.fetchall()
        cursor.close()
        print("rendering buy sell")
        
        print(items)
        item = items[0]
        print("firtst item")
        print(item)
        s_code = item[0]
        name = item[1]
        bucket = item[2]
        bucket_id = item[3]
        return render_template("/buy-sell.html", name = name, bucket = bucket, bucket_id=bucket_id,script_code=s_code, btn_action = act)

@app.route('/get-bucket-summary',methods=['GET', 'POST'])
def get_bucket_summary():
    qry="SELECT b.name,bd.script, bd.quantity, bd.avg_price, bd.quantity * bd.avg_price as Amount FROM bucket_details bd, bucket b where b.id = bd.bucket_id and (FIND_IN_SET('"+str(session.get('user_uid'))+"', b.enabled_user) > 0 or "+str(session.get('user_type'))+" = '1')"
    print(qry)
    cursor = mysql.cursor()
    cursor.execute(qry)
    b_details = cursor.fetchall()
    cursor.close()
    return render_template("bucket_details.html",b_details=b_details)       

@app.route('/buy-sell-insert', methods=['GET', 'POST'])
def buy_sell_insert():
    #This is a post call from buy-sell page
    name = request.form.get('script')
    bucket = request.form.get('bucket')
    exchange = request.form.get('exchange')
    cnt = request.form.get('sc_cnt')
    price = request.form.get('sc_price')
    scode = request.form.get('script_code')
    bucket_id = request.form.get('bucket_id')
    sql_vals = "INSERT INTO tr_share VALUES (NULL,'%s', '%s','','%s','%s',curdate(), '%s','%s')" % (scode,name,cnt, price,exchange,bucket_id)
    insert_mysql_record(mysql,sql_vals)
    update_bucket_details(bucket,name,int(cnt),Decimal(price),exchange)
    return redirect("/items")

@app.route('/items')
def show_items1():
    cursor = mysql.cursor()
    cursor.execute("SELECT id, name, description, bucket, count,script_code FROM items")
    items = cursor.fetchall()
    cursor.close()
    return render_template('items.html', items=items)

@app.route('/script_list')
def script_list():
    cursor = mysql.cursor()
    cursor.execute("SELECT * FROM scripts")
    items = cursor.fetchall()
    cursor.close()
    return render_template('items.html', items=items)

#TODO Temp to test
@app.route('/items1')
def show_items():
    cursor = mysql.cursor()
    cursor.execute("SELECT id,name, status FROM daily_task")
    items = cursor.fetchall()
    cursor.close()
    return render_template('test-task.html', tasks=items)

#TODO get the values from the tasks list if updated any row marked as completed.
@app.route('/daily-task-update', methods=['GET', 'POST'])
def daily_task_update():
    if request.method == 'POST':
        cursor = mysql.cursor()
        status_update = request.form.get('status_update')
        update_task_id = request.form.get('update_task_id')
        print("status:")
        print("update daily_task set status = '"+status_update+"' where id = "+update_task_id)
        cursor.execute(
            "update daily_task set status = '"+status_update+"' where id = "+update_task_id
        )

        mysql.commit()
        cursor.close()

        return redirect('/invo_tasks')

    return redirect("/")

#TODO Test method
@app.route('/test-post-update', methods=['GET', 'POST'])
def test_post_update():
    print("in test post update")
    if request.method == 'POST':
        print("Posting Updates")
        cursor = mysql.cursor()
        entries = request.form.getlist('indicator')
        remarks = request.form.getlist('remark')
        ind_change = request.form.getlist('ind_change')
        entry_date = request.form['date']

        for indicator, ind_change, remark in zip(entries, remarks,ind_change):
            if indicator and remark:  # Ensure both fields are filled
                sql_vals = "INSERT INTO daily_indicators (date, indicator,ind_change, remarks, user_id) VALUES ('%s', '%s','%s', '%s',1)" % (entry_date,indicator, ind_change,remark)
                print('sql qry daily indicator:')
                print(sql_vals)
                cursor.execute(
                    sql_vals 
                )

        mysql.commit()
        cursor.close()
        
        print("rendering test get .")
        return redirect('/get-daily-update')

    cursor = mysql.cursor()
    cursor.execute("select * from indicators ")
    indicators = cursor.fetchall()
    cursor.close()
    print('rendering template')

    return render_template('add_entry.html', indicators=indicators, current_date=date.today().strftime('%Y-%m-%d'))

#TODO temp redirecting as it is configured more places in html files. later replace with original in html files.
@app.route('/test-get-update')
def test_get_update():
    return redirect('/get-daily-update')


#TODO rename method to get-daily-updates
@app.route('/get-daily-update', methods=['GET', 'POST'])
def get_daily_update():
    print("in market update")
    
    if request.method == 'POST':
        print("in Post")
        if request.is_json:
            data = request.get_json()
            if data.get('request_type') == 'ajax':
                print("In Ajax post")
                entry_date = data.get('date_value')
                cursor = mysql.cursor()
                cursor.execute("select indicator, ind_change , remarks from daily_indicators where date='"+entry_date+"' and user_name='"+str(session.get('user_id'))+"'")
                day_indicators = cursor.fetchall()
                cursor.close()
                print('rendering test-get template')
                return render_template('get_daily_updates.html', indicators=day_indicators, current_date=entry_date)
            else:
                print("Post but not ajax")
        else:
            print("getting data for today")
            entry_date = request.form.get('date')
            #current_date = date.today().strftime('%Y-%m-%d')
            cursor = mysql.cursor()
            cursor.execute("select indicator, ind_change , remarks from daily_indicators where date='"+entry_date+"' and user_name='"+str(session.get('user_id'))+"'")
            day_indicators = cursor.fetchall()
            cursor.close()
            print('rendering template for today')
            return render_template('get_daily_updates.html', indicators=day_indicators, current_date=entry_date)
    else:
        print("getting data for today")
        entry_date = date.today().strftime('%Y-%m-%d')
        cursor = mysql.cursor()
        sql = "select indicator, ind_change , remarks from daily_indicators where date='"+entry_date+"' and user_name='"+str(session.get('user_id'))+"'"
        print(sql)
        cursor.execute(sql)
        day_indicators = cursor.fetchall()
        cursor.close()
        print('rendering template')
        return render_template('get_daily_updates.html', indicators=day_indicators, current_date=entry_date)
    #return redirect("/")

@app.route('/market-update', methods=['GET', 'POST'])
def add_entries():
    print("in market update")
    if request.method == 'POST':
        print("Posting Updates")


        cursor = mysql.cursor()
        entries = request.form.getlist('indicator')
        remarks = request.form.getlist('remark')
        ind_change = request.form.getlist('ind_change')
        entry_date = request.form['date']

        print(entries,  remarks, ind_change)
    

        for indicator,  remark, ind_change in zip(entries,  remarks,ind_change):
            if indicator and remark:  # Ensure both fields are filled
                sql_vals = "INSERT INTO daily_indicators (date,  indicator,ind_change, remarks, user_name) VALUES ('%s', '%s','%s', '%s','%s')" % (entry_date,indicator,  ind_change,remark,session.get('user_id'))
                print('sql qry daily indicator:')
                print(sql_vals)
                cursor.execute(
                    sql_vals 
                )

        mysql.commit()
        cursor.close()

        return render_template('invo.html')

    cursor = mysql.cursor()
    cursor.execute("select * from indicators ")
    indicators = cursor.fetchall()
    cursor.close()
    print('rendering template')

    return render_template('add_entry.html', indicators=indicators, current_date=date.today().strftime('%Y-%m-%d'))

#TODO create a function to get tasks todo.
def get_daily_task():
    print("Updating daily task")
    #Get tasks for today.
    #Get the task which is for this day of the week.
    #cursor.execute("SELECT id FROM invo_task where day_of_week like  CONCAT('%',DAYOFWEEK(CURDATE()),'%')")
    #todays_tasks = cursor.fetchall()

    #cursor.execute("select task_id from daily_task where task_date = CURDATE()")
    #existing_tasks = cursor.fetchall()

    #cursor.execute()
    #TODO
    #Insert in daily_task for the newly created invo_task 
    #by checking if the task id in not present in daily_task.
    qry = "insert into daily_task select null,name,'',id,'',bucket_id,bucket_name,'Open',CURDATE(),DATE_ADD(CURDATE(),INTERVAL 7 DAY) from invo_task where id not in (select distinct task_id from daily_task)"
    insert_mysql_record(mysql,qry)    
    #Insert the task from daily_task where next_task_date is today and insert the same record
    #with task_date as today and next_task_date is date + 7Days. And avoid duplicate insertions by checking
    #if for the same task there is another record with next 7 days. 
    qry = "insert into daily_task select null,name,'',task_id,'',bucket_id,bucket_name,'Open',CURDATE(),DATE_ADD(CURDATE(),INTERVAL 7 DAY) from daily_task where next_task_date = CURDATE() and task_id not in (select distinct task_id from daily_task where next_task_date= DATE_ADD(CURDATE(),INTERVAL 7 DAY) )"       
    insert_mysql_record(mysql,qry)


@app.route("/get-study-notes", methods=['GET', 'POST'] )
def get_study_notes():
    cursor = mysql.cursor()
    sqlqry = "select id, name from study_note where user_id = '"+str(session['user_uid'])+"'"
    cursor.execute(sqlqry)
    notes = cursor.fetchall()
    # Load content from the text file
    content = "test..."
    if request.method == "POST":
        if request.is_json:
            data = request.get_json()
            print(data)
            note_id = data.get('note_id') 
            sqlqry = "select filename from study_note_file where note_id = "+note_id
            cursor.execute(sqlqry)
            filenames = cursor.fetchall()
            test="updated"
            cursor.close()
            
            try:
                for filename in filenames:
                    with open(filename[0], 'r') as file:
                        content = file.read()
                        
                        print(content)
                        return jsonify({'notes':notes, 'study_content':content})          
            except e:
                return render_template("study_notes.html",notes=notes, study_content="exception")
            
    print("final test render")
    return render_template("study_notes.html",notes = notes, study_content="Your Notes Here...."+content)

@app.route("/insert-note", methods=['GET', 'POST'] )
def insert_note():
    name = request.form['name']
    file_path = "study-notes/"+name+".txt"
    sql_vals = "insert into study_note values(NULL,'%s',1,'%s')" % (name, session['user_uid'])
    print("Inserting study notes:")
    n_id = insert_mysql_record(mysql,sql_vals)    
    #Immediately create an empty note and its file.
    sql_vals = "insert into study_note_file values('%s','%s')" % (n_id, file_path)
    print("Inserting study notes:")
    insert_mysql_record(mysql,sql_vals)
    with open(file_path, 'a') as file:
    # Write content to the file
        file.write("################### Notes for "+name+" ##################")
    return redirect('/get-study-notes')

@app.route("/update-note", methods=['GET', 'POST'] )
def update_note():
    print("IN update note")
    data = request.get_json()
    name = data.get('note-name')
    print("Updating for note "+name)
    notesContent = data.get('notes-content')
    file_path = "study-notes/"+name+".txt"
    with open(file_path, 'w') as file:
    # Write content to the file
        file.write(notesContent)
    return jsonify({'ret-val':"Success"})


def get_bucket_details(bkt_name,scr_name,exchange):
    print("Fetching details for bucket:"+bkt_name)
    cursor = mysql.cursor()
    sqlqry = "select * from bucket_details where name = '"+bkt_name+"' and script='"+scr_name+"' and exchange='"+exchange+"'"
    cursor.execute(sqlqry)
    bkt_details = cursor.fetchall()
    cursor.close()
    print(bkt_details)
    return bkt_details

def update_bucket_details(bkt_name,scr_name,quantity,price,exchange):
    #updating bucket details
    print("updating bucket details")
    cursor = mysql.cursor()
    cur_vals = get_bucket_details(bkt_name,scr_name,exchange)
    if len(cur_vals) == 0:
        print("Newly added script to bucket")
        sql_vals = "insert into bucket_details values('%s','%s','%s','%s',curdate(),'%s',0)" % (bkt_name, scr_name, exchange, quantity, price)
        insert_mysql_record(mysql,sql_vals)
    else:
        #TODO please validate the below avg_price calculation formula
        for cur_val in cur_vals:
            upd_qnty = cur_val[3] + quantity
            upd_avg_price = ((cur_val[5] * cur_val[3]) + (quantity * price)) / (quantity + cur_val[3])
            sql_vals = "update bucket_details set quantity = "+str(upd_qnty)+", avg_price = "+str(upd_avg_price)+" where name = '"+bkt_name+"' and script='"+scr_name+"' and exchange='"+exchange+"'"
            print(sql_vals)
            cursor.execute(sql_vals)
            mysql.commit()
            cursor.close()

global_users_list = []


def set_user_list():
    global global_users_list
    cursor = mysql.cursor()
    sqlqry = "select id,name,user_id from invo_user where status = 1"
    cursor.execute(sqlqry)
    users_list = cursor.fetchall()
    for user in users_list:
        global_users_list.append("@"+str(user[0])+"@"+user[1]+"@"+user[2]+"@")
    cursor.close()

#This method to take any key and get the user details from format @id@name@userId@
def get_user_details(key):
    for user in global_users_list:
        print("Checking "+str(key)+" against "+user)
        if "@"+str(key)+"@" in user:
            return user.split('@')



    



######################### ACCOUNTS ######################################
@app.route("/ac", methods=['GET', 'POST'] )
def account_transactions():
    cursor = mysql.cursor()
    #todo add where condition for the records with date for the corrent month
    sqlqry = "select date,i.name, debt,fra.name ,remarks FROM tr_account tra, acc_item i, account fra where fra.id = tra.from_acc_id and i.id = tra.item_id"
    print(sqlqry)
    cursor.execute(sqlqry)
    data = cursor.fetchall()
    sqlqry = "select id,name FROM account"
    cursor.execute(sqlqry)
    accounts = cursor.fetchall()
    sqlqry = "select id,name FROM acc_item"
    cursor.execute(sqlqry)
    items = cursor.fetchall()

    cursor.execute("select ac.name, sum(debt) amt from tr_account tr, account ac where ac.id = tr.from_acc_id group by tr.from_acc_id")  # Replace with your table name
    spendings = cursor.fetchall()
    
    cursor.close()
    return render_template("/tr_account.html", spendings = spendings, data = data,accounts=accounts,items=items,current_date=date.today().strftime('%Y-%m-%d'))


@app.route("/add-tr-acc", methods=['GET', 'POST'])
def add_tr_account():
    print("Added new transaction.")
    from_acc = request.form.get('from_acc')    
    item = request.form.get('item')
    dr = request.form.get('dr')
    dt = request.form.get('date')
    remark = request.form.get('remarks')
    cursor = mysql.cursor()
    sql_vals = "insert into tr_account values(NULL,'%s','%s','%s','%s','%s',13)" % ( dr, dt, remark,item,from_acc)
    insert_mysql_record(mysql,sql_vals)
    return redirect("/ac")

@app.route("/insert-acc-item", methods=['GET', 'POST'] )
def insert_acc_item():
    name = request.form['name']
    sql_vals = "insert into account values(NULL,'%s','')" % (name)
    insert_mysql_record(mysql,sql_vals)
    return redirect('/ac')

@app.route("/insert-item", methods=['GET', 'POST'] )
def insert_item():
    name = request.form['itemname']
    sql_vals = "insert into acc_item values(NULL,'%s','','')" % (name)
    insert_mysql_record(mysql,sql_vals)
    return redirect('/ac')

@app.route("/acc-dboard", methods=['GET', 'POST'] )
def acc_dboard2():
    cursor = mysql.cursor()
    #name = request.form['name']
    #sql_vals = "insert into acc_item values(NULL,'%s','')" % (name)
    #print("Inserting New Item:")
    #print(sql_vals)
    #cursor.execute(sql_vals)
    #mysql.commit()
    #cursor.close()
    data = [65, 59, 80, 81, 56, 55]
    labels = ['January', 'February', 'March', 'April', 'May', 'June']
    return render_template('/account_chart.html',data=data, labels=labels)

@app.route("/ac-budget", methods=['GET', 'POST'] )
def ac_budget():
    cursor = mysql.cursor()
    #sqlqry = "select i.name, trb.amount,trb.remarks FROM tr_budget trb, acc_item i where i.id = trb.item_id and trb.month='"+date.today().strftime('%b').upper()+"'"
    sqlqry = "select i.name, trb.amount,trb.remarks FROM tr_budget trb, acc_item i where i.id = trb.item_id"
    print(sqlqry)
    cursor.execute(sqlqry)
    data = cursor.fetchall()
    sqlqry = "select id,name FROM acc_item"
    cursor.execute(sqlqry)
    items = cursor.fetchall()
    cursor.close()
    return render_template("/tr_account_budget.html", data = data,items=items,current_month=date.today().strftime('%b').upper())

@app.route("/add-tr-budget", methods=['GET', 'POST'])
def add_tr_budget():
    print("Added new Budget Item.")
    item = request.form.get('item')
    amt = request.form.get('amount')
    month = request.form.get('month')
    remark = request.form.get('remarks')
    sql_vals = "insert into tr_budget values(NULL,'%s','%s','%s','%s')" % ( item,amt,month,remark)
    insert_mysql_record(mysql,sql_vals)
    return redirect("/ac-budget")

@app.route('/dboard')
def acc_dboard():
    cursor = mysql.cursor()
    cursor.execute("select ac.name, sum(debt) amt from tr_account tr, account ac where ac.id = tr.from_acc_id group by tr.from_acc_id")  # Replace with your table name
    data = cursor.fetchall()
    cursor.close()
    return render_template('acc_dashboard.html', spendings=data)

######################### Inventory ######################################
@app.route("/fetch-item-details",methods=['GET','POST'])
def fetch_item_details():
    if request.method == 'POST':
        item = request.form['item']
        cursor = mysql.cursor()
        avail_stmt = "select  ic.item_id,i.tagval, ic.quantity from inv_count ic , item_details i where i.is_active = 1 and ic.item_id = i.id and i.id = "+str(item)+" limit 1"
        price_stmt = "select ui.mrp, ui.cost MRP from update_inventory ui where ui.item_id = "+item+" order by ui.tr_date desc limit 1"
        print(avail_stmt)
        cursor.execute(avail_stmt)
        items = cursor.fetchall()
        iid=0
        iname = "NA"
        iqty = 0
        print(items)
        for item in items:
            iid = item[0]
            iname = item[1]
            iqty = item[2]
        
        print(price_stmt)
        cursor.execute(price_stmt)
        mrp_res = cursor.fetchall()
        print(mrp_res)
        for mrprow in mrp_res:
            mrp = mrprow[0]
            cost = mrprow[1]
        cursor.close()
        show_popup = True
        return render_template("/inventory_home.html", iid = iid, iname=iname,iqty=iqty, mrp=mrp,cost=cost,show_popup=show_popup)
@app.route("/home")
def inventory_home():
    cursor = mysql.cursor()
    cursor.execute("SELECT id,tagval from item_details where is_active = 1 order by tagval")
    items = cursor.fetchall()
    cursor.close()
    return render_template("inventory_home.html",items=items)

@app.route("/inv-sell-transaction")
def inv_sell_transaction():
    inv_cust_id = request.args.get('inv_cust_id')
    if inv_cust_id == None:
        inv_cust_id = ""

    inv_cust_mob = request.args.get('inv_cust_mob')
    if inv_cust_mob == None:
        inv_cust_mob = ""

    inv_cust_name = request.args.get('inv_cust_name')
    if inv_cust_name == None:
        inv_cust_name = ""
    
    sqlqry = "select id,tagval from item_details where is_active = 1 order by tagval"
    print("In sell transaction")
    cursor = mysql.cursor()
    
    print(sqlqry)
    cursor.execute(sqlqry)
    items = cursor.fetchall()
    print(items)
    for item in items:
        print(item)
    cursor.close()
    return render_template('/inv_sell_transaction.html',items=items,inv_cust_id=inv_cust_id, inv_cust_name=inv_cust_name,inv_cust_mob=inv_cust_mob,current_date=date.today().strftime('%Y-%m-%d'))


@app.route("/newjobcard",methods=['GET','POST'])
def newjobcard():
    inv_cust_id = request.args.get('inv_cust_id')
    if inv_cust_id == None:
        inv_cust_id = ""

    inv_cust_mob = request.args.get('inv_cust_mob')
    if inv_cust_mob == None:
        inv_cust_mob = ""

    inv_cust_name = request.args.get('inv_cust_name')
    if inv_cust_name == None:
        inv_cust_name = ""

    return render_template('/inventory_jobcard.html',inv_cust_id=inv_cust_id, inv_cust_name=inv_cust_name,inv_cust_mob=inv_cust_mob)

@app.route("/inv-load-transaction", methods=['POST'])
def inv_load_transaction():
    print("In load transaction")
    reqdata = request.get_json()
    mobno = reqdata.get("mobile")
    print("mobile")
    print(reqdata)
    cursor = mysql.cursor()
    sqlqry = "select id,name from inv_customer where mobile='"+mobno+"'"
    print(sqlqry)
    cursor.execute(sqlqry)
    data = cursor.fetchall()    
    name = "NA"
    cust_id = "-1"
    for names in data: 
        cust_id = names[0]
        name = names[1]
    return jsonify({'custname': name, 'cust_id': cust_id})
    
@app.route("/insert-inv-cust", methods=['POST'])
def insert_inv_cust():
    custmob = request.form['pCustMob']
    custname = request.form['pCustName']
    custloc = request.form['pCustLoc']
    sql_vals = "insert into inv_customer(mobile,name,location) values('%s','%s','%s')" % (custmob,custname,custloc)
    cust_id = insert_mysql_record(mysql,sql_vals)
    return redirect("/inv-sell-transaction?inv_cust_mob="+custmob+"&inv_cust_name="+custname+"&inv_cust_mob="+custmob+"&inv_cust_id="+str(cust_id))

@app.route("/get-jobCard-details", methods=['POST'])
def get_jobCard_details():
    cust_id = request.form['customer_id']
    print(cust_id)

    sql_query = "select * from inv_jobcard where id=" + cust_id
    print("SQL Q ", sql_query)
    cursor = mysql.cursor()
    cursor.execute(sql_query)
    cust_data = cursor.fetchone()
    print("Data ", cust_data) 

    return render_template('show_customer_details.html', cust_data=cust_data)

#NEXT: Complete this. form values taken need to test.
@app.route("/submit-jobcard", methods=['POST'])
def submit_jobcard():
    cust_id = request.form['cust_id']
    problem = request.form['problem']
    remarks = request.form['remarks']
    photofile = request.files['photo']
    filename = photofile.filename
    print("filename:  ", filename)
    sql_vals = "insert into inv_jobcard(custno,problem,remarks) values('%s','%s','%s')" % (cust_id,problem,remarks)
    
    filepath = config_data['job_card_folder'] + filename
    print("filepath:  "+ filepath)
    # filepath = '/var/lib/mysql-files/uploads/'+filename
    from werkzeug.utils import secure_filename
    photofile.save(filepath)
    
    job_id = insert_mysql_record(mysql,sql_vals)
    img_data = photofile.read()
    sql_vals = "insert into job_card_image(jobcard_id,filename,img) values('%s','%s',LOAD_FILE('%s'))" % (job_id,filename,filepath)
    cust_id = insert_mysql_record(mysql,sql_vals)
    #TODO add successful message in return after verify.
    return jsonify({'retval': "success"})



@app.route("/inv-submit-transaction", methods=['POST'])
def inv_submit_transaction():
    print("In submit transaction")
    reqdata = request.get_json()
    custname = reqdata.get("custname")
    cust_id = reqdata.get("cust_id")
    tot_cost = reqdata.get("totcost")
    itemscnt = reqdata.get("itemscnt")
    tr_date = reqdata.get("tr_date")
    data = reqdata.get("data")

    qty_list = data.get('qty', [])
    price_list = data.get('price', [])
    cost_list = data.get('cost', [])
    items_list = data.get('items',[])

    rows_to_insert = []
    vals_to_update = []
    for i,q in zip(items_list, qty_list):
        cursor = mysql.cursor()
        sqlqry = "select  ic.item_id,i.tagval, ic.quantity from inv_count ic , item_details i where i.is_active = 1 and ic.item_id = i.id and i.id =  "+i        
        print(sqlqry)
        cursor.execute(sqlqry)
        data = cursor.fetchall()
        cursor.close()
        msg = "Items Not Available \n"
        isUnavailable = 0
        for row in data:
            print("Available"+str(row[2])+":Ordered"+str(q))
            if int(row[2]) < int(q):
                isUnavailable = 1
                msg = msg + row[1] + "(Available - "+str(row[2])+")\n"       
                print(msg)
                print("----------")
            print(msg)
            print("Is Unavailable:"+str(isUnavailable)) 

        if isUnavailable == 1:
            print("Returning with unavailable.")
            return jsonify({'retval': "noresource",'msg':msg})

    #First create a bill_reciept details and use the reciept number with detail info.
    sqlqry = "insert into inv_sale_reciept values(NULL, '%s','%s','%s','%s')" % (cust_id, tr_date, tot_cost,itemscnt)
    reciept_num = insert_mysql_record(mysql,sqlqry)
    if reciept_num < 1 :
        print("Generating reciept failed...")
        return jsonify({'retval': 'failure'})
    
    for i,q, p, c in zip(items_list, qty_list, price_list, cost_list ):
        rows_to_insert.append((i, q, p, c))
        vals_to_update.append((q,i))
    
    if rows_to_insert:
        sql = "INSERT INTO tr_inv_sale (reciept_num, itemid, quantity, price, cost, trdate) VALUES ("+str(reciept_num)+",%s, %s, %s,%s,'"+tr_date+"')"
        ins_cnt = insert_many_mysql_record(mysql,sql,rows_to_insert)
        print(str(ins_cnt)+":"+str(itemscnt))

        if str(ins_cnt) == str(itemscnt):
            print("Items inserted:"+str(ins_cnt))
            sqlqry = "update inv_count set quantity = quantity - %s where item_id = %s"
            upd_cnt = insert_many_mysql_record(mysql,sqlqry,vals_to_update)
            generateReciept(reciept_num)
            return jsonify({'retval': 'success'})
    return jsonify({'retval': 'failure'})

def generateReciept(recieptId):
    from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
    from reportlab.lib.pagesizes import A4
    from reportlab.lib import colors
    from reportlab.lib.styles import getSampleStyleSheet
    
    #select * from tr_inv_sale limit 1;
    #select * from inv_sale_reciept limit 1;
    #Reciept Details
    cursor = mysql.cursor()
    sqlqry = "select sr.id as recieptnum, sr.bill_date, sr.amount, sr.item_cnt, c.name,c.mobile from inv_sale_reciept sr, inv_customer c where sr.id = "+str(recieptId)+" and c.id = sr.cust_id"
    print(sqlqry)
    cursor.execute(sqlqry)
    rData = cursor.fetchall()
    
    
    #Reciept Item Details
    sqlqry = "select i.tagval, tr.quantity, tr.price, tr.cost from tr_inv_sale tr,item_details i where i.is_active = 1 and  reciept_num = "+str(recieptId)+" and i.id=tr.itemid"
    print(sqlqry)
    cursor.execute(sqlqry)
    rItems = cursor.fetchall()
    print(rItems)
    cursor.close()
    
    
    

    # Output PDF file
    pdf_file = env_app_folder+"/static/"+str(recieptId)+"_bill_reciept.pdf"
    pdf_file = env_app_folder+"/static/"+str(recieptId)+"_bill_reciept.pdf"
    # Create document
    doc = SimpleDocTemplate(pdf_file, pagesize=A4)
    styles = getSampleStyleSheet()
    story = []

    # Title
    title = Paragraph("<b>Raghu Computers</b>", styles["Title"])
    story.append(title)
    story.append(Spacer(1, 20))
    

    # Sample student data in table form
#        ["Date", rData[0][2]],
 #       ["Name", rData[0][1]],
 #       ["Age", "13"],
#        ["Gender", "Male"],
#        ["Class / Grade", "8th Grade"],
#        ["Email", "santhosh@example.com"],
#        ["Phone Number", "9876543210"],
#        ["Address", "12, Gandhi Street, Chennai"],
#        ["Parent Name", "Mr. Ramesh"],
#        ["Parent Phone", "9123456789"]
    hdata = [["Reciept No.", "Name","Mobile","Date","Items","Amount"]]
    rInfo = []
    rInfo.append(rData[0][0])
    rInfo.append(rData[0][4])
    rInfo.append(rData[0][5])
    rInfo.append(rData[0][1])
    rInfo.append(rData[0][3])
    rInfo.append(rData[0][2])
    hdata.append(rInfo)
    data = [
	["Item","Qty","Price","Cost"]
    ]
    
    for itm in rItems:
      data.append(itm)

    mtable = Table(hdata)
    # Create table
    table = Table(data)

    mtable.setStyle(TableStyle([
        ("BACKGROUND", (0, 0), (-1, 0), colors.lightgrey),
        ("TEXTCOLOR", (0, 0), (-1, 0), colors.black),
        ("ALIGN", (0, 0), (-1, -1), "LEFT"),
        ("FONTNAME", (0, 0), (-1, -1), "Helvetica"),
        ("FONTSIZE", (0, 0), (-1, -1), 12),
        ("GRID", (0, 0), (-1, -1), 1, colors.black),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 8),
        ("TOPPADDING", (0, 0), (-1, -1), 8),
    ]))

    # Table styling
    table.setStyle(TableStyle([
        ("BACKGROUND", (0, 0), (-1, 0), colors.lightgrey),
        ("TEXTCOLOR", (0, 0), (-1, 0), colors.black),
        ("ALIGN", (0, 0), (-1, -1), "LEFT"),
        ("FONTNAME", (0, 0), (-1, -1), "Helvetica"),
        ("FONTSIZE", (0, 0), (-1, -1), 12),
        ("GRID", (0, 0), (-1, -1), 1, colors.black),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 8),
        ("TOPPADDING", (0, 0), (-1, -1), 8),
    ]))


    
    story.append(mtable)
    story.append(table)

    # Build PDF
    doc.build(story)

    print("PDF created successfully:", pdf_file)
    return pdf_file


@app.route("/sale-report")
def sale_report():
    cursor = mysql.cursor()
    sqlqry = "select tis.trdate, ic.name, itd.tagval item,tis.cost,tis.price,tis.quantity   from tr_inv_sale tis, inv_sale_reciept isr, item_details itd, inv_customer ic where itd.is_active = 1 and isr.id = tis.reciept_num and itd.id = tis.itemid and ic.id = isr.cust_id order by tis.trdate desc"
    print(sqlqry)
    cursor.execute(sqlqry)
    data = cursor.fetchall()
    cursor.close()
    return render_template("sale_report.html",items=data)

@app.route("/inv-report")
def inv_report():
    sort_by = request.args.get("sort_by", "item")
    print("sort_by ", sort_by)
    order = request.args.get("order", "asc")
    print("order", order)
    search_inp = request.args.get("q", "").strip()
    print("search", search_inp)
    
    sqlqry = "select  ic.item_id,i.tagval, ic.quantity from inv_count ic , item_details i where i.is_active = 1 and ic.item_id = i.id "
    cursor = mysql.cursor()
    params = []

    if search_inp:
        sqlqry += " and i.tagval LIKE %s "
        params.append(f"%{search_inp}%")

    if sort_by == "count":
        sqlqry += "order by ic.quantity"
    else :
        sqlqry += "order by i.tagval"
    sqlqry += " " + order
    print(sqlqry)
    print("params", params)
    # cursor.execute(sqlqry)
    cursor.execute(sqlqry, params)
    data = cursor.fetchall()
    # print("data", data)
    cursor.close()
    return render_template("inv_report.html",items=data, q=search_inp)

@app.route("/inv-entry-edit", methods=['GET', 'POST'])
def inv_entry_edit():
    if request.method == "POST":
        cnt = request.json['cnt']
        rowid = request.json['rowid']
        qry = f"update update_inventory set quantity = {cnt} where id = {rowid}"
        insert_mysql_record(mysql,qry)
    return jsonify({'ret_msg':"done."})

@app.route("/inv-entry-delete", methods=['GET', 'POST'])
def inv_entry_delete():
    if request.method == "POST":
        rowid = request.json['rowid']
        qry = f"delete from update_inventory where id = {rowid}"
        insert_mysql_record(mysql,qry)
    return jsonify({'ret_msg':"done."})

@app.route("/inv-entry-report")
def inv_entry_report():
    cursor = mysql.cursor()
    sqlqry = "select tr_date,itd.tagval,concat(b.name,', ',city) buyer ,ui.quantity,ui.id update_id, ui.mrp MRP from update_inventory ui, item_details itd, buyer b where itd.is_active = 1 and itd.id = ui.item_id and b.id = ui.buyer_id order by tr_date desc"
    print(sqlqry)
    cursor.execute(sqlqry)
    data = cursor.fetchall()
    cursor.close()
    return render_template("inv_entry_report.html",entries=data)

@app.route("/inv-sale-reciepts",methods=['GET', 'POST'])
def inv_sale_reciepts():
    cursor = mysql.cursor()
    sqlqry = "select sr.id as recieptnum, sr.bill_date, sr.amount, sr.item_cnt, c.name,c.mobile from inv_sale_reciept sr, inv_customer c where c.id = sr.cust_id order by sr.id desc limit 30"
    print(sqlqry)
    cursor.execute(sqlqry)
    rData = cursor.fetchall()
    cursor.close()
    if request.method == "POST":
        #Generating Reciept
        reciept_num = request.json['recieptid']
        file_url = generateReciept(reciept_num)
        print("Reciept Generated.")
    return render_template("inv_sale_reciepts.html",entries=rData)

@app.route("/add-buyer", methods=['GET', 'POST'])
def add_buyer():
    if request.method == "POST":
        print("Adding new Buyer.")
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        city = request.form.get('city')
        sql_vals = "insert into buyer values(NULL,'%s','%s','%s','%s')" % (name, email, phone, city)
        insert_mysql_record(mysql,sql_vals)
    return render_template("add_buyer.html")

@app.route("/add-seller", methods=['GET', 'POST'])
def add_seller():
    if request.method == "POST":
        print("Adding new Seller.")
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        city = request.form.get('city')
        sql_vals = "insert into seller values(NULL,'%s','%s','%s','%s')" % (name, email, phone, city)
        insert_mysql_record(mysql,sql_vals)
    return render_template("/add_seller.html")


@app.route('/add-item')
def add_item():
    cursor = mysql.cursor()
    cursor.execute("SELECT id, name FROM inventory_item")
    categories = cursor.fetchall()
    cursor.close()
    return render_template('/new_inventory1.html', items=categories)

@app.route('/get_tags/<name>')
def get_tags(name):
    cursor = mysql.cursor()
    query = "SELECT tag FROM inventory_item WHERE id = %s" % (name)
    print(query)
    cursor.execute(query)
    result = cursor.fetchone()
    cursor.close()
    if result and result[0]:
        print(result)
        
        return jsonify(tags=result[0].split(','))
    return jsonify(tags=[])

@app.route('/add-item', methods=['POST'])
def insert_inv_item():
    if request.method == "POST":
        print("testprint")
        form_data = request.form
        print("testpr2")
        print(form_data)
        item_id = ""
        cursor = mysql.cursor()
        item_str = ""
        for key, value in form_data.items():
            item_str = item_str + value + ";"
            if key == "item_id":
                item_id = value
                continue
            print(f"{key}: {value}")
            #sql = "insert into item_details values(NULL,'%s','%s','%s')" % (item_id, key, value)
            
        sql = "insert into item_details values(NULL,'%s','%s','%s',1)" % (item_id, item_id, item_str.replace(item_id+";",''))
        insert_mysql_record(mysql,sql)
    return redirect("/add-item")

# List Inventory
@app.route("/listinventory")
def listinventory():
    cursor = mysql.cursor()
    cursor.execute("SELECT id,tagval FROM item_details WHERE is_active = 1")
    inventory = cursor.fetchall()
    return render_template("list_inventory.html", inventory=inventory)

# Soft delete
@app.route("/inventorydelete", methods=['POST'])
def delete_inventory():
    id = request.form["id"]
    cursor = mysql.cursor()
    sql_vals = "UPDATE item_details SET is_active = 0 WHERE id = "+id 
    print("in delete inventory:"+sql_vals)
    sub_id = insert_mysql_record(mysql,sql_vals)
    return redirect(url_for("listinventory"))

@app.route("/inventoryedit", methods=['POST'])
def edit_inventory():
    id = request.form["id"]
    tagval = request.form["name"]
    cursor = mysql.cursor()
    sql_vals = "UPDATE item_details SET tagval = '"+tagval+"' WHERE id = "+id 
    print("in delete inventory:"+sql_vals)
    sub_id = insert_mysql_record(mysql,sql_vals)
    return "Ok"

@app.route('/get_fields', methods=['Get','POST'])
def get_fields():
    category_id = request.json['category_id']
    cursor = mysql.cursor()
    qry = "SELECT tag,id FROM inventory_item WHERE name = '%s'" % (category_id)
    print(qry)
    cursor.execute(qry)
    fields = []
    rows = cursor.fetchall()
    print(rows)

    cursor.close()
    return render_template('new_inventory.html', categories=categories, rows=rows)

# @app.route("/add-item-details", methods=['GET', 'POST'])
# def add_item_details():
#     cursor = mysql.cursor()
#     if request.method == "POST":
#         print("Adding new Item Details.")
#         category = request.json['category_id']
#         tag1val = request.json['tag1val']
#         tag2val = request.json['tag2val']
#         print("test")
#         print(tag1val)
#         print(tag2val)
#         print(category)

#         sql = "INSERT INTO item_details VALUES (NULL,1,'"+tag1val+"','"+tag1val+"')"
#         print(sql)
#         #cursor.execute(sql, list(data.values()))
#         #mysql.commit()
#         #cursor.close()
#     return 'Data submitted successfully!'

@app.route("/update-inventory", methods=['GET', 'POST'])
def update_inventory():
    cursor = mysql.cursor()
    if request.method == "POST":
        print("Adding new Buyer.")
        tr_date = request.form.get('date')
        item = request.form.get('item')
        buyer = request.form.get('buyer')
        quantity = request.form.get('quantity')
        cost = request.form.get('cost')
        mrp = request.form.get('mrp')

        sql_vals = "insert into update_inventory values(NULL,'%s','%s','%s','%s',NULL,'%s','%s')" % (item, buyer, quantity, tr_date, cost, mrp)
        sub_id = insert_mysql_record(mysql,sql_vals)
        if sub_id > 0:
            #if item is not inserted earlier then insert with quantity
            cursor.execute("SELECT quantity from inv_count where item_id = "+item)
            qty = cursor.fetchall()
            if not qty:
                sqlqry = "insert into inv_count values('%s','%s')" % (item, quantity)
                last_rec = insert_mysql_record(mysql,sqlqry)
            else:
                for qty_val in qty:
                    sqlqry = "update inv_count set quantity = quantity + "+quantity+" where item_id = "+item
                    last_rec = insert_mysql_record(mysql,sqlqry)
        return redirect("/update-inventory")
    else:
        cursor.execute("SELECT id,name from buyer")
        buyers = cursor.fetchall()
        cursor.execute("SELECT id,tagval from item_details where is_active = 1 order by tagval")
        items = cursor.fetchall()
        cursor.close()
        return render_template("/update_inventory.html",buyers=buyers, items=items,cur_date=date.today().strftime('%Y-%m-%d'))


        
@app.route("/add-tag", methods=['GET', 'POST'] )
def add_tag():
    name = request.form['name']
    sql_vals = "insert into temp_tag values('%s')" % (name)
    print("Inserting study notes:")
    insert_mysql_record(mysql,sql_vals)
    return redirect('/add-item')

######################### AI Bot ######################################

# from pydantic import BaseModel
# from openai import AzureOpenAI
# from azure.search.documents import SearchClient
# from azure.core.credentials import AzureKeyCredential
# from dotenv import load_dotenv

# import os,uuid,json

# load_dotenv()
# debug_output = True


# ##############################################################################
# openai_endpoint = "https://tejas-mj8ki4qk-eastus2.cognitiveservices.azure.com/"
# search_endpoint="https://triam-ai-search.search.windows.net"
# model_name = "text-embedding-3-small"
# deployment = "text-embedding-3-small"
# search_key=os.getenv("AI_SEARCH_KEY")
# api_key=os.getenv("OPENAI_API_KEY")
# AZURE_SEARCH_INDEX="rag-index"
# AZURE_OPENAI_CHAT_DEPLOYMENT="gpt-4o-mini"

# # Azure AI Search client
# openai_client = AzureOpenAI(
#     api_version="2024-12-01-preview",
#     azure_endpoint=openai_endpoint,
#     api_key=api_key
# )

# search_client = SearchClient(
#     endpoint=search_endpoint,
#     index_name=AZURE_SEARCH_INDEX,
#     credential=AzureKeyCredential(search_key)
# )

# class QuestionRequest(BaseModel):
#     question: str

# def get_embedding(text: str):
#     try:
#         response = openai_client.embeddings.create(
#             input=text,
#             model=deployment
#         )    
#         return response.data[0].embedding
#     except Exception as e:
#         # A general handler for any other exception
#         print(f"A embed exception error occurred:")
    
# def retrieve_context(question: str, k: int = 3) -> str:
#     debug_msg("retrieving")
#     vector = get_embedding(question)
#     debug_msg(vector)
#     debug_msg("Debug2")
#     results = search_client.search(
#         search_text=question,
#         vector_queries=[{
#             "kind": "vector",
#             "vector": vector,
#             "k": k,
#             "fields": "embedding"
#         }],
#         select=["content"]
#     )

#     debug_msg("debug3")
#     retval = ""
#     for r in results:
#         debug_msg("==========")
#         debug_msg(r)
#         debug_msg("------")
#         retval = retval + r["content"]
#         debug_msg("==----------====")
#     #tmp = "\n".join([r.content for r in results])
#     debug_msg("====debug==========")
#     print(retval)
#     debug_msg("====-----==========")
#     return retval

# def generate_answer(question: str, context: str) -> str:
#     response = openai_client.chat.completions.create(
#         model=AZURE_OPENAI_CHAT_DEPLOYMENT,
#         messages=[
#             {
#                 "role": "system",
#                 "content": "Answer ONLY from the provided context. If not found, say 'Not available in knowledge base.'"
#             },
#             {
#                 "role": "user",
#                 "content": f"Context:\n{context}\n\nQuestion:\n{question}"
#             }
#         ]
#     )
#     debug_msg(response.choices)
#     return response.choices[0].message.content

# @app.route("/ask", methods=["GET", "POST"])
# def ask_question():
#     if request.method == "POST":
#         data = request.get_json()
#         question = data.get("question")
#         debug_msg("Question"+question)
#         context = retrieve_context(question)
#         answer = generate_answer(question, context)
#         return jsonify({"question": question,"answer": answer})
            

# @app.route("/triam-ai", methods=['GET', 'POST'])
# def triam_ai():
#     print("In triamai:"+request.method)

#     if request.method == 'POST':    
#         # Write the latest contents to a differnt file.
#         # To push to ai search with different ID.
#         # These contents will be appended to main file later.
#         debug_msg("in triam post")
        
#         #content1 = request.form.get("content1", "")
#         #content2 = request.form.get("content2", "")
#         content1 = request.json['content1']
#         content2 = request.json['content2']

#         now = datetime.now()
#         filesufix = now.strftime("%Y%m%d%H%M%S")
#         upload_doc_ai_search(content1,"dms-"+filesufix)
#         upload_doc_ai_search(content2,"inv-"+filesufix)

#         # append data to existing conents
#         with open(current_app.root_path+"/notes/dmsupdates.txt", "a", encoding="utf-8") as f1:
#             f1.write(content1)

#         with open(current_app.root_path+"/notes/invpoints.txt", "a", encoding="utf-8") as f2:
#             f2.write(content2)

#         return jsonify({"message": "Content updated successfully!","status":"success"})

#     debug_msg("This is not a post method..............")
#     # Initial load
#     NOTES_DIR = current_app.root_path+"/notes"
#     BUCKETS_DIR = current_app.root_path+"/buckets"

#     notes = []

#     if os.path.exists(NOTES_DIR):
#         for filename in os.listdir(NOTES_DIR):
#             file_path = os.path.join(NOTES_DIR, filename)
#             if os.path.isfile(file_path):
#                 with open(file_path, "r", encoding="utf-8") as f:
#                     notes.append({
#                         "name": os.path.splitext(filename)[0],
#                         "content": f.read()
#                     })

#     buckets = []

#     if os.path.exists(BUCKETS_DIR):
#         for filename in os.listdir(BUCKETS_DIR):
#             file_path = os.path.join(BUCKETS_DIR, filename)
#             if os.path.isfile(file_path):
#                 with open(file_path, "r", encoding="utf-8") as f:
#                     buckets.append({
#                         "name": os.path.splitext(filename)[0],
#                         "content": f.read()
#                     })
#     debug_msg(notes)
#     debug_msg(buckets)
                    
#     FILE_1 = current_app.root_path+"/notes/dmsupdates.txt"   # DMS updates
#     FILE_2 = current_app.root_path+"/notes/invpoints.txt"   # Inventory points

#     def read_file(path):
#         try:
#             with open(path, "r", encoding="utf-8") as f:
#                 return f.read()
#         except FileNotFoundError:
#             print(path+": File not found")
#             return ""


#     dmsupdates = read_file(FILE_1)
#     invpoints = read_file(FILE_2)
#     debug_msg(dmsupdates)
#     debug_msg(invpoints)
#     return render_template(
#         "/triamai.html",
#         notes = notes,
#         buckets = buckets
#     )
            
                           



# def debug_msg(msg):
#     if debug_output == True:
#         print(msg)



# @app.route("/update-ai-doc", methods=["POST"])
# def update_ai_doc():
#     if "file" not in request.files:
#         return jsonify({"error": "No file part"}), 400

#     file = request.files["file"]

#     if file.filename == "":
#         return jsonify({"error": "No file selected"}), 400

#     # Read file content
#     filename = secure_filename(file.filename)
#     file_content = file.read()   # bytes
#     content = file_content.decode("utf-8")

#     return upload_doc_ai_search(content,filename)

    

# def upload_doc_ai_search(content,doc_id):
#     try:
#         embedding2 = openai_client.embeddings.create(
#             model=deployment,
#             input=content
#         ).data[0].embedding
#         now = datetime.now()
#         filesufix = now.strftime("%Y%m%d%H%M%S")
#         doc = {
#             "id": doc_id.replace(".","_")+"_"+filesufix,
#             "content": content,
#             "embedding": embedding2
#         }
#         search_client.upload_documents(documents=[doc])
#         print("TXT file uploaded")
        
#         return jsonify({"message": "File uploaded successfully"})
#     except UnicodeDecodeError:
#         text = None
#         return jsonify({
#             "message": "File uploaded failed"
#         })





######################### AI Bot ######################################

if __name__ == '__main__':
    set_user_list()


    print(global_users_list)
    app.run(host='0.0.0.0',port=config_data['port'], debug=True)
    

#TODO Completed status update page in tasks.html. next to Enter some valid tasks. and also users in invo_task table
#TODO create a function to get the new tasks if any assigned in assign_task with status=0
#Then insert into daily_task for that user from invo_task if it is on the same day_of_week.:1
