from flask import Flask, request, jsonify, render_template, send_from_directory
from datetime import datetime, timedelta

app = Flask(__name__, template_folder=".")

# In-memory storage for user data (replace with a database in production)
users = []

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/submit", methods=["POST"])
def submit():
    data = request.json
    username = data.get("username")
    destination = data.get("destination")
    trip_date = data.get("tripDate")

    # Validate trip date
    current_date = datetime.now()
    max_date = current_date + timedelta(days=30)
    trip_date_obj = datetime.strptime(trip_date, "%Y-%m-%d")

    if trip_date_obj > max_date:
        return jsonify({"error": "Trip date must be within 30 days from today."}), 400

    # Store user data
    users.append({
        "username": username,
        "destination": destination,
        "tripDate": trip_date,
    })

    print(request.headers)
    return jsonify({"message": "Data submitted successfully!"}), 200

DIRECTORY = './'


@app.route('/<path:filename>')
def game(filename):
    resp = send_from_directory(DIRECTORY, filename)
    resp.headers['Access-Control-Allow-Origin'] = '*'
    #Cross-Origin-Opener-Policy: same-origin
    #Cross-Origin-Embedder-Policy: require-corp
    resp.headers['Cross-Origin-Opener-Policy'] = 'same-origin'
    resp.headers['Cross-Origin-Embedder-Policy'] = 'require-corp'
    return resp

if __name__ == "__main__":
    app.run()