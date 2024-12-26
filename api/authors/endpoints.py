"""Routes for module authors"""
import os
from flask import Blueprint, jsonify, request
from helper.db_helper import get_connection
from helper.form_validation import get_form_data
from flask_jwt_extended import jwt_required

authors_endpoints = Blueprint('authors', __name__)
UPLOAD_FOLDER = "img"


@authors_endpoints.route('/read', methods=['GET'])
@jwt_required()
def read():
    """Routes for module get list authors"""
    connection = get_connection()
    cursor = connection.cursor(dictionary=True)
    select_query = "SELECT author_id, first_name, last_name FROM tb_authors"
    cursor.execute(select_query)
    results = cursor.fetchall()
    cursor.close()  # Close the cursor after query execution
    return jsonify({"message": "OK", "datas": results}), 200


@authors_endpoints.route('/create', methods=['POST'])
@jwt_required()
def create():
    """Routes for module create a authors"""
    required = get_form_data(["first_name", "last_name"])  # use only if the field required
    firstName = required["first_name"]
    lastName = required["last_name"]

    connection = get_connection()
    cursor = connection.cursor()
    insert_query = "INSERT INTO tb_authors (first_name, last_name) VALUES (%s, %s)"
    request_insert = (firstName, lastName)
    cursor.execute(insert_query, request_insert)
    connection.commit()  # Commit changes to the database
    cursor.close()
    new_id = cursor.lastrowid  # Get the newly inserted book's ID
    if new_id:
        return jsonify({"first_name": firstName, "message": "Inserted", "author_id": new_id}), 201
    return jsonify({"message": "Cant Insert Data"}), 500



@authors_endpoints.route('/update/<author_id>', methods=['PUT'])
@jwt_required()
def update(author_id):
    """Routes for module update a author"""
    required = get_form_data(["first_name", "last_name"])  # use only if the field required
    firstName = required["first_name"]
    lastName = required["last_name"]

    connection = get_connection()
    cursor = connection.cursor()

    update_query = "UPDATE tb_authors SET first_name=%s, last_name=%s WHERE author_id=%s"
    update_request = (firstName, lastName, author_id)
    cursor.execute(update_query, update_request)
    connection.commit()
    cursor.close()
    data = {"message": "updated", "id_authors": author_id}
    return jsonify(data), 200


@authors_endpoints.route('/delete/<author_id>', methods=['GET'])
@jwt_required()
def delete(author_id):
    """Routes for module to delete a book"""
    connection = get_connection()
    cursor = connection.cursor()

    delete_query = "DELETE FROM tb_authors WHERE author_id = %s"
    delete_id = (author_id,)
    cursor.execute(delete_query, delete_id)
    connection.commit()
    cursor.close()
    data = {"message": "Data deleted", "id_authors": author_id}
    return jsonify(data)