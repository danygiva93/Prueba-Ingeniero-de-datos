# danygiva93-Prueba-Ingeniero-de-datos


-----------------------------------------   Punto 1 ------------------------------------------------

Para el primer punto se crearon los archivos html con diferentes rutas y subdirectorios de imagenes.
Dentro de las imagenes se encuentran varios formatos como png, jpeg, jpg

Se crearon 2 archivos de python los cuales cumplen con el requerimiento de convertir las imágenes referenciadas en base64 y
crear una carpeta llamada output_html con los resultados en html.

	- Script.py Utiliza una libreria llamada BeautifulSoup la cual sirve para modificar el contenido de HTML.
	Se basa en una función principal (procesar_archivos_html) que contiene toda la lógica para procesar los archivos. 
	Es un enfoque procedimental o funcional.

	- Script.py Es un dessarrolo orientado a objetos el cual encapsula toda la logica dentro de un metodo.
	Se trabajo con librerias estandar.

1. Preparación
	Define las rutas de los archivos HTML de entrada y la carpeta de salida donde se guardarán los archivos procesados.
	Crea la carpeta de salida si no existe.
2. Lectura y análisis de HTML
	Primera versión: Usa BeautifulSoup para analizar el contenido HTML y buscar todas las etiquetas <img>.
	Segunda versión: Divide el contenido HTML en cadenas y localiza etiquetas <img> manualmente.
3. Procesamiento de imágenes
	Por cada etiqueta <img>:
	Obtiene el valor del atributo src (ruta de la imagen).
	Intenta leer la imagen desde el sistema de archivos usando la ruta.
	Convierte el contenido de la imagen en formato base64.
	Reemplaza el atributo src de la etiqueta <img> con un URI data:image/...;base64,....
4. Escritura del HTML procesado
	Guarda el contenido HTML modificado en la carpeta de salida, con el mismo nombre del archivo original.
5. Gestión de resultados
	Lleva un registro de:
	Imágenes exitosas: Las que se pudieron convertir y reemplazar correctamente.
	Imágenes fallidas: Las que no se encontraron o no pudieron procesarse.
	Muestra un resumen de los resultados (imágenes procesadas y errores) al final.



----------------------------------------------- PUNTO 2 -----------------------------------------------------

Para el segundo punto se crean 3 script de sql los cuales crean las tablas en una BD MySQL Worbrech e inserta los datos.
Adicional se crea un archivo llamado Consulta SQL el cual contiene la logica de la consulta.

En este ejercicio se modifico el documento de excel para que los datos de transacciones no fueran dinamicos 
y poder realizar pruebas de calidad de los datos en la con sulta.

Se trabajo solo por identificación y no se utilizó la columna nombre ya que se identifica que en la tabla clientes. 

Se tienen 2 transacciones en las que la IDENTIFICACIÓN no tiene un cliente asociado en la tabla CLIENTES. 
2C3D4E6F6G7H8I9J0 & 2A3B4C5D E7F8G9H0

1. Se crea una tabla temporal para calcular estadísticas de transacciones por cliente y categoría.
2. Se crea otra tabla temporal para crear un ranking de las categorías por cliente.
3 En la consuta final se tiene un filtro el cual se puede modificar para traer las categorias con mas transacciones 
  segun el ranking.
  Si hay empates en la cantidad de transacciones, la categoría más reciente se prioriza



----------------------------------------------- PUNTO 3 -----------------------------------------------------

Se crean y se llenann 2 tablas llamadas TBL_HISTORIA y TBL_RETIROS. estas tendran la informacion con la cual se realizara las ocnsultas.

Se crear 3 archivos SQL en el siguiente orden.

	1. rachas consecutivas
	2. Rachas especificas
	3. Rachas

Siendo el archivo 3 el que cumple con el proposito final del ejercicio pero basandose en la logia del archivo 1
