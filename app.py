from flask import Flask, send_from_directory
import os

app = Flask(__name__)
PORT = 4141
BASE_DIR = os.path.dirname(os.path.abspath(__file__))


@app.route('/')
def serve_index():
    return send_from_directory(BASE_DIR, 'index.html')


@app.route('/azakengame.html')
def serve_game():
    return send_from_directory(BASE_DIR, 'azakengame.html')


@app.route('/azakengame.js')
def serve_script():
    return send_from_directory(BASE_DIR, 'azakengame.js')


@app.route('/code')
def serve_code():
    return send_from_directory(BASE_DIR, 'code.html')


@app.route('/assets/<path:filename>')
def serve_assets(filename):
    return send_from_directory(os.path.join(BASE_DIR, 'assets'), filename)


if __name__ == '__main__':
    from waitress import serve
    print(f"Serving at http://localhost:{PORT}")
    serve(app, host='0.0.0.0', port=PORT)
