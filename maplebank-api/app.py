from flask import Flask, jsonify

app = Flask(__name__)


@app.get("/health")
def health():
    return jsonify({"status": "healthy"})


@app.get("/accounts")
def accounts():
    return jsonify([
        {"id": 101, "name": "Savings", "balance": 5000},
        {"id": 102, "name": "Checking", "balance": 2500}
    ])


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)