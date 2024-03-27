import tkinter as tk
from tkinter import filedialog
from PIL import Image, ImageTk
import numpy as np
import tensorflow as tf
import RPi.GPIO as GPIO
import time

# Load the saved model
model = tf.keras.models.load_model('vgg16_model.h5')

# Define image dimensions
img_width, img_height = 224, 224

# Define GPIO pins for servo motor
SERVO_PIN = 18  # Change this to the GPIO pin connected to your servo

# Setup GPIO
GPIO.setmode(GPIO.BCM)
GPIO.setup(SERVO_PIN, GPIO.OUT)

# Function to preprocess image
def preprocess_image(image_path):
    img = Image.open(image_path)
    img = img.resize((img_width, img_height))
    img_array = np.array(img) / 255.0
    img_array = np.expand_dims(img_array, axis=0)
    return img_array

# Function to predict image and control servo motor
def predict_and_control_servo():
    # Open file dialog to select image
    file_path = filedialog.askopenfilename()
    if file_path:
        # Preprocess the selected image
        img_array = preprocess_image(file_path)
        
        # Make prediction
        prediction = model.predict(img_array)
        
        # Control servo motor based on prediction
        if prediction[0][0] > 0.5:
            print("Predicted class: Non Bio-degradable")
            rotate_servo(90)  # Rotate servo to one direction
        else:
            print("Predicted class: Bio-degradable")
            rotate_servo(0)   # Rotate servo to another direction
        
        # Display the selected image (optional)
        img = Image.open(file_path)
        img.thumbnail((300, 300))
        img = ImageTk.PhotoImage(img)
        image_label.config(image=img)
        image_label.image = img

# Function to rotate servo motor
def rotate_servo(angle):
    duty = angle / 18 + 2
    GPIO.output(SERVO_PIN, True)
    pwm = GPIO.PWM(SERVO_PIN, 50)
    pwm.start(0)
    pwm.ChangeDutyCycle(duty)
    time.sleep(1)
    pwm.stop()
    GPIO.output(SERVO_PIN, False)

# Create GUI window
root = tk.Tk()
root.title("Garbage Classifier")

# Create widgets
select_button = tk.Button(root, text="Select Image", command=predict_and_control_servo)
select_button.pack(pady=10)

image_label = tk.Label(root)
image_label.pack(pady=10)

# Run the GUI
root.mainloop()

# Cleanup GPIO
GPIO.cleanup()
