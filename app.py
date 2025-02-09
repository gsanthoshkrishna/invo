from flask import Flask, render_template, request, redirect, url_for, session
import mysql.connector
from datetime import date
from flask_session import Session
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

@app.route('/login', methods=['GET', 'POST'])
def user_login():
    if request.method == "POST":
        print(request.form.get('name'))
        session['name'] = request.form.get('name')
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
    cur.execute("SELECT * FROM invo_user where user_id = '"+user_id+"'")
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
    cur.close()
    return ret_val
@app.route('/')
def index():
    if not session.get('name'):
        print("No Session name")
        return redirect('/login')
    name = session.get('name')
    return render_template('invo.html',name = name)


@app.route('/daily_changes')
def daily_chages():
    return render_template('daily_changes.html',current_date=date.today().strftime('%Y-%m-%d'))

@app.route('/invo_tasks')
def invo_tasks():
    cur = mysql.cursor()
    cur.execute("SELECT * FROM daily_task where task_date = CURDATE()")
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

@app.route('/buckets')
def show_buckets():
    cursor = mysql.cursor()
    cursor.execute("SELECT name, description, duration FROM bucket")
    buckets = cursor.fetchall()
    cursor.close()
    return render_template('buckets.html', buckets=buckets)
@app.route('/buy-sell')
def buy_sell():
    return render_template("buy-sell.html")
@app.route('/items')
def show_items1():
    cursor = mysql.cursor()
    cursor.execute("SELECT name, description, bucket_id FROM items")
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

        return render_template('invo.html')

    cursor = mysql.cursor()
    cursor.close()
    return redirect("/buy-sell")

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

        for indicator, ind_change, remark in zip(entries, remarks,ind_change):
            if indicator and remark:  # Ensure both fields are filled
                sql_vals = "INSERT INTO daily_indicators (date, indicator_id,ind_change, remarks, user_id) VALUES ('%s', '%s','%s', '%s',1)" % (entry_date,indicator, ind_change,remark)
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

if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5000, debug=True)


#TODO Completed status update page in tasks.html. next to Enter some valid tasks. and also users in invo_task table
#TODO create a function to get the new tasks if any assigned in assign_task with status=0
#Then insert into daily_task for that user from invo_task if it is on the same day_of_week.
