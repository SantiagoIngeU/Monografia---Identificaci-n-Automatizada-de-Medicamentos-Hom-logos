# Identificación Automatizada de Medicamentos Homologos

## La presente monografía propone un sistema automatizado para la identificación de medicamentos homólogos mediante el uso de representaciones semánticas y medidas de similitud vectorial. El proyecto surge ante la necesidad de optimizar el proceso de homologación dentro de Grupo Afín Farmacéutica, donde actualmente la verificación de equivalencias entre productos depende de procesos manuales propensos a errores y demoras. Para abordar esta problemática, se emplearon bases de datos internas de la organización y registros oficiales del INVIMA, integrando información estructurada sobre más de 4.000 medicamentos activos. La metodología combina técnicas de procesamiento del lenguaje natural (NLP), generación de embeddings con modelos tipo Sentence-BERT (all-MiniLM-L6-v2) y cálculo de similitud del coseno para determinar correspondencias semánticas entre descripciones. Asimismo, se aplicó reducción de dimensionalidad mediante UMAP, TSNE y PSA, lo que permitió visualizar y agrupar relaciones farmacológicas. Las principales iteraciones se enfocaron en ajustar umbrales de similitud y depurar el texto fuente, enfrentando desafíos como la normalización de nombres comerciales y la variabilidad en las descripciones regulatorias.

# MediSyncMatch – Análisis y Preparación de Datos

Este repositorio contiene el cuaderno `MediSyncMatch.ipynb`, en el cual se realiza el flujo de trabajo completo de preparación, exploración y vectorización de textos para el proyecto **MediSyncMatch** (homologación / emparejamiento semántico de medicamentos).

El notebook está organizado en varias secciones principales que abarcan desde la carga de datos hasta la creación de *embeddings* y la evaluación del sistema.

---

## Contenido del notebook

### 1. Librerías

En esta sección se importan todas las librerías necesarias para el análisis, tales como:

- Manejo de datos (por ejemplo: `pandas`, `numpy`)
- Procesamiento de texto / NLP (por ejemplo: `re`, librerías de tokenización / stopwords)
- Visualización (por ejemplo: `matplotlib`, `seaborn` o similares)
- Creación de *embeddings* (por ejemplo: modelos tipo Sentence-BERT, etc.)

El objetivo es dejar centralizadas todas las dependencias utilizadas en el cuaderno.

---

### 2. Lectura de la data

Se realiza la carga de la fuente de datos principal (por ejemplo, un archivo CSV, Excel o una tabla exportada de una base de datos).

En esta sección típicamente se incluye:

- Ruta y nombre del archivo de entrada
- Lectura del archivo con `pandas`
- Revisión inicial de las columnas disponibles y tipos de datos

---

### 3. Nulos

Análisis de valores faltantes en las columnas relevantes:

- Conteo de nulos por columna
- Identificación de campos críticos con alta proporción de nulos
- Definición de estrategia para tratarlos (eliminación, imputación, etc.)

---

### 4. Duplicados

Detección y tratamiento de registros duplicados:

- Revisión de duplicados según columnas clave (por ejemplo, código interno, descripción, etc.)
- Decisión sobre:
  - Eliminarlos completamente
  - Mantener solo uno de ellos
  - O consolidar información si aplica

---

### 5. Transformaciones en la data

Conjunto de transformaciones aplicadas para dejar el dataset listo para el análisis semántico y la creación de *embeddings*.

#### 5.1 Eliminación de caracteres especiales y transformación a mayúsculas

- Limpieza de texto:
  - Eliminación de caracteres especiales (signos, símbolos, etc.)
  - Normalización de textos (por ejemplo, pasar todo a MAYÚSCULAS)
- Unificación de formatos para facilitar la comparación semántica

#### 5.2 Exploración semántica

Análisis inicial de los textos para entender:

- Frecuencia de palabras
- Términos más comunes
- Posibles patrones relevantes en descripciones o nombres de medicamentos

##### 5.2.1 Graficando la distribución de palabras

- Gráficos que muestran la distribución de palabras más frecuentes
- Posibles *word clouds* o diagramas de barras con las palabras dominantes

##### 5.2.2 Graficando la distribución de las palabras (variantes)

- Otras visualizaciones similares o complementarias
- Comparación por columnas o subconjuntos específicos

#### 5.3 Eliminación de *stop words* y caracteres especiales (excepto en código interno)

- Eliminación de palabras vacías (*stop words*) en columnas textuales
- Conservación de la columna de **código interno** sin estas transformaciones si se requiere mantener exactitud
- Limpieza adicional de símbolos y espacios innecesarios

#### 5.4 Longitud en los textos

- Cálculo de la longitud de los textos (número de caracteres o número de palabras)
- Análisis de distribución de longitudes:
  - Detección de textos demasiado cortos o demasiado largos
  - Posibles filtros por longitud mínima/máxima para mejor calidad de *embeddings*

#### 5.5 Creación de columna con el documento completo

- Unificación de varias columnas textuales (por ejemplo: nombre, descripción, presentación, etc.) en una sola columna
- Esta columna “documento completo” se utiliza como entrada final para el modelo de *embeddings*

---

### 6. Creación de los embeddings de la data

En esta sección se construyen las representaciones vectoriales (*embeddings*) a partir de la columna de texto unificada:

- Carga o definición del modelo de *embeddings* (por ejemplo, Sentence-BERT)
- Generación de vectores para cada registro
- Almacenamiento de estos vectores (en memoria, archivo, o base de datos) para usos posteriores:
  - Búsqueda semántica
  - Clustering
  - Homologación de medicamentos, etc.

---

### 7. Evaluación del sistema

Finalmente, se realiza una evaluación del desempeño del sistema de *embeddings* y/o del flujo completo:

- Definición de métricas (por ejemplo: similitud promedio entre medicinas equivalentes, top-k accuracy, etc.)
- Pruebas con ejemplos conocidos o parejas de medicamentos “homólogos”
- Análisis cualitativo: revisión manual de vecinos más cercanos para validar la coherencia semántica

---

## Requisitos

> **Nota:** Ajusta esta sección según las librerías que realmente uses en el notebook.

Ejemplo de requisitos mínimos:

- Python 3.10+
- `pandas`
- `numpy`
- `matplotlib`
- `scikit-learn`
- Librería de *embeddings* (por ejemplo: `sentence-transformers`)

Puedes instalar las dependencias con:

```bash
pip install -r requirements.txt
