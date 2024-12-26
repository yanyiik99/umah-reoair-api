"""Routes for module books"""
import os
from flask import Blueprint, jsonify, request
from helper.db_helper import get_connection
from helper.year_operation import check_age_book,diff_year
from helper.form_validation import get_form_data
from flask_jwt_extended import jwt_required

books_endpoints = Blueprint('books', __name__)
UPLOAD_FOLDER = "img"


@books_endpoints.route('/read', methods=['GET'])
@jwt_required()
def read():
    """Routes for module get list books"""
    connection = get_connection()
    cursor = connection.cursor(dictionary=True)
    select_query = "SELECT * FROM tb_books"
    cursor.execute(select_query)
    results = cursor.fetchall()
    cursor.close()  # Close the cursor after query execution
    return jsonify({"message": "OK", "datas": results}), 200


@books_endpoints.route('/create', methods=['POST'])
@jwt_required()
def create():
    """Routes for module create a book"""
    required = get_form_data(["title"])  # use only if the field required
    title = required["title"]
    description = request.form['description']

    connection = get_connection()
    cursor = connection.cursor()
    insert_query = "INSERT INTO tb_books (title, description) VALUES (%s, %s)"
    request_insert = (title, description)
    cursor.execute(insert_query, request_insert)
    connection.commit()  # Commit changes to the database
    cursor.close()
    new_id = cursor.lastrowid  # Get the newly inserted book's ID\
    if new_id:
        return jsonify({"title": title, "message": "Inserted", "id_books": new_id}), 201
    return jsonify({"message": "Cant Insert Data"}), 500


@books_endpoints.route('/update/<product_id>', methods=['PUT'])
@jwt_required()
def update(product_id):
    """Routes for module update a book"""
    email = request.form['email']
    nama = request.form['nama']
    alamat = request.form['alamat']

    connection = get_connection()
    cursor = connection.cursor()

    update_query = "UPDATE tb_books SET nama=%s, alamat=%s WHERE id_books=%s"
    update_request = (nama, alamat, product_id)
    cursor.execute(update_query, update_request)
    connection.commit()
    cursor.close()
    return jsonify({"message": "Updated", "member": nama}), 200


@books_endpoints.route('/delete/<product_id>', methods=['GET'])
@jwt_required()
def delete(product_id):
    """Routes for module to delete a book"""
    connection = get_connection()
    cursor = connection.cursor()

    delete_query = "DELETE FROM tb_books WHERE id_books = %s"
    delete_id = (product_id,)
    cursor.execute(delete_query, delete_id)
    connection.commit()
    cursor.close()
    data = {"message": "Data deleted", "id_books": product_id}
    return jsonify(data)


@books_endpoints.route("/upload", methods=["POST"])
@jwt_required()
def upload():
    """Routes for upload file"""
    uploaded_file = request.files['file']
    if uploaded_file.filename != '':
        file_path = os.path.join(UPLOAD_FOLDER, uploaded_file.filename)
        uploaded_file.save(file_path)
        return jsonify({"message": "ok", "data": "uploaded", "file_path": file_path}), 200
    return jsonify({"err_message": "Can't upload data"}), 400


@books_endpoints.route('/read/age/<id_books>', methods=['GET'])
@jwt_required()
def read_age(id_books):
    """Routes for module get age book"""
    connection = get_connection()
    cursor = connection.cursor(dictionary=True)
    select_query = "SELECT title, publication_year FROM tb_books where id_books=%s"
    parameter_request = (str(id_books), )
    cursor.execute(select_query, parameter_request)
    results = cursor.fetchone()
    publication_year = results['publication_year']
    ages = diff_year(publication_year)
    category_age = check_age_book(ages)
    results["category_age"] = category_age

    cursor.close()
    return jsonify({"message": "OK", "datas": results}), 200
