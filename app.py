from flask import Flask,render_template,request
import pickle
import numpy as np
import mysql.connector

db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'test',
    'database': 'house_price',
    'port': 3306
}

app = Flask('__name__')
model=pickle.load(open('model.pkl','rb'))

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/predict',methods=["POST"])
def predict():
    feature=[int(x) for x in request.form.values()]
    feature_final=np.array(feature).reshape(-1,1)
    prediction=model.predict(feature_final)
    connection = mysql.connector.connect(**db_config)
    cursor = connection.cursor()
    try:
        cursor.execute("CREATE DATABASE IF NOT EXISTS house_price")
        connection.database = "house_price"

        cursor.execute("CREATE TABLE IF NOT EXISTS predictions ("
                    "id INT AUTO_INCREMENT PRIMARY KEY, "
                    "area FLOAT, "
                    "predicted_price FLOAT)")

        insert_query = "INSERT INTO predictions (area, predicted_price) VALUES (%s, %s)"
        values = [
            (float(feature_final[0][0]), float(prediction[0][0])),
        ]
        cursor.executemany(insert_query, values)
        connection.commit()
    finally:
        cursor.close()
        connection.close()
    return render_template('index.html',prediction_text='Price of House will be Rs. {}'.format(int(prediction)))

if(__name__=='__main__'):
    app.run(debug=True)