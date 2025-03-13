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

@app.route('/add-item')
def add_item():
    cursor = mysql.cursor()
    cursor.execute("SELECT distinct name FROM inventory_item")
    categories = cursor.fetchall()
    cursor.close()
    return render_template('new_inventory.html', categories=categories)

@app.route('/get_fields', methods=['POST'])
def get_fields():
    category_id = request.json['category_id']
    cursor = mysql.cursor()
    cursor.execute("SELECT tag FROM inventory_item WHERE name = %s", (category_id,))
    fields = []
    for row in cursor.fetchall():
        fields = (row[0]).split(",")
    cursor.close()
    return jsonify(fields)

@app.route("/add-item-details", methods=['GET', 'POST'])
def add_item_details():
    cursor = mysql.cursor()
    if request.method == "POST":
        print("Adding new Item Details.")
        data = request.form.to_dict()
        print(data)
        columns = ', '.join(data.keys())
        placeholders = ', '.join(['%s'] * len(data))
        sql = f"INSERT INTO item_details ({columns}) VALUES ({placeholders})"
        print(sql)
        #cursor.execute(sql, list(data.values()))
        #mysql.commit()
        #cursor.close()
    return 'Data submitted successfully!'

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

@app.route("/add-tag", methods=['GET', 'POST'] )
def add_tag():
    cursor = mysql.cursor()
    name = request.form['name']
    sql_vals = "insert into temp_tag values('%s')" % (name)
    print("Inserting study notes:")
    print(sql_vals)
    cursor.execute(sql_vals)
    mysql.commit()
    cursor.close()
    return redirect('/add-item')

