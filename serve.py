import http.server
import socketserver
import os

PORT = 4141
FILENAME = "main.html"

class CustomHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path in ('/', '/main.html'):
            self.path = FILENAME
        return http.server.SimpleHTTPRequestHandler.do_GET(self)

os.chdir(os.path.dirname(os.path.abspath(__file__)))

with socketserver.TCPServer(("", PORT), CustomHandler) as httpd:
    print(f"Serving '{FILENAME}' at http://localhost:{PORT}")
    httpd.serve_forever()
