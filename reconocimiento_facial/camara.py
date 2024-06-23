import cv2
import dlib
import numpy as np

# Función para detectar rostros en la imagen usando dlib
def detectar_rostros(imagen):
    detector = dlib.get_frontal_face_detector()
    rects = detector(imagen, 1)
    return rects

# Función para extraer características faciales usando un modelo preentrenado de dlib
def extraer_caracteristicas_faciales(imagen, rect):
    predictor = dlib.face_recognition_model_v1("shape_predictor_68_face_landmarks.dat")
    shape = predictor(imagen, rect)
    face_descriptor = np.array(predictor.compute_face_descriptor(imagen, shape))
    return face_descriptor

# Función para comparar características faciales y determinar si son la misma persona
def comparar_caracteristicas(descriptor1, descriptor2, umbral=0.6):
    distancia = np.linalg.norm(descriptor1 - descriptor2)
    print("Distancia euclidiana entre las características faciales:", distancia)
    if distancia < umbral:
        return True
    else:
        return False

# Función para capturar una foto desde la cámara
def capturar_foto(nombre_archivo):
    cap = cv2.VideoCapture(0)
    if not cap.isOpened():
        print("Error al acceder a la cámara.")
        return

    # Capturar la imagen desde la cámara
    ret, frame = cap.read()
    if ret:
        cv2.imwrite(nombre_archivo, frame)
        print(f"Foto guardada como {nombre_archivo}")
    else:
        print("No se pudo capturar la imagen.")

    cap.release()

# Nombre de los archivos de imagen a verificar
archivo_dni = "dni.jpg"
archivo_rostro = "rostro.jpg"

# Capturar la foto del DNI
print("Por favor, coloque su DNI o carnet frente a la cámara y presione Enter para capturar la foto.")
input()
capturar_foto(archivo_dni)

# Capturar la foto del rostro
print("Ahora, mire directamente a la cámara y presione Enter para capturar la foto de su rostro.")
input()
capturar_foto(archivo_rostro)

# Cargar y procesar las imágenes capturadas
imagen_dni = cv2.imread(archivo_dni, cv2.IMREAD_GRAYSCALE)
imagen_rostro = cv2.imread(archivo_rostro, cv2.IMREAD_GRAYSCALE)

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
