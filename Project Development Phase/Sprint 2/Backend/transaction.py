from flask import Flask, request, session,jsonify,url_for
from datetime import datetime
import ibm_db

app = Flask(__name__)
app.secret_key = "hahahehehoho"
conn = ibm_db.connect("DATABASE=bludb;HOSTNAME=1bbf73c5-d84a-4bb0-85b9-ab1a4348f4a4.c3n41cmd0nqnrk39u98g.databases.appdomain.cloud;PORT=32286;SECURITY=SSL;SSLServerCertificate=DigiCertGlobalRootCA.crt;UID=ytn21177;PWD=uBaayra8QTfeoI7T", '', '')
userdatasql = "CREATE TABLE IF NOT EXISTS Userdata (Name varchar(50),CycleLength int,Budget float(24),CreationDate datetime,Email varchar(50) NOT NULL PRIMARY KEY,Password varchar(50))"
stmt1 = ibm_db.prepare(conn,userdatasql)
ibm_db.execute(stmt1)

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