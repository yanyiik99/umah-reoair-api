"""Routes for module Staff"""
import os
from flask import Blueprint, jsonify, request
from helper.db_helper import get_connection
from helper.year_operation import check_age_book, diff_year
from helper.form_validation import get_form_data
from flask_jwt_extended import jwt_required
from datetime import datetime
from mysql.connector import IntegrityError

staff_endpoints = Blueprint('staff', __name__)
UPLOAD_FOLDER = "img"


@staff_endpoints.route('/read_allstaff', methods=['GET'])
def read():
    """Routes for module get list staff"""
    connection = get_connection()
    cursor = connection.cursor(dictionary=True)
    select_query = """
        SELECT 
            a.id_staff, 
            a.nama, 
            a.alamat, 
            a.no_tlpn, 
            a.jabatan, 
            GROUP_CONCAT(b.nama_skill SEPARATOR ',') AS skills
        FROM 
            staff a
        LEFT JOIN 
            assign_skill x ON a.id_staff = x.id_staff
        LEFT JOIN 
            staff_skill b ON x.id_skill = b.id_skill
        GROUP BY 
            a.id_staff, a.nama, a.alamat, a.no_tlpn, a.jabatan"""
    cursor.execute(select_query)
    results = cursor.fetchall()
    cursor.close()  # Close the cursor after query execution
    for staff in results:
        if 'skills' in staff and staff['skills']:
            staff['skills'] = staff['skills'].split(',')
        else: 
            staff['skills'] = []
    return jsonify({"status": "OK", "datas": results}), 200

@staff_endpoints.route('/create_staff', methods=['POST'])
def create_staff():
    """Routes for module create staff"""
    nama = request.form['nama']
    alamat = request.form['alamat']
    no_tlpn = request.form['no_tlpn']
    jabatan = request.form['jabatan']

    datenow = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    created_at = datenow
    updated_at = datenow

    connection = get_connection()
    cursor = connection.cursor()
    insert_query = """INSERT INTO staff 
        (nama, alamat, no_tlpn, jabatan, created_at, updated_at) 
        VALUES (%s, %s, %s, %s, %s, %s)"""
    insert_request = (nama, alamat, no_tlpn, jabatan, created_at, updated_at)
    cursor.execute(insert_query, insert_request)
    connection.commit()
    cursor.close()
    new_id = cursor.lastrowid
    if new_id:
        return jsonify({"status": "OK","message": "Staff Succesfully Added"}), 201
    return jsonify({"status": "Failed", "message": "Can't Added Staff"}), 501


@staff_endpoints.route('/read_staff/<id_staff>', methods=['GET'])
def get_staffbyid(id_staff):
    """Routes for module get staff by id"""
    connection = get_connection()
    cursor = connection.cursor(dictionary=True)
    select_query = """
        SELECT 
            a.id_staff, 
            a.nama, 
            a.alamat,
            a.no_tlpn,
            a.jabatan,
            GROUP_CONCAT(b.nama_skill SEPARATOR ',') as skills
        FROM
            assign_skill x
        INNER JOIN
            staff a ON x.id_staff=a.id_staff
        INNER JOIN
            staff_skill b ON x.id_skill=b.id_skill
        WHERE a.id_staff=%s"""
    parameter_request = (id_staff, )
    cursor.execute(select_query, parameter_request)
    results = cursor.fetchone()
    if 'skills' in results and results['skills']:
        results["skills"] = results["skills"].split(",")
    else: 
        results["skills"] = []
    cursor.close()
    return jsonify({"message": "OK", "datas": results}), 200


@staff_endpoints.route('/edit_staff/<id_staff>', methods=['PUT'])
def edit_staff(id_staff):
    """Routes for module edit staff"""
    nama = request.form['nama']
    alamat = request.form['alamat']
    no_tlpn = request.form['no_tlpn']
    jabatan = request.form['jabatan']
    updated_at = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

    connection = get_connection()
    cursor = connection.cursor()
    update_query = """UPDATE staff SET 
        nama=%s, alamat=%s, no_tlpn=%s, jabatan=%s, updated_at=%s
        WHERE id_staff=%s"""
    update_request = (nama, alamat, no_tlpn, jabatan, updated_at, id_staff)
    cursor.execute(update_query, update_request)
    connection.commit()
    cursor.close()
    return jsonify({"status": "OK", "message": "Succesfully updated", "staffid": id_staff}), 200

@staff_endpoints.route('/create_skill', methods=['POST'])
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


@staff_endpoints.route('/assign_skill', methods=['POST'])
def assign_skill():
    """Routes for module Assign Skill"""
    id_staff = request.form['id_staff']
    id_skill = request.form['id_skill']

    try:
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
    except IntegrityError as e:
        return jsonify({"message": "Duplicate entry", "details": str(e)}), 409
    except Exception as e:
        return jsonify({"message": "An error occurred", "details": str(e)}), 500

@staff_endpoints.route('/assign_staff', methods=['POST'])
def assign_staff():
    """Routes for module Assign Staff"""
    id_staff = request.form['id_staff']
    id_layanan = request.form['id_layanan']

    try:
        connection = get_connection()
        cursor = connection.cursor()
        insert_query = "INSERT INTO assign_staff (id_layanan,id_staff) VALUES (%s, %s)"
        insert_request = (id_layanan, id_staff)
        cursor.execute(insert_query, insert_request)
        connection.commit()
        cursor.close()
        new_id = cursor.lastrowid
        if new_id:
            return jsonify({"status": "OK","message": "Assign staff Succesfully Added"}), 201
        return jsonify({"status": "Failed", "message": "Can't Added assign staff"}), 501
    except IntegrityError as e:
        return jsonify({"message": "Duplicate entry", "details": str(e)}), 409
    except Exception as e:
        return jsonify({"message": "An error occurred", "details": str(e)}), 500