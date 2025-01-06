from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/student', methods=['GET'])
def student_status():
    return jsonify({"student_status": "hired"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)