#!/usr/bin/env python3
"""Serve Quantum Puter Lab on the local network and print the URL."""
from __future__ import annotations
import http.server
import os
import socket
import socketserver
import sys

ROOT = os.path.dirname(os.path.abspath(__file__))
PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 8766


def free_port(start: int) -> int:
    port = start
    while port < start + 40:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            try:
                s.bind(("", port))
                return port
            except OSError:
                port += 1
    raise SystemExit("no free port")


def lan_ip() -> str:
    # Prefer a private IPv4; skip link-local / tunnel if a LAN address exists.
    preferred = []
    try:
        for inf in socket.getaddrinfo(socket.gethostname(), None, socket.AF_INET):
            ip = inf[4][0]
            if ip.startswith("127."):
                continue
            preferred.append(ip)
    except OSError:
        pass
    # UDP trick for the outbound interface
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        preferred.insert(0, s.getsockname()[0])
        s.close()
    except OSError:
        pass
    for ip in preferred:
        if ip.startswith(("192.168.", "10.")) or ip.startswith("172."):
            return ip
    return preferred[0] if preferred else "127.0.0.1"


class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=ROOT, **kwargs)

    def end_headers(self):
        self.send_header("Cache-Control", "no-cache")
        self.send_header("Service-Worker-Allowed", "/")
        super().end_headers()

    def log_message(self, fmt, *args):
        sys.stderr.write("%s - %s\n" % (self.address_string(), fmt % args))


if __name__ == "__main__":
    os.chdir(ROOT)
    port = free_port(PORT)
    ip = lan_ip()
    print()
    print("  Quantum Puter Lab")
    print("  This computer:  http://127.0.0.1:%d/" % port)
    print("  On your iPhone (same Wi-Fi):  http://%s:%d/" % (ip, port))
    print()
    print("  Safari → Share → Add to Home Screen")
    print("  Ctrl-C to stop.")
    print()
    socketserver.TCPServer.allow_reuse_address = True
    with socketserver.TCPServer(("0.0.0.0", port), Handler) as httpd:
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nstopped")
