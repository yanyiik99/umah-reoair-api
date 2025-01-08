"""Routes for module Layanan"""
import os
import uuid
from flask import Blueprint, jsonify, request
from helper.db_helper import get_connection
from helper.year_operation import check_age_book, diff_year
from helper.form_validation import get_form_data
from helper.avg_rating import avg_rating
from flask_jwt_extended import jwt_required
from datetime import datetime
from mysql.connector import IntegrityError
from werkzeug.utils import secure_filename

layanan_endpoints = Blueprint('layanan', __name__)
UPLOAD_FOLDER = "img"


@layanan_endpoints.route('/read_alllayanan', methods=['GET'])
def read():
    """Routes for module get list Layanan"""
    connection = get_connection()
    cursor = connection.cursor(dictionary=True)
    select_query = """
        SELECT 
            a.id_layanan, 
            a.id_promo, 
            a.nama, 
            a.deskripsi, 
            a.kategori, 
            a.harga,
            a.peralatan, 
            a.estimasi,
            a.garansi, 
            a.operasional,
            a.img_layanan,
            GROUP_CONCAT(DISTINCT b.nama SEPARATOR ',') AS allstaff,
            GROUP_CONCAT(DISTINCT c.nama_benefit SEPARATOR ',') AS benefits
        FROM 
            layanan a
        LEFT JOIN 
            assign_staff x ON a.id_layanan = x.id_layanan
        LEFT JOIN 
            staff b ON x.id_staff = b.id_staff
        LEFT JOIN 
            benefit_layanan y ON a.id_layanan = y.id_layanan
        LEFT JOIN 
            benefit c ON y.id_benefit = c.id_benefit
        GROUP BY 
            a.id_layanan, 
            a.id_promo, 
            a.nama, 
            a.deskripsi, 
            a.kategori, 
            a.harga, 
            a.peralatan,
            a.estimasi,
            a.garansi,
            a.operasional,
            a.img_layanan"""
    cursor.execute(select_query)
    results = cursor.fetchall()
    for staff in results:
        if 'allstaff' in staff and staff['allstaff']:
            staff['allstaff'] = staff['allstaff'].split(',')
        else:
            staff['allstaff'] = []

        if 'benefits' in staff and staff['benefits']:
            staff['benefits'] = staff['benefits'].split(',')
        else:
            staff['benefits'] = []
    cursor.close()  
    return jsonify({"status": "OK", "datas": results}), 200

