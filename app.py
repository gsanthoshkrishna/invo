from flask import Flask, render_template, request, redirect, url_for, session, jsonify
import mysql.connector, time
from datetime import date
from flask_session import Session
from decimal import Decimal

app = Flask(__name__)
app.config['SESSION_TYPE'] = 'filesystem'
Session(app)

# MySQL database configuration
mysql = mysql.connector.connect(
  host="localhost",
  user="root",
  password="Pass@123",
  database="invo",
  consume_results=True
)

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
            values( '{task[1]}', '{task[2]}', '{task[0]}','{task[3]}','{task[4]}','Open',CURDATE(),DATE_ADD(CURDATE(),INTERVAL 7 DAY) , '{user_details[1]}' )            
            """
            print("insert:")
            print(insrt_qry)
            cur.execute(
            insrt_qry
            )
            mysql.commit()
            #after successful insertion mark as in progress in invo_tasks;
            qry = f"update invo_task set status = 'Progress' where id = {task[0]}"
            print(qry)
            cur.execute(qry)
            mysql.commit()

    
    #update the tasks of next_task_date is today.
    qry = """ insert into daily_task SELECT NULL,name, description,task_id,remarks,bucket_id,bucket_name,'Open',CURDATE(),DATE_ADD(CURDATE(),INTERVAL 7 DAY),owner
    FROM daily_task 
    where status = 'Open' and next_task_date = CURDATE()
    """
    print(qry)
    cur.execute(qry)
    #Update the pushed task to null to avoid repeated creation.
    qry = """
    update daily_task set next_task_date = NULL 
    where status = 'Open' and next_task_date = CURDATE()
    """
    mysql.commit()
    cur.close()
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

    cur.close()

    return ret_val
@app.route('/')
def index():
    if not session.get('user_name'):
        print("No Session name")
        return redirect('/login')
    name = session.get('user_name')
    return render_template('invo.html',name = name)


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
                cursor.execute("select tr_open, tr_open, tr_low, tr_close from tr_daily_changes where tr_date='"+entry_date+"' and user_name='"+session.get('user_id')+"'")
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
            cursor.execute("select tr_open, tr_open, tr_low, tr_close from tr_daily_changes where tr_date='"+entry_date+"' and user_name='"+session.get('user_id')+"'")
            day_changes = cursor.fetchall()
            cursor.close()
            print('rendering template for today')
            return render_template('tr_daily_changes.html', indicators=day_changes, current_date=entry_date)
    else:
        print("getting data for today")
        entry_date = date.today().strftime('%Y-%m-%d')
        cursor = mysql.cursor()
        cursor.execute("select tr_open, tr_open, tr_low, tr_close from tr_daily_changes where tr_date='"+entry_date+"' and user_name='"+session.get('user_id')+"'")
        day_changes = cursor.fetchall()
        cursor.close()
        print('rendering template')
        return render_template('tr_daily_changes.html', indicators=day_changes, current_date=entry_date)

@app.route('/create-task', methods=['GET', 'POST'])
def create_task():
    cursor = mysql.cursor()
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
        print(sql_vals)
        cursor.execute(sql_vals)
        t_id = cursor.lastrowid
        print("inserted task id"+str(t_id))
        user_details = get_user_details(t_user)
        print("user details")
        print(user_details)
        sql_vals = "INSERT INTO assign_task(user_id, task_id, status) VALUES ('%s','%s',1)" % (user_details[1], t_id)
        print(sql_vals)
        cursor.execute(sql_vals)
        mysql.commit()
        cursor.close()
        return redirect('/create-task')
        cursor = mysql.cursor()
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
        print(sql_vals)
        cursor.execute(sql_vals)

        mysql.commit()
        cursor.close()
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
    qry = "SELECT tr_date, tr_open, tr_close, tr_low, tr_high,user_id FROM tr_daily_changes where user_id = '"+session.get('user_id')+"' and tr_daily_changes = '"+ch_date+"'"
    cursor.execute()
    details = cursor.fetchall()
    cursor.close()
    return render_template('daily_changes.html', details=details)

@app.route('/buckets')
def show_buckets():
    cursor = mysql.cursor()
    cursor.execute("SELECT name, description, duration FROM bucket")
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
            name = action.replace('buy_', '')
            # Handle add action for row with sid
            act = "buy"
        elif action.startswith('sell_'):
            name = action.replace('sell_', '')
            # Handle delete action for row with sid
            print("Sell button clicked for sid:"+sid)
            act = "sell"
        #This is a post call from items page for buy or sell button
        print("rendering buy sell")
        bucket = request.form.get("bid_"+name)
        return render_template("/buy-sell.html", name = name, bucket = bucket, btn_action = act)

@app.route('/get-bucket-summary')
def get_bucket_summary():
    #TODO calculate get the bucket status and render.
    return render_template("bucket_details.html")       

@app.route('/buy-sell-insert', methods=['GET', 'POST'])
def buy_sell_insert():
    #This is a post call from buy-sell page
    name = request.form.get('script')
    bucket = request.form.get('bucket')
    exchange = request.form.get('exchange')
    cnt = request.form.get('sc_cnt')
    price = request.form.get('sc_price')
    sql_vals = "INSERT INTO tr_share VALUES (NULL,'%s', '','%s','%s',curdate(), '%s',1,'%s')" % (name,cnt, price,exchange,bucket)
    print('sql qry tr_sh')
    print(sql_vals)
    cursor = mysql.cursor()
    cursor.execute(sql_vals)
    mysql.commit()
    update_bucket_details(bucket,name,int(cnt),Decimal(price),exchange)
    return redirect("/items")

@app.route('/items')
def show_items1():
    cursor = mysql.cursor()
    cursor.execute("SELECT name, description, bucket, count FROM items")
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
                cursor.execute("select indicator, ind_change , remarks from daily_indicators where date='"+entry_date+"' and user_name='"+session.get('user_id')+"'")
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
            cursor.execute("select indicator, ind_change , remarks from daily_indicators where date='"+entry_date+"' and user_name='"+session.get('user_id')+"'")
            day_indicators = cursor.fetchall()
            cursor.close()
            print('rendering template for today')
            return render_template('get_daily_updates.html', indicators=day_indicators, current_date=entry_date)
    else:
        print("getting data for today")
        entry_date = date.today().strftime('%Y-%m-%d')
        cursor = mysql.cursor()
        cursor.execute("select indicator, ind_change , remarks from daily_indicators where date='"+entry_date+"' and user_name='"+session.get('user_id')+"'")
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
    cursor = mysql.cursor()
    #Get the task which is for this day of the week.
    #cursor.execute("SELECT id FROM invo_task where day_of_week like  CONCAT('%',DAYOFWEEK(CURDATE()),'%')")
    #todays_tasks = cursor.fetchall()

    #cursor.execute("select task_id from daily_task where task_date = CURDATE()")
    #existing_tasks = cursor.fetchall()

    #cursor.execute()
    #TODO
    #Insert in daily_task for the newly created invo_task 
    #by checking if the task id in not present in daily_task.
    cursor.execute(
        "insert into daily_task select null,name,'',id,'',bucket_id,bucket_name,'Open',CURDATE(),DATE_ADD(CURDATE(),INTERVAL 7 DAY) from invo_task where id not in (select distinct task_id from daily_task)"
    )
    mysql.commit
    
    #Insert the task from daily_task where next_task_date is today and insert the same record
    #with task_date as today and next_task_date is date + 7Days. And avoid duplicate insertions by checking
    #if for the same task there is another record with next 7 days.
    
    cursor.execute(
        "insert into daily_task select null,name,'',task_id,'',bucket_id,bucket_name,'Open',CURDATE(),DATE_ADD(CURDATE(),INTERVAL 7 DAY) from daily_task where next_task_date = CURDATE() and task_id not in (select distinct task_id from daily_task where next_task_date= DATE_ADD(CURDATE(),INTERVAL 7 DAY) )"       
    )
    mysql.commit

    cursor.close()

@app.route("/ac", methods=['GET', 'POST'] )
def account_transactions():
    cursor = mysql.cursor()
    sqlqry = "select account, debt, credit, date, remarks FROM tr_account"
    cursor.execute(sqlqry)
    data = cursor.fetchall()
    sqlqry = "select name FROM account"
    cursor.execute(sqlqry)
    account = cursor.fetchall()
    cursor.close()
    return render_template("/tr_account.html", data = data,accounts=account,current_date=date.today().strftime('%Y-%m-%d'))

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
    cursor = mysql.cursor()
    name = request.form['name']
    file_path = "study-notes/"+name+".txt"
    sql_vals = "insert into study_note values(NULL,'%s',1,'%s')" % (name, session['user_uid'])
    print("Inserting study notes:")
    print(sql_vals)
    cursor.execute(sql_vals)
    mysql.commit()    
    n_id = cursor.lastrowid    
    #Immediately create an empty note and its file.
    sql_vals = "insert into study_note_file values('%s','%s')" % (n_id, file_path)
    print("Inserting study notes:")
    print(sql_vals)
    cursor.execute(sql_vals)
    mysql.commit()
    with open(file_path, 'a') as file:
    # Write content to the file
        file.write("################### Notes for "+name+" ##################")
    cursor.close()
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
        cursor.execute(sql_vals)
        mysql.commit()
        cursor.close()
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
@app.route("/add-tr-acc", methods=['GET', 'POST'])
def add_tr_account():
    print("Added new transaction.")
    acc = request.form.get('account')
    dr = request.form.get('dr')
    cr = request.form.get('cr')
    dt = request.form.get('date')
    remark = request.form.get('remarks')
    cursor = mysql.cursor()
    sql_vals = "insert into tr_account values(NULL,'%s','%s','%s','%s','%s')" % (acc, dr, cr, dt, remark)
    cursor.execute(sql_vals)
    mysql.commit()
    cursor.close()
    return redirect("/ac")

######################### Inventory ######################################
@app.route("/home")
def inventory_home():
    return render_template("inventory_home.html")

@app.route("/add-buyer", methods=['GET', 'POST'])
def add_buyer():
    if request.method == "POST":
        print("Adding new Buyer.")
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        city = request.form.get('city')
        cursor = mysql.cursor()
        sql_vals = "insert into buyer values(NULL,'%s','%s','%s','%s')" % (name, email, phone, city)
        cursor.execute(sql_vals)
        mysql.commit()
        cursor.close()
    return render_template("add_buyer.html")


@app.route("/add-item", methods=['GET', 'POST'])
def add_item():
    if request.method == "POST":
        print("Adding new Item.")
        name = request.form.get('name')
        model = request.form.get('model')
        cursor = mysql.cursor()
        sql_vals = "insert into item values(NULL,'%s','%s')" % (name, model)
        cursor.execute(sql_vals)
        mysql.commit()
        cursor.close()
    return render_template("add_item.html")

@app.route("/update-inventory", methods=['GET', 'POST'])
def update_inventory():
    cursor = mysql.cursor()
    if request.method == "POST":
        print("Adding new Buyer.")
        tr_date = request.form.get('date')
        item = request.form.get('item')
        buyer = request.form.get('buyer')
        quantity = request.form.get('quantity')
        model = request.form.get('model')
        
        sql_vals = "insert into update_inventory values(NULL,'%s','%s','%s','%s')" % (item, buyer, quantity, tr_date)
        cursor.execute(sql_vals)
        mysql.commit()
        cursor.close()
        return redirect("/update-inventory")
    else:
        cursor.execute("SELECT id,name from buyer")
        buyers = cursor.fetchall()        
        cursor.execute("SELECT id,name from item")
        items = cursor.fetchall()
        cursor.close()
        return render_template("/update_inventory.html",buyers=buyers, items=items,date=date.today().strftime('%Y-%m-%d'))


if __name__ == '__main__':
    set_user_list()
    print(global_users_list)
    app.run(host='0.0.0.0',port=5000, debug=True)
    


#TODO Completed status update page in tasks.html. next to Enter some valid tasks. and also users in invo_task table
#TODO create a function to get the new tasks if any assigned in assign_task with status=0
#Then insert into daily_task for that user from invo_task if it is on the same day_of_week.:1

