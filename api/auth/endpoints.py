"""Routes for module books"""
from flask import Blueprint, jsonify, request
from flask_jwt_extended import create_access_token, decode_token
from flask_bcrypt import Bcrypt

from helper.db_helper import get_connection

bcrypt = Bcrypt()
auth_endpoints = Blueprint('auth', __name__)


@auth_endpoints.route('/admin/login', methods=['POST'])
def login_admin():
    """Routes for login admin"""
    email = request.form['email']
    password = request.form['password']

    if not email or not password:
        return jsonify({"msg": "Email and password are required"}), 400

    connection = get_connection()
    cursor = connection.cursor(dictionary=True)
    query = "SELECT * FROM users WHERE email = %s AND is_deleted = 'no'"
    request_query = (email,)
    cursor.execute(query, request_query)
    user = cursor.fetchone()
    cursor.close()

    if not user or not bcrypt.check_password_hash(user.get('password'), password):
        return jsonify({"msg": "Bad email or password"}), 401

    access_token = create_access_token(identity={'email': email}, additional_claims={'roles': 'admin'})
    decoded_token = decode_token(access_token)
    expires = decoded_token['exp']
    return jsonify({"access_token": access_token, "expires_in": expires, "type": "Bearer"})


@auth_endpoints.route('/login', methods=['POST'])
def login_member():
    """Routes for login member"""
    email = request.form['email']
    password = request.form['password']

    if not email or not password:
        return jsonify({"msg": "Email and password are required"}), 400

    connection = get_connection()
    cursor = connection.cursor(dictionary=True)
    query = "SELECT * FROM member WHERE email = %s AND is_deleted = 'no'"
    request_query = (email,)
    cursor.execute(query, request_query)
    member = cursor.fetchone()
    cursor.close()

    if not member or not bcrypt.check_password_hash(member.get('password'), password):
        return jsonify({"msg": "Bad email or password"}), 401

    access_token = create_access_token(identity={'email': email}, additional_claims={'roles': 'member'})
    decoded_token = decode_token(access_token)
    expires = decoded_token['exp']
    return jsonify({"access_token": access_token, "expires_in": expires, "type": "Bearer"})


@auth_endpoints.route('/register', methods=['POST'])
def register_member():
    """Routes for register member"""
    email = request.form['email']
    password = request.form['password']
    nama = request.form['nama']
    no_tlpn = request.form['no_tlpn']
    # To hash a password
    hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')

    connection = get_connection()
    cursor = connection.cursor()
    insert_query = "INSERT INTO member (email, password, nama, no_tlpn) values (%s, %s, %s, %s)"
    request_insert = (email, hashed_password, nama, no_tlpn)
    cursor.execute(insert_query, request_insert)
    connection.commit()
    cursor.close()
    new_id = cursor.lastrowid
    if new_id:
        return jsonify({"status": "OK",
                        "message": "Member Succesfully Register"}), 201
    return jsonify({"status": "Failed", "message": "Can't register Member"}), 501