@layanan_endpoints.route('/create_layanan', methods=['POST'])
def create_layanan():
    """Routes for module create staff"""
    id_promo = request.form['id_promo']
    nama = request.form['nama']
    deskripsi = request.form['deskripsi']
    kategori = request.form['kategori']
    harga = request.form['harga']
    peralatan = request.form['peralatan']
    estimasi = request.form['estimasi']
    garansi = request.form['garansi']
    operasional = request.form['operasional']
    uploaded_file = request.files['img_layanan']

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
            INSERT INTO layanan 
            (id_promo, nama, deskripsi, kategori, harga, peralatan, estimasi, garansi, operasional, img_layanan, created_at, updated_at) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s )"""
        insert_request = (id_promo, nama, deskripsi, kategori, harga, peralatan, estimasi, garansi, operasional, file_path, created_at, updated_at)
        cursor.execute(insert_query, insert_request)
        connection.commit()
        cursor.close()
        new_id = cursor.lastrowid
        if new_id:
            return jsonify({"status": "OK","message": "layanan Succesfully Added"}), 201
        return jsonify({"status": "Failed", "message": "Can't Create Layanan"}), 501

    return jsonify({"message": "Can't upload data"}), 400

@layanan_endpoints.route('/read_layanan/<id_layanan>', methods=['GET'])
def get_layananbyid(id_layanan):
    """Routes for module get layanan by id"""
    connection = get_connection()
    cursor = connection.cursor(dictionary=True)
    select_query = """
        SELECT 
            a.id_layanan, 
            a.id_promo, 
            a.nama, 
            a.deskripsi, 
            a.kategori, 
            a.harga,
            a.peralatan, 
            a.estimasi,
            a.garansi, 
            a.operasional,
            a.img_layanan,
            GROUP_CONCAT(DISTINCT b.nama SEPARATOR ',') AS allstaff,
            GROUP_CONCAT(DISTINCT c.nama_benefit SEPARATOR ',') AS benefits   
        FROM 
            layanan a
        LEFT JOIN 
            assign_staff x ON a.id_layanan = x.id_layanan
        LEFT JOIN 
            staff b ON x.id_staff = b.id_staff
        LEFT JOIN 
            benefit_layanan y ON a.id_layanan = y.id_layanan
        LEFT JOIN 
            benefit c ON y.id_benefit = c.id_benefit
        WHERE a.id_layanan=%s
        GROUP BY
            a.id_layanan, 
            a.id_promo, 
            a.nama, 
            a.deskripsi, 
            a.kategori, 
            a.harga,
            a.peralatan, 
            a.estimasi,
            a.garansi, 
            a.operasional,
            a.img_layanan"""
    parameter_request = (id_layanan, )
    cursor.execute(select_query, parameter_request)
    results = cursor.fetchone()
    cursor.close()

    if 'allstaff' in results and results['allstaff']:
        results["allstaff"] = results["allstaff"].split(",")
    else: 
        results["allstaff"] = []

    if 'benefits' in results and results['benefits']:
        results["benefits"] = results["benefits"].split(",")
    else: 
        results["benefits"] = []
    
    return jsonify({"message": "OK", "datas": results}), 200


@layanan_endpoints.route('/edit_layanan/<id_layanan>', methods=['PUT'])
def edit_layanan(id_layanan):
    """Routes for module edit layanan"""
    id_promo = request.form['id_promo']
    nama = request.form['nama']
    deskripsi = request.form['deskripsi']
    kategori = request.form['kategori']
    harga = request.form['harga']
    peralatan = request.form['peralatan']
    estimasi = request.form['estimasi']
    garansi = request.form['garansi']
    operasional = request.form['operasional']
    uploaded_file = request.files['img_layanan']
    updated_at = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

    connection = get_connection()
    cursor = connection.cursor()
    
    if uploaded_file.filename != '':
        file_name = f"{uuid.uuid4().hex}_{secure_filename(uploaded_file.filename)}"
        file_path = os.path.join(UPLOAD_FOLDER, file_name)
        uploaded_file.save(file_path)
        update_query = """
            UPDATE layanan SET 
                id_promo=%s, 
                nama=%s, 
                deskripsi=%s, 
                kategori=%s, 
                harga=%s, 
                peralatan=%s, 
                estimasi=%s, 
                garansi=%s, 
                operasional=%s, 
                img_layanan=%s, 
                updated_at=%s
            WHERE id_layanan=%s"""
        update_request = (id_promo, nama, deskripsi, kategori, harga, peralatan, estimasi, garansi, operasional, file_path, updated_at, id_layanan)
        cursor.execute(update_query, update_request)
        connection.commit()
        cursor.close()
        return jsonify({"status": "OK", "message": "Succesfully updated", "layananid": id_layanan}), 200

    return jsonify({"message": "Can't upload data"}), 400

@layanan_endpoints.route('/create_benefit', methods=['POST'])
def create_benefit():
    """Routes for module create benefit"""
    nama_benefit = request.form['nama_benefit']
    datenow = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    created_at = datenow
    updated_at = datenow

    connection = get_connection()
    cursor = connection.cursor()
    insert_query = """
        INSERT INTO benefit 
        (nama_benefit, created_at, updated_at) 
        VALUES (%s, %s, %s)"""
    insert_request = (nama_benefit, created_at, updated_at)
    cursor.execute(insert_query, insert_request)
    connection.commit()
    cursor.close()
    new_id = cursor.lastrowid
    if new_id:
        return jsonify({"status": "OK","message": "Benefit Succesfully Added"}), 201
    return jsonify({"status": "Failed", "message": "Can't Create Benefit"}), 501


@layanan_endpoints.route('/assign_benefitlayanan', methods=['POST'])
def asign_benefit_layanan():
    """Routes for module assign benefit layanan"""
    id_benefit = request.form['id_benefit']
    id_layanan = request.form['id_layanan'] 

    try: 
        connection = get_connection()
        cursor = connection.cursor()
        insert_query = """
            INSERT INTO benefit_layanan
            (id_benefit, id_layanan) 
            VALUES (%s, %s)"""
        insert_request = (id_benefit, id_layanan)
        cursor.execute(insert_query, insert_request)
        connection.commit()
        cursor.close()
        new_id = cursor.lastrowid
        if new_id:
            return jsonify({"status": "OK","message": "Assign Benefit Succesfully Added"}), 201
        return jsonify({"status": "Failed", "message": "Can't Create Assign Benefit"}), 501
    except IntegrityError as e:
        return jsonify({"message": "Duplicate entry", "details": str(e)}), 409
    except Exception as e:
        return jsonify({"message": "An error occurred", "details": str(e)}), 500



# UNTIL HERE 
@layanan_endpoints.route('/create_skill', methods=['POST'])
def create_skill():
    """Routes for module Create Skill"""
    nama_skill = request.form['nama_skill']

    connection = get_connection()
    cursor = connection.cursor()
    insert_query = "INSERT INTO staff_skill (nama_skill) VALUES (%s)"
    insert_request = (nama_skill, )
    cursor.execute(insert_query, insert_request)
    connection.commit()
    cursor.close()
    new_id = cursor.lastrowid
    if new_id:
        return jsonify({"status": "OK","message": "Skill Succesfully Added"}), 201
    return jsonify({"status": "Failed", "message": "Can't Added Skill"}), 501


@layanan_endpoints.route('/assign_skill', methods=['POST'])
def assign_skill():
    """Routes for module Assign Skill"""
    id_staff = request.form['id_staff']
    id_skill = request.form['id_skill']

    connection = get_connection()
    cursor = connection.cursor()
    insert_query = "INSERT INTO assign_skill (id_staff, id_skill) VALUES (%s, %s)"
    insert_request = (id_staff, id_skill)
    cursor.execute(insert_query, insert_request)
    connection.commit()
    cursor.close()
    new_id = cursor.lastrowid
    if new_id:
        return jsonify({"status": "OK","message": "Assign skill Succesfully Added"}), 201
    return jsonify({"status": "Failed", "message": "Can't Added assign skill"}), 501


@layanan_endpoints.route('/read_rating/<id_layanan>', methods=['GET'])
def get_rating_bylayanan(id_layanan):
    """Routes for module get rating layanan by id layanan"""
    connection = get_connection()
    cursor = connection.cursor(dictionary=True)
    select_query = """SELECT * FROM review_layanan where id_layanan=%s"""
    parameter_request = (id_layanan, )
    cursor.execute(select_query, parameter_request)
    results = cursor.fetchall()
    cursor.close()

    ratings = [item["rating"] for item in results]
    result_rating = avg_rating(ratings)
    return jsonify({"message": "OK", "datas": results, "avg": result_rating}), 200
