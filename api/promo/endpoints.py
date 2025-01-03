"""Routes for module promo"""
import os
import uuid
from flask import Blueprint, jsonify, request
from helper.db_helper import get_connection
from helper.year_operation import check_age_book, diff_year
from helper.form_validation import get_form_data
from datetime import datetime
from flask_jwt_extended import jwt_required
from werkzeug.utils import secure_filename

promo_endpoints = Blueprint('promo', __name__)
UPLOAD_FOLDER = "img"


@promo_endpoints.route('/read_allpromo', methods=['GET'])
def read():
    """Routes for module get list promo"""
    connection = get_connection()
    cursor = connection.cursor(dictionary=True)
    select_query = "SELECT * FROM promo"
    cursor.execute(select_query)
    results = cursor.fetchall()
    cursor.close()  # Close the cursor after query execution
    return jsonify({"message": "OK", "datas": results}), 200


@promo_endpoints.route('/read_promo/<id_promo>', methods=['GET'])
def get_promobyid(id_promo):
    """Routes for module get promo by id"""
    connection = get_connection()
    cursor = connection.cursor(dictionary=True)
    select_query = """
        SELECT 
            id_promo, 
            DATE_FORMAT(end_promo, '%Y-%m-%d %H:%i:%S') as end_promo, 
            kode_promo,
            fix, 
            persen, 
            img_promo
        FROM promo where id_promo=%s"""
    parameter_request = (id_promo, )
    cursor.execute(select_query, parameter_request)
    results = cursor.fetchone()
    cursor.close()
    return jsonify({"message": "OK", "datas": results}), 200


@promo_endpoints.route('/create_promo', methods=['POST'])
def create_promo():
    """Routes for module create promo"""
    nama_promo = request.form['nama_promo']
    end_promo = request.form['end_promo']
    kode_promo = request.form['kode_promo']
    persen = request.form['persen']
    fix = request.form['fix']
    uploaded_file = request.files['img_promo']

    datenow = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    created_at = datenow
    updated_at = datenow

    connection = get_connection()
    cursor = connection.cursor()

    if uploaded_file.filename != '':
        file_name = f"{uuid.uuid4().hex}_{secure_filename(uploaded_file.filename)}"
        file_path = os.path.join(UPLOAD_FOLDER, file_name)
        uploaded_file.save(file_path)
        insert_query = """
            INSERT INTO promo 
            (nama_promo, end_promo, kode_promo, persen, fix, img_promo, created_at, updated_at) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"""
        insert_request = (nama_promo, end_promo, kode_promo, persen, fix, file_name, created_at, updated_at)
        cursor.execute(insert_query, insert_request)
        connection.commit()
        cursor.close()
        new_id = cursor.lastrowid
        if new_id:
            return jsonify({"status": "OK","message": "Promo Succesfully Created"}), 201
        return jsonify({"status": "Failed", "message": "Can't Create promo"}), 501

    return jsonify({"message": "Can't upload data"}), 400
