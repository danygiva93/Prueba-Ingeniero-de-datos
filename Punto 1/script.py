import os
import base64
from bs4 import BeautifulSoup

def procesar_archivos_html(rutas_entrada, carpeta_salida):
    os.makedirs(carpeta_salida, exist_ok=True)  # Crear carpeta de salida
    resultados = {"exitosos": [], "fallidos": []}

    for archivo in rutas_entrada:
        try:
            with open(archivo, "r", encoding="utf-8") as f:
                soup = BeautifulSoup(f, "html.parser")

            for img in soup.find_all("img"):
                src = img.get("src")
                if src:
                    try:
                        ruta_imagen = os.path.join(os.path.dirname(archivo), src)
                        with open(ruta_imagen, "rb") as img_file:
                            base64_img = base64.b64encode(img_file.read()).decode("utf-8")
                        img["src"] = f"data:image/{src.split('.')[-1]};base64,{base64_img}"
                        resultados["exitosos"].append(src)
                    except:
                        resultados["fallidos"].append(src)

            ruta_salida = os.path.join(carpeta_salida, os.path.basename(archivo))
            with open(ruta_salida, "w", encoding="utf-8") as f:
                f.write(str(soup))

        except Exception as e:
            print(f"Error procesando {archivo}: {e}")

    return resultados

# Código principal
if __name__ == "__main__":
    ruta_proyecto = r"C:\Users\daniel.giraldo\Downloads\Prueba ingeniero de datos #2\Punto 1"
    rutas_entrada = [os.path.join(ruta_proyecto, f"html{i}.html") for i in range(1, 3)]
    carpeta_salida = os.path.join(ruta_proyecto, "output_html")

    resultados = procesar_archivos_html(rutas_entrada, carpeta_salida)
    print("Imágenes exitosas:", resultados["exitosos"])
    print("Imágenes fallidas:", resultados["fallidos"])
