# Ejercicios Capítulo 2 – Flex & Bison

## El objetivo de estos ejercicios es comprender el funcionamiento de los analizadores léxicos (lexical scanners) utilizando la herramienta Flex, la cual permite reconocer patrones dentro de un texto mediante expresiones regulares.

## Los ejercicios realizados son:

- Ejercicio 1: Modificar el scanner para evitar procesar el texto carácter por carácter.

- Ejercicio 2: Crear un contador de palabras que ignore diferencias entre mayúsculas y minúsculas.

- Ejercicio 3: Implementar un sistema de referencia cruzada de identificadores utilizando tablas hash.

Todos los programas fueron desarrollados y ejecutados utilizando Flex, GCC y Cygwin.

<img width="501" height="270" alt="Captura de pantalla 2026-03-04 184430" src="https://github.com/user-attachments/assets/4267d3ef-e303-45de-acfb-6aecc01278fa" />

--

# Ejercicio 1 – Procesamiento de Líneas

## En este ejercicio se modifica el scanner para que procese líneas completas de texto, permitiendo imprimir el número de línea correspondiente a cada una.

El programa detecta:

- Texto normal

- Directivas #include

- Número de línea del texto leído

Esto permite mejorar la eficiencia del procesamiento del texto.

## Compilación

Ingresar a la carpeta del ejercicio:

```
cd exercise1
```

Generar el analizador léxico:

```
flex scanner.l
```

Compilar el programa:

```
gcc lex.yy.c -o scanner -lfl
```

Ejecutar el programa:

```
./scanner
```

Ejemplo de ejecución

Entrada:
```
Hola
Mundo
Prueba
```

<img width="303" height="85" alt="Captura de pantalla 2026-03-04 185323" src="https://github.com/user-attachments/assets/d863c384-8b90-4284-b8a8-604465ad74fc" />

--

<img width="455" height="301" alt="Captura de pantalla 2026-03-04 185259" src="https://github.com/user-attachments/assets/4db1f6ed-c35b-449b-8a21-6b52229dd378" />

--

<img width="354" height="221" alt="Captura de pantalla 2026-03-04 224052" src="https://github.com/user-attachments/assets/815d96d4-9834-433e-a89f-4df8d10ad793" />

--

# Ejercicio 2 – Contador de Palabras

## Este programa cuenta la cantidad de palabras presentes en un texto de entrada.

Para reconocer palabras se utiliza la siguiente expresión regular:

* [a-zA-Z]+

- El scanner identifica cada palabra encontrada en el texto y aumenta el contador correspondiente.

Este ejercicio demuestra cómo Flex puede utilizarse para realizar tareas básicas de procesamiento de texto.

## Compilación

Ingresar a la carpeta:
```
cd exercise2
```

Generar el scanner:
```
flex scanner.l
```

Compilar el programa:
```
gcc lex.yy.c -o wordcount -lfl
```

Ejecutar:

```
./wordcount
```

Ejemplo de ejecución

Entrada:
```
Hola hola mundo Mundo
```
<img width="287" height="255" alt="Captura de pantalla 2026-03-04 225437" src="https://github.com/user-attachments/assets/460badc5-f7f1-4135-ac79-5980b8c66ac5" />

--

<img width="278" height="285" alt="Captura de pantalla 2026-03-04 232914" src="https://github.com/user-attachments/assets/52e9dcf4-f346-4f86-a291-2de7443b00e5" />

--


# Ejercicio 3 – Sistema de Referencias Cruzadas

## Este programa implementa un sistema de referencia cruzada de identificadores.

El programa analiza un código fuente y registra:

- cada identificador encontrado

- las líneas en las que aparece

Para ello se utiliza una tabla hash con encadenamiento (chaining) que permite almacenar múltiples identificadores incluso cuando ocurren colisiones.

La expresión regular utilizada para reconocer identificadores es:

[A-Za-z_][A-Za-z0-9_]*

## Compilación

Ingresar a la carpeta del ejercicio:
```
cd exercise3
```
Generar el scanner:
```
flex scanner.l
```
Compilar el programa:
```
gcc lex.yy.c -o crossref -lfl
```
Ejecutar el programa:
```
./crossref
```
Ejemplo de ejecución

Entrada:
```
int main() {
  int value = 1;
  value = value + 2;
}
```
<img width="325" height="261" alt="Captura de pantalla 2026-03-04 232121" src="https://github.com/user-attachments/assets/33bf0963-fda5-4eb4-bae6-87bf8b4fdd03" />

---

<img width="444" height="305" alt="Captura de pantalla 2026-03-04 231539" src="https://github.com/user-attachments/assets/9bfee325-8997-4a50-a797-fc66069909d0" />



