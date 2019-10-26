## Objetos S3

##  Guia elaborada con base a:

## Matloff, Norman S.The art of R programming : tour of statistical software design

## http://www.stat.umn.edu/geyer/3701/notes/generic.html

## https://adv-r.hadley.nz/s4.html


rm(list = ls())          #limpiar el ambiente global    

install.packages("sloop")#Instalar paquete
library(sloop)#Cargar paquete

# Los objetos S3 son utilizados en los paquetes base y estad�?sticos de R, además son los más utilizados en los paquetes CRAN.

# Cada elemento en R es un objeto. Sin embargo, existen los objetos base; los cuales provienen del lenguaje de programación S y los object-oriented (OO).

# La diferencia es que los objetos OO tienen un atributo "clase", se haya definido o no.

# Objeto base o "type base"
n <- 1:10
attr(n, "class")                #obtener atributos especificos del objeto, en este caso no teniendo ya que es un vector

otype(n)                       #objeto tipo base


# Objeto OO
attr(mtcars, "class")          #el atributo de "mtcars" es un data.frame

otype(mtcars)                  #objeto tipo S3


## Los objetos S3 no tienen una definición formal predefinida. Básicamente, una lista con su atributo "clase" establecido en algún nombre de clase, es un objeto S3. Los componentes de la lista se convierten en las variables miembro del objeto.

# Ejemplo objeto S3

ejemplo_S3 <- list()          #crear una lista 

ejemplo_S3$datos  <-  c(1,2,3)    #a�adimos los elementos de la lista

ejemplo_S3$conteo  <-  5          # $ se utiliza para asignar elementos nuevos al objeto S3


str(ejemplo_S3)               #evidenciar la estructura del objeto

typeof(ejemplo_S3)            #evidenciar el tipo de objeto

class(ejemplo_S3)             #evidenciar la clase del objeto 


# Establecemos la clase
class(ejemplo_S3)  <- "myClass"

class(ejemplo_S3)             #evidenciar el cambio de clase

otype(ejemplo_S3)             #evidenciar si se creo el objeto tipo S3


# Podemos crear el objeto y asignar la clase en un solo paso

# ejemplo_S3 <- structure(list(), class = "my_class")


# Otro ejemplo  

x <- c(1,2,3)

y<- c(1,3,8)

lmout <- lm(y ~ x)                  


str(lmout)

typeof(lmout)

class(lmout)

otype(lmout)


## Funciones genéricas  

# Todas las funciones genéricas tienen la misma estructura: una llamada a UseMethod que especifica el nombre genérico y el objeto para despachar. 

print

summary

# Creemos una función genérica
hola <- function(x,..){                 #estructura basica de una funcion generica
  UseMethod("hola",x)
}

## Métodos

# Cuando se usa una función genérica R redirige el llamado al método de clase adecuado, es decir, usa una función espec�?fica definida para la clase de ese objeto.


# Los objetos de cada clase se imprimen con un método espec�?fico a partir de la función genérica print.

class(x)
print(x)

class(lmout)
print(lmout)

# Revisemos todos los métodos de la función print
# Los asteriscos indican métodos no visibles.
methods(print)

# Los nombres de los métodos tienen el formato generic_name.class_name (). As�? es como R es capaz de determinar qué método llamar dependiendo de la clase.


class(ejemplo_S3)

# qué imprime ?
Print(ejemplo_S3)       # no imprime nada debido a que para este objeto "ejemplo_S3" print no esta definido


typeof(ejemplo_S3)


# creemos un método para print de la clase
print.myclass <- function(x){                   #funcion generica "print" para el objeto "ajemplo_S3" 
  cat (x$datos,"\n","estos son mis datos")
}

print(ejemplo_S3)                               #imprime los datos del objeto y su clase


# Ahora usemos la función "hola" en este objeto
# ¿qué sucede ?
hola(ejemplo_S3)


# Creemos un método de la función para la clase "myClass"
hola.myClass <- function(x,..){
  cat("me amo",x[conteo], "\n")
}

# Cuál es la salida?
hola(ejemplo_S3)


## Repaso de objeto S3

# Cada componente de la lista es una variable

j <- list(name="Joe", salary=55000, union=T)

# Definimos el atributo clase 
class(j) <- "employee"
class(j)

# Imprimamos el objeto j ¿qué estructura tiene?
print(j)

# Creemos el método "print" para la clase "employee" 
print.employee <- function(wrkr) {                 
  cat(wrkr$name,"\n")
  cat("salary",wrkr$salary,"\n")
  cat("union member",wrkr$union,"\n")
}

# Ahora, cualquier objeto de la clase "employee" sera impreso con el método print.employee
print(j)


## Herencia 

# Es cuando formamos nuevas clases como versiones especializadas de las antiguas

# La nueva clase hereda los métodos de la clase antigua

# Si la nueva clase no tiene métodos entonces toma los métodos la clase anterior


#creemos un objeto, paso a paso y definimos su clase "cosa"

test01  <- list()                          #creamos una nueva lista

test01$datos  <-  c(1,2,3)                  #a�adimos los elementos de la lista

test01$conteo  <-  5

test01$letras  <-  "This is ok"

class(test01)  <- "cosa"                    #asignamos la clase a la lista

class(test01)

str(test01)

typeof(test01)


# creamos el metodo para la clase
print.cosa <- function(x, ...){              #funcion print para la clase
  "1_ Si!!!!!!!!!!!!, lo logramos!!"
}

print(test01)

# la clase tambien puede ser un conjunto de caracteres
class(test01) <- c("cosa" ,"cosa1", "cosa2", "CCc")

class(test01)

# ¿ Qué debe pasar?
print(test01)                            #imprime el mismo argumento de la funcion

# creemos un método para la siguiente clase del conjunto
print.cosa1 <- function(x, ...){                 
  "2_ ni idea si lo logramos!!"
}

# ¿Qué pasa?
print(test01) 

class(test01)


# y si lo creamos asi ?
print.cosa.cosa1 <- function(x, ...){
  "3_ ni idea si esta vez si lo logramos!!"
}

print(test01)


rm(print.cosa)


print(test01)
