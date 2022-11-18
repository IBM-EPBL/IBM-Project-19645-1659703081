from flask import Flask, request, session,jsonify,url_for
from datetime import datetime
import ibm_db

app = Flask(__name__)
app.secret_key = "hahahehehoho"
conn = ibm_db.connect("DATABASE=bludb;HOSTNAME=1bbf73c5-d84a-4bb0-85b9-ab1a4348f4a4.c3n41cmd0nqnrk39u98g.databases.appdomain.cloud;PORT=32286;SECURITY=SSL;SSLServerCertificate=DigiCertGlobalRootCA.crt;UID=ytn21177;PWD=uBaayra8QTfeoI7T", '', '')
userdatasql = "CREATE TABLE IF NOT EXISTS Userdata (Name varchar(50),CycleLength int,Budget float(24),CreationDate datetime,Email varchar(50) NOT NULL PRIMARY KEY,Password varchar(50))"
stmt1 = ibm_db.prepare(conn,userdatasql)
ibm_db.execute(stmt1)

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

@app.route('/logout/')
def logout(): 
    session.pop('loggedin', None)
    session.pop('email', None)
    session.pop('name', None)
    session.pop('cycleLength', None)
    session.pop('budget', None)
    session.pop('creationDate', None)
    return "User Logged Out Successfully",200