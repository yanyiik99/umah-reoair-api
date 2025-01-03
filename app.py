"""Small apps to demonstrate endpoints with basic feature - CRUD"""

from flask import Flask
from flask_cors import CORS
from dotenv import load_dotenv
from extensions import jwt
from api.auth.endpoints import auth_endpoints
from api.member.endpoints import member_endpoints
from api.staff.endpoints import staff_endpoints
from api.layanan.endpoints import layanan_endpoints
from api.promo.endpoints import promo_endpoints
from api.data_protected.endpoints import protected_endpoints

# from api.books.endpoints import books_endpoints
# from api.authors.endpoints import authors_endpoints
from config import Config
from static.static_file_server import static_file_server


# Load environment variables from the .env file
load_dotenv()

app = Flask(__name__)
app.config.from_object(Config)
CORS(app)


jwt.init_app(app)

# register the blueprint
app.register_blueprint(auth_endpoints, url_prefix='/api/v1/auth')
app.register_blueprint(member_endpoints, url_prefix='/api/v1/member')
app.register_blueprint(staff_endpoints, url_prefix='/api/v1/staff')
app.register_blueprint(layanan_endpoints, url_prefix='/api/v1/layanan')
app.register_blueprint(promo_endpoints, url_prefix='/api/v1/promo')
app.register_blueprint(static_file_server, url_prefix='/static/')
app.register_blueprint(protected_endpoints,url_prefix='/api/v1/protected')

# Deprect
# app.register_blueprint(books_endpoints, url_prefix='/api/v1/books')
# app.register_blueprint(authors_endpoints, url_prefix='/api/v1/authors')

if __name__ == '__main__':
    app.run(debug=True, host='127.0.0.1', port=5000)
