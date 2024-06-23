import cv2
import dlib
import numpy as np
import tkinter as tk
from PIL import Image, ImageTk

# Ruta del archivo de modelo de predicción de puntos faciales
ruta_shape_predictor = "shape_predictor_68_face_landmarks.dat"
ruta_face_recognition_model = "dlib_face_recognition_resnet_model_v1.dat"

# Función para detectar rostros en la imagen usando dlib
def detectar_rostros(imagen):
    detector = dlib.get_frontal_face_detector()
    rects = detector(imagen, 1)
    return rects

# Función para extraer características faciales usando un modelo preentrenado de dlib
def extraer_caracteristicas_faciales(imagen, rect):
    shape_predictor = dlib.shape_predictor(ruta_shape_predictor)
    face_rec_model = dlib.face_recognition_model_v1(ruta_face_recognition_model)
    shape = shape_predictor(imagen, rect)
    face_descriptor = np.array(face_rec_model.compute_face_descriptor(imagen, shape))
    return face_descriptor

# Función para comparar características faciales y determinar si son la misma persona
def comparar_caracteristicas(descriptor1, descriptor2, umbral=0.6):
    distancia = np.linalg.norm(descriptor1 - descriptor2)
    print("Distancia euclidiana entre las características faciales:", distancia)
    return distancia < umbral

# Función para capturar una foto desde la cámara
def capturar_foto(nombre_archivo, ventana):
    cap = cv2.VideoCapture(0)
    if not cap.isOpened():
        print("Error al acceder a la cámara.")
        return

    global capturando
    while True:
        ret, frame = cap.read()
        if ret:
            # Mostrar el fotograma en la ventana
            fotograma = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            fotograma = Image.fromarray(fotograma)
            img_tk = ImageTk.PhotoImage(image=fotograma)
            ventana.img_tk = img_tk  # Guardar una referencia para evitar que se recolecte basura
            canvas.create_image(0, 0, anchor=tk.NW, image=img_tk)
        ventana.update()

        # Esperar hasta que se presione el botón de captura
        if capturando:
            cv2.imwrite(nombre_archivo, frame)
            print(f"Foto guardada como {nombre_archivo}")
            break

    cap.release()

# Función para manejar el evento de captura
def capturar():
    global capturando
    capturando = True

# Crear la ventana principal
ventana = tk.Tk()
ventana.title("Captura de Imágenes")

# Crear un lienzo para mostrar el video
canvas = tk.Canvas(ventana, width=1300, height=750)
canvas.pack()

# Botón de captura
btn_capturar = tk.Button(ventana, text="Capturar Imagen", command=capturar)
btn_capturar.pack(pady=10)

# Nombre de los archivos de imagen a verificar
archivo_dni = "dni.jpg"
archivo_rostro = "rostro.jpg"

# Iniciar la captura del DNI
capturando = False
print("Por favor, coloque su DNI o carnet frente a la cámara y presione el botón para capturar la foto.")

# Capturar la foto del DNI
capturar_foto(archivo_dni, ventana)

# Limpiar ventana antes de capturar el rostro
canvas.delete("all")

# Iniciar la captura del rostro
capturando = False
print("Ahora, mire directamente a la cámara y presione el botón para capturar la foto de su rostro.")

# Capturar la foto del rostro
capturar_foto(archivo_rostro, ventana)

# Cerrar la ventana cuando se haya capturado ambas imágenes
ventana.destroy()

# Cargar y procesar las imágenes capturadas
imagen_dni = cv2.imread(archivo_dni)
imagen_rostro = cv2.imread(archivo_rostro)

# Detectar rostros en ambas imágenes
rect_dni = detectar_rostros(imagen_dni)
rect_rostro = detectar_rostros(imagen_rostro)

if len(rect_dni) == 0 or len(rect_rostro) == 0:
    print("No se detectó ningún rostro en una de las imágenes.")
else:
    # Extraer características faciales
    caracteristicas_dni = extraer_caracteristicas_faciales(imagen_dni, rect_dni[0])
    caracteristicas_rostro = extraer_caracteristicas_faciales(imagen_rostro, rect_rostro[0])

    # Comparar características faciales
    if comparar_caracteristicas(caracteristicas_dni, caracteristicas_rostro):
        print("Las imágenes corresponden a la misma persona.")
    else:
        print("Las imágenes no corresponden a la misma persona.")

# Ejecutar la ventana principal
ventana.mainloop()
