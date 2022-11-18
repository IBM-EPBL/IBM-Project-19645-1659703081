from flask import Flask, request, session,jsonify,url_for
from datetime import datetime
import ibm_db

app = Flask(__name__)
app.secret_key = "hahahehehoho"
conn = ibm_db.connect("DATABASE=bludb;HOSTNAME=1bbf73c5-d84a-4bb0-85b9-ab1a4348f4a4.c3n41cmd0nqnrk39u98g.databases.appdomain.cloud;PORT=32286;SECURITY=SSL;SSLServerCertificate=DigiCertGlobalRootCA.crt;UID=ytn21177;PWD=uBaayra8QTfeoI7T", '', '')
userdatasql = "CREATE TABLE IF NOT EXISTS Userdata (Name varchar(50),CycleLength int,Budget float(24),CreationDate datetime,Email varchar(50) NOT NULL PRIMARY KEY,Password varchar(50))"
transactionsql = "CREATE TABLE IF NOT EXISTS Transaction (Tid int NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),Category varchar(50),Description varchar(50),Amount float(24),TransactionDate datetime,Email varchar(50),FOREIGN KEY (Email) REFERENCES Userdata(Email),PRIMARY KEY (Tid))"
stmt1 = ibm_db.prepare(conn,userdatasql)
ibm_db.execute(stmt1)
stmt2 = ibm_db.prepare(conn,transactionsql)
ibm_db.execute(stmt2)

@app.route("/")
def home():
    if 'loggedin' in session:
        userdata={'email':session['email'],'name':session['name'],'cycleLength':session['cycleLength'],'budget':session['budget'],'creationDate':session['creationDate']}
        return jsonify(userdata),200
    return "Unauthorized",401


@app.route("/register/", methods=['POST'])
def register():
    now = datetime.now()

    name = request.form['name']
    cycleLength = request.form['cycleLength']
    budget = request.form['budget']
    email = request.form['email']
    password = request.form['password']

    sql = "SELECT * FROM Userdata WHERE Email =?"
    stmt = ibm_db.prepare(conn, sql)
    ibm_db.bind_param(stmt, 1, email)
    ibm_db.execute(stmt)
    account = ibm_db.fetch_assoc(stmt)

    if account:
        return "Account using this email already exists,Please Login",400
    else:
        insert_sql = "INSERT INTO Userdata VALUES (?,?,?,?,?,?)"
        prep_stmt = ibm_db.prepare(conn, insert_sql)
        ibm_db.bind_param(prep_stmt, 1, name)
        ibm_db.bind_param(prep_stmt, 2, cycleLength)
        ibm_db.bind_param(prep_stmt, 3, budget)
        ibm_db.bind_param(prep_stmt, 4, now)
        ibm_db.bind_param(prep_stmt, 5, email)
        ibm_db.bind_param(prep_stmt, 6, password)
        ibm_db.execute(prep_stmt)

        session['loggedin'] = True
        session['email'] = email
        session['name'] = name
        session['cycleLength'] = cycleLength
        session['budget'] = budget
        session['creationDate'] = str(now)
        
        userdata={'email':email,'name':name,'cycleLength':int(cycleLength),'budget':float(budget),'creationDate':str(now),'password':password}
        return jsonify(userdata),200


@app.route("/login/", methods=['POST'])
def login():
    email = request.form['email']
    password = request.form['password']

    sql = "SELECT * FROM Userdata WHERE Email =? AND Password =?"
    stmt = ibm_db.prepare(conn, sql)
    ibm_db.bind_param(stmt, 1, email)
    ibm_db.bind_param(stmt, 2, password)
    ibm_db.execute(stmt)
    account = ibm_db.fetch_assoc(stmt)
    if account:
        session['loggedin'] = True
        session['email'] = account["EMAIL"]
        session['name']=account["NAME"]
        session['cycleLength']=account["CYCLELENGTH"]
        session['budget']=account["BUDGET"]
        session['creationDate']=str(account["CREATIONDATE"])

        userdata={'email':session['email'],'name':session['name'],'cycleLength':session['cycleLength'],'budget':session['budget'],'creationDate':session['creationDate'],'password':password}
        return jsonify(userdata),200
    else:
        return "Invalid Credentials",400

