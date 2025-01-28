# -*- coding: utf-8 -*-
"""
Created on Tue Jan 28 10:43:06 2025

@author: daniel.giraldo
"""

import os
import base64
from html.parser import HTMLParser


class ProcesadorHTML:
    def __init__(self, rutas_entrada, carpeta_salida):
        self.rutas_entrada = rutas_entrada
        self.carpeta_salida = carpeta_salida
        self.resultados = {"exitosos": [], "fallidos": []}

    def procesar(self):
        os.makedirs(self.carpeta_salida, exist_ok=True)
        
        for archivo in self.rutas_entrada:
            try:
                with open(archivo, "r", encoding="utf-8") as f:
                    contenido_html = f.read()

                imagenes = self.extraer_imagenes(contenido_html, archivo)
                nuevo_html = self.reemplazar_imagenes(contenido_html, imagenes)

                ruta_salida = os.path.join(self.carpeta_salida, os.path.basename(archivo))
                with open(ruta_salida, "w", encoding="utf-8") as f:
                    f.write(nuevo_html)

            except Exception as e:
                print(f"Error procesando {archivo}: {e}")
        
        return self.resultados

    def extraer_imagenes(self, contenido_html, archivo):
        imagenes = []
        parser = HTMLParser()
        
        # Extraer todas las etiquetas <img> del contenido HTML
        partes_html = contenido_html.split('<img ')
        for parte in partes_html[1:]:
            src_pos = parte.find('src="')
            if src_pos != -1:
                src_start = src_pos + 5
                src_end = parte.find('"', src_start)
                src = parte[src_start:src_end]

                ruta_imagen = os.path.join(os.path.dirname(archivo), src)
                imagenes.append((src, ruta_imagen))
        
        return imagenes

    def reemplazar_imagenes(self, contenido_html, imagenes):
        for src, ruta_imagen in imagenes:
            try:
                with open(ruta_imagen, "rb") as img_file:
                    base64_img = base64.b64encode(img_file.read()).decode("utf-8")
                tipo_imagen = src.split('.')[-1]
                data_uri = f"data:image/{tipo_imagen};base64,{base64_img}"
                contenido_html = contenido_html.replace(f'src="{src}"', f'src="{data_uri}"')
                self.resultados["exitosos"].append(src)
            except Exception:
                self.resultados["fallidos"].append(src)

        return contenido_html


# Código principal
if __name__ == "__main__":
    ruta_proyecto = r"C:\Users\daniel.giraldo\Downloads\Prueba ingeniero de datos #2\Punto 1"
    rutas_entrada = [os.path.join(ruta_proyecto, f"html{i}.html") for i in range(1, 3)]
    carpeta_salida = os.path.join(ruta_proyecto, "output_html")

    procesador = ProcesadorHTML(rutas_entrada, carpeta_salida)
    resultados = procesador.procesar()

    print("Imágenes exitosas:", resultados["exitosos"])
    print("Imágenes fallidas:", resultados["fallidos"])
