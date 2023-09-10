import http.server
import socketserver
import json
import redis

class RequestHandler(http.server.SimpleHTTPRequestHandler):

    def _send_cors_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', '*')
        self.send_header('Access-Control-Allow-Headers', '*')

    def do_OPTIONS(self):
        self.send_response(200, "ok")
        self._send_cors_headers()
        self.end_headers()

    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "application/json")
        self._send_cors_headers()
        self.end_headers()

        if self.path == '/health':
            self.wfile.write(bytes(f"up", "utf8"))
        if self.path == '/reader':
            try:
                redishost = "cluster-redis.vovly9.0001.use1.cache.amazonaws.com"
                redisclient = redis.Redis(host=redishost,
                                port=6379,
                                db=0)
                self.wfile.write(redisclient.get("SHAREDKEY"))
            except Exception as ex:
                print(ex)

        return


handler_object = RequestHandler
server = socketserver.TCPServer(("", 8080), handler_object)
server.serve_forever()
