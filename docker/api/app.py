from flask import Flask, jsonify
import os

app = Flask(__name__)

APP_NAME = os.getenv("APP_NAME", "Contoso Banking API")
APP_VERSION = os.getenv("APP_VERSION", "1.0.0")


@app.get("/health")
def health():
    return jsonify({
        "status": "healthy",
        "service": APP_NAME,
        "version": APP_VERSION
    }), 200


@app.get("/api")
def api():
    return jsonify({
        "message": "Contoso Banking API is running",
        "service": APP_NAME,
        "version": APP_VERSION
    }), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)