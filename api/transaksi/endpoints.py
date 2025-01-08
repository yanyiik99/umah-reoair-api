"""Routes for module Transaksi"""
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

transaksi_endpoints = Blueprint('transaksi', __name__)
UPLOAD_FOLDER = "img"


@transaksi_endpoints.route('/create_transaksi', methods=['POST'])
def create_transaksi():
    """Routes for module create staff"""
    id_member = request.form['id_member']
    id_layanan = request.form['id_layanan']
    no_pesanan = request.form['no_pesanan']
    harga = request.form['harga']
    ppn = request.form['ppn']
    diskon = request.form['diskon']
    # uploaded_file = request.files['bukti_tf']
    uploaded_file = request.form['bukti_tf']
    datenow = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    created_at = datenow
    updated_at = datenow

    """Detail Penerima Request Data """
    nama_penerima = request.form['nama_penerima']
    no_tlpn = request.form['no_tlpn']
    alamat = request.form['alamat']
    jadwal = datenow
    # jadwal = request.form['jadwal']
    catatan = request.form['catatan']


    connection = get_connection()
    cursor = connection.cursor()

    # if uploaded_file.filename != '':
    #     file_name = f"{uuid.uuid4().hex}_{secure_filename(uploaded_file.filename)}"
    #     file_path = os.path.join(UPLOAD_FOLDER, file_name)
    #     uploaded_file.save(file_path)

    """Transaksi Insert Query"""
    insert_transaksi = """
        INSERT INTO transaksi 
        (id_member, id_layanan, no_pesanan, harga, ppn, diskon, bukti_tf, created_at, updated_at)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"""
    insert_request = (id_member, id_layanan, no_pesanan, harga, ppn, diskon, uploaded_file, created_at, updated_at)
    cursor.execute(insert_transaksi, insert_request)

    new_id = cursor.lastrowid

    """Transaksi Detail Penerima Insert Query"""
    insert_detail_query = """
        INSERT INTO detail_penerima 
        (id_transaksi, nama_penerima, no_tlpn, alamat, jadwal, catatan) 
        VALUES (%s, %s, %s, %s, %s, %s)"""
    detail_values = (new_id, nama_penerima, no_tlpn, alamat, jadwal, catatan)
    cursor.execute(insert_detail_query, detail_values)

    """Close Connection"""
    connection.commit()
    cursor.close()

    if new_id:
        return jsonify({"status": "OK","message": "Transaksi Succesfully", "tix": no_pesanan}), 201
    return jsonify({"status": "Failed", "message": "Can't Create Transaksi"}), 501

    # return jsonify({"message": "Can't upload data"}), 400