@app.route('/update/password/', methods=['POST'])
def updatePassword():
    if not 'email' in session:
        return "Unauthorized",401

    oldpassword = request.form['oldpassword']
    password = request.form['password']
    sql = "SELECT * FROM Userdata WHERE Email =?"
    stmt = ibm_db.prepare(conn, sql)
    ibm_db.bind_param(stmt, 1,session['email'])
    ibm_db.execute(stmt)
    account = ibm_db.fetch_assoc(stmt)
    if account['PASSWORD']==oldpassword:
        insert_sql = "UPDATE Userdata SET Password =? WHERE Email =?"
        prep_stmt = ibm_db.prepare(conn, insert_sql)
        ibm_db.bind_param(prep_stmt, 1,password)
        ibm_db.bind_param(prep_stmt, 2,session['email'])
        ibm_db.execute(prep_stmt)
        return "Password Updated Successfully",200
    else:
        return "Wrong Password Entered,Try Again",400

@app.route('/updateBudget/', methods=['POST'])
def updateBudget():
    insert_sql = "UPDATE Userdata SET CycleLength =?, Budget =? WHERE Email =?"
    prep_stmt = ibm_db.prepare(conn, insert_sql)
    ibm_db.bind_param(prep_stmt, 1,request.form['cycleLength'])
    ibm_db.bind_param(prep_stmt, 2,request.form['budget'])
    ibm_db.bind_param(prep_stmt, 3,request.form['email'])
    ibm_db.execute(prep_stmt)
    return "Budget Updated Successfully",200

@app.route('/delete/')
def delete():
    if 'email' in session:
        url_for('logout')
        sql = "DELETE FROM Userdata WHERE Email =?"
        stmt = ibm_db.prepare(conn, sql)
        ibm_db.bind_param(stmt, 1, session['email'])
        ibm_db.execute(stmt)
        return "User Removed Successfully",200
    return "Unauthorized",401

@app.route('/logout/')
def logout(): 
    session.pop('loggedin', None)
    session.pop('email', None)
    session.pop('name', None)
    session.pop('cycleLength', None)
    session.pop('budget', None)
    session.pop('creationDate', None)
    return "User Logged Out Successfully",200


@app.route("/transaction/add/",methods=['POST'])
def addtransaction():
    now = datetime.now()
    category = request.form['category']
    description = request.form['description']
    amount = request.form['amount']
    email = request.form['email']
    insert_sql = "INSERT INTO Transaction (CATEGORY,DESCRIPTION,AMOUNT,TRANSACTIONDATE,EMAIL) VALUES (?,?,?,?,?)"
    prep_stmt = ibm_db.prepare(conn, insert_sql)
    ibm_db.bind_param(prep_stmt, 1, category)
    ibm_db.bind_param(prep_stmt, 2, description)
    ibm_db.bind_param(prep_stmt, 3, amount)
    ibm_db.bind_param(prep_stmt, 4, now)
    ibm_db.bind_param(prep_stmt, 5, email)
    ibm_db.execute(prep_stmt)

    sql = "SELECT * FROM Transaction WHERE TransactionDate=?"
    stmt = ibm_db.prepare(conn, sql)
    ibm_db.bind_param(stmt, 1, now)
    ibm_db.execute(stmt)
    insertedTransaction = ibm_db.fetch_assoc(stmt)

    transaction={"tId":insertedTransaction["TID"],"amount":float(amount),"category":category,"description":description,"transactionDate":str(now)}
    return jsonify(transaction),200

@app.route("/transaction/<email>/listAll/")
def listtransactions(email):
    sql = "SELECT * FROM Transaction WHERE Email =?"
    stmt = ibm_db.prepare(conn, sql)
    ibm_db.bind_param(stmt, 1, email)
    ibm_db.execute(stmt)
    transaction = ibm_db.fetch_assoc(stmt)
    transactionList=[]
    while transaction != False:
        transactionList.append({"tId":transaction["TID"],"amount":transaction["AMOUNT"],"category":transaction["CATEGORY"],"description":transaction["DESCRIPTION"],"transactionDate":str(transaction["TRANSACTIONDATE"])})
        transaction = ibm_db.fetch_assoc(stmt)
    return jsonify(transactionList),200

@app.route("/transaction/delete/<tId>")
def deletetransaction(tId):
    sql = "DELETE FROM Transaction WHERE Tid =?"
    stmt = ibm_db.prepare(conn, sql)
    ibm_db.bind_param(stmt, 1, tId)
    ibm_db.execute(stmt)
    return "Deleted Successfully",200

if __name__ == "__main__":
    app.run()
