"""Routes for module member"""
import os
import uuid
from flask import Blueprint, jsonify, request
from helper.db_helper import get_connection
from helper.year_operation import check_age_book, diff_year
from helper.form_validation import get_form_data
from flask_jwt_extended import jwt_required
from werkzeug.utils import secure_filename

member_endpoints = Blueprint('member', __name__)
UPLOAD_FOLDER = "img"


@member_endpoints.route('/read_allmember', methods=['GET'])
@jwt_required()
def read():
    """Routes for module get list member"""
    connection = get_connection()
    cursor = connection.cursor(dictionary=True)
    select_query = "SELECT * FROM member WHERE is_deleted='no'"
    cursor.execute(select_query)
    results = cursor.fetchall()
    cursor.close()  # Close the cursor after query execution
    return jsonify({"message": "OK", "datas": results}), 200


@member_endpoints.route('/read_member/<id_member>', methods=['GET'])
@jwt_required()
def get_memberbyid(id_member):
    """Routes for module get member by id"""
    connection = get_connection()
    cursor = connection.cursor(dictionary=True)
    select_query = "SELECT * FROM member where id_member=%s AND is_deleted='no'"
    parameter_request = (id_member, )
    cursor.execute(select_query, parameter_request)
    results = cursor.fetchone()
    cursor.close()
    return jsonify({"message": "OK", "datas": results}), 200


@member_endpoints.route('/edit_member/<id_member>', methods=['PUT'])
@jwt_required()
def edit_member(id_member):
    """Routes for module edit member"""
    nama = request.form['nama']
    alamat = request.form['alamat']
    desa = request.form['desa']
    kecamatan = request.form['kecamatan']
    kabupaten = request.form['kabupaten']
    no_tlpn = request.form['no_tlpn']
    uploaded_file = request.files['img_profile']

    connection = get_connection()
    cursor = connection.cursor()

    if uploaded_file.filename != '':
        file_name = f"{uuid.uuid4().hex}_{secure_filename(uploaded_file.filename)}"
        file_path = os.path.join(UPLOAD_FOLDER, file_name)
        uploaded_file.save(file_path)
        update_query = """UPDATE member SET 
            nama=%s, alamat=%s, desa=%s, kecamatan=%s, kabupaten=%s, no_tlpn=%s, filename=%s, filepath=%s
            WHERE id_member=%s"""
        update_request = (nama, alamat, desa, kecamatan, kabupaten, no_tlpn, file_name, file_path, id_member)
        cursor.execute(update_query, update_request)
        connection.commit()
        cursor.close()
        return jsonify({"message": "Succesfully updated", "memberid": id_member}), 200
        # return jsonify({"message": "ok", "data": "uploaded", "file_path": file_path}), 200
    return jsonify({"message": "Can't upload data"}), 400


@member_endpoints.route("/upload", methods=["POST"])
def upload():
    """Routes for upload file"""
    uploaded_file = request.files['file']
    if uploaded_file.filename != '':
        file_name = f"{uuid.uuid4().hex}_{secure_filename(uploaded_file.filename)}"
        file_path = os.path.join(UPLOAD_FOLDER, file_name)
        uploaded_file.save(file_path)
        return jsonify({"message": "ok", "data": "uploaded", "filename": file_name, "file_path": file_path,}), 200
    return jsonify({"err_message": "Can't upload data"}), 400



@member_endpoints.route('/delete_member/<id_member>', methods=['PUT'])
@jwt_required()
def delete_member(id_member):
    """Routes for module soft delete member"""
    connection = get_connection()
    cursor = connection.cursor()
    delete_query = """UPDATE member SET is_deleted='yes' WHERE id_member=%s"""
    delete_request = (id_member, )
    cursor.execute(delete_query, delete_request)
    connection.commit()
    cursor.close()
    return jsonify({"message": "Succesfully deleted", "memberid": id_member}), 200




# @member_endpoints.route('/create', methods=['POST'])
# @jwt_required()
# def create():
#     """Routes for module create a book"""
#     required = get_form_data(["title"])  # use only if the field required
#     title = required["title"]
#     description = request.form['description']

#     connection = get_connection()
#     cursor = connection.cursor()
#     insert_query = "INSERT INTO tb_member (title, description) VALUES (%s, %s)"
#     request_insert = (title, description)
#     cursor.execute(insert_query, request_insert)
#     connection.commit()  # Commit changes to the database
#     cursor.close()
#     new_id = cursor.lastrowid  # Get the newly inserted book's ID\
#     if new_id:
#         return jsonify({"title": title, "message": "Inserted", "id_member": new_id}), 201
#     return jsonify({"message": "Cant Insert Data"}), 500


# @member_endpoints.route('/update/<product_id>', methods=['PUT'])
# @jwt_required()
# def update(product_id):
#     """Routes for module update a book"""
#     title = request.form['title']
#     description = request.form['description']

#     connection = get_connection()
#     cursor = connection.cursor()

#     update_query = "UPDATE tb_member SET title=%s, description=%s WHERE id_member=%s"
#     update_request = (title, description, product_id)
#     cursor.execute(update_query, update_request)
#     connection.commit()
#     cursor.close()
#     data = {"message": "updated", "id_member": product_id}
#     return jsonify(data), 200


# @member_endpoints.route('/delete/<product_id>', methods=['GET'])
# @jwt_required()
# def delete(product_id):
#     """Routes for module to delete a book"""
#     connection = get_connection()
#     cursor = connection.cursor()

#     delete_query = "DELETE FROM tb_member WHERE id_member = %s"
#     delete_id = (product_id,)
#     cursor.execute(delete_query, delete_id)
#     connection.commit()
#     cursor.close()
#     data = {"message": "Data deleted", "id_member": product_id}
#     return jsonify(data)


# @member_endpoints.route("/upload", methods=["POST"])
# @jwt_required()
# def upload():
#     """Routes for upload file"""
#     uploaded_file = request.files['file']
#     if uploaded_file.filename != '':
#         file_path = os.path.join(UPLOAD_FOLDER, uploaded_file.filename)
#         uploaded_file.save(file_path)
#         return jsonify({"message": "ok", "data": "uploaded", "file_path": file_path}), 200
#     return jsonify({"err_message": "Can't upload data"}), 400


# @member_endpoints.route('/read/age/<id_member>', methods=['GET'])
# @jwt_required()
# def read_age(id_member):
#     """Routes for module get age book"""
#     connection = get_connection()
#     cursor = connection.cursor(dictionary=True)
#     select_query = "SELECT title, publication_year FROM tb_member where id_member=%s"
#     parameter_request = (str(id_member), )
#     cursor.execute(select_query, parameter_request)
#     results = cursor.fetchone()
#     publication_year = results['publication_year']
#     ages = diff_year(publication_year)
#     category_age = check_age_book(ages)
#     results["category_age"] = category_age

#     cursor.close()
#     return jsonify({"message": "OK", "datas": results}), 200
