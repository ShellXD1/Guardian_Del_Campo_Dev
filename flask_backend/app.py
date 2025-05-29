from flask import Flask, request, jsonify
from ultralytics import YOLO
import os
from PIL import Image
import uuid

app = Flask(__name__)
model = YOLO("yolov8_model/best.pt")
UPLOAD_FOLDER = "uploads"
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

@app.route("/predict", methods=["POST"])
def predict():
    if "image" not in request.files:
        return jsonify({"error": "No image provided"}), 400

    image = request.files["image"]
    filename = f"{uuid.uuid4()}.jpg"
    filepath = os.path.join(UPLOAD_FOLDER, filename)
    image.save(filepath)

    # Realizar la predicción
    results = model.predict(filepath)
    detections = results[0].boxes.data.tolist()

    # Extraer las clases detectadas
    class_names = [model.names[int(d[5])] for d in detections]

    mensaje = "Se detectaron plagas: " + ", ".join(class_names) if class_names else "No se detectaron plagas."

    return jsonify({"resultado": mensaje})

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)