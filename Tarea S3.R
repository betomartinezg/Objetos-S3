#######################################
#####     TAREA DE S3     ############
#######################################


# ejercicio 1.1 Cree un objeto de clase "Ropa" cuyos componentes sean precio y prenda.

ejercicio_01<- list()                                     ####se creo una lista vacia
ejercicio_01$precio<-c (25000, 10000 ,15000)               #### se crea dos vectores concatenando el respectivo contenido de la lista, para asignar los componentes
ejercicio_01$prenda<-c("chaqueta","pantalon","guantes")
class(ejercicio_01)<-"ropa"                                 #### se le asigna la clase a la lista para obtener finalmente un objeto de clase
str(ejercicio_01)

# ejercicio 1.2 cree una funci贸n generica para la clase "Ropa" y un m茅todo que imprima la prenda y su precio.


ropa_surtida<-function(x,...){                                #### se creo una funcion donde se pegara el precio de la respectiva prenda de vestir
  paste(ejercicio_01$precio, ejercicio_01$prenda)
}

ropa_surtida()                                            #### al correr la funci髇 obtendremos el valor de cada prenda establecido en el objeto de clase


# ejercicio 1.3 cree un print para la clase "Ropa" que muestre la suma del valor de todas las prendas.

print.ropa<-function(ropa){                                 #####se  creo un print donde se sumaran el precio de cada prenda al ejecutar en comando print
  cat(sum(ropa$precio),"\n")}

print(ejercicio_01)


# ejercicio 2.1 Cree un objeto de clase "Baraja" cuyos componentes sean n煤mero y simbolo. Seg煤n la baraja espa帽ola de 40 cartas https://es.wikipedia.org/wiki/Baraja_espa%C3%B1ola#/media/Archivo:Baraja_de_40_cartas.png

ejercicio_02<- list()                                       ####se creo una lista vacia
ejercicio_02$numero<-c (1:40)                                #### se creo los contenidos de las listas o por ende los componentes del objeto clase
ejercicio_02$simbolo<-c("moneda", "espada", "copa", "tronco")
class(ejercicio_02)<- "Baraja"                                ####finalmente la lista se convierte en un objeto clase
str(ejercicio_02)


# ejercicio 2.2 Cree un print que para la clase "Baraja" donde se muestre una descripci贸n breve del objeto y 3 reglas de juego de cualquier variante de la baraja espa帽ola, puede guiarse de http://www.juntadeandalucia.es/averroes/centros-tic/18700441/myscrapbook/bookcontents.php?page=8&section=7&viewis=&username=

print.Baraja<-function(descripcion){                             #####se creo una funci髇 print de la clase baraja que permitiera pegar los caracteres requeridos                        
  paste("La baraja espa駉la puede ser de 40 naipes",
        "el mentiroso: El n鷐ero de participantes es preferible que sea de al menos
           tres jugadores" , "el mentiroso:se reparte toda la baraja por igual a todos
           los jugadores" , "el presidente: se puede jugar a partir de 3", sep = "," )}

print.Baraja(ejercicio_02)                                 #### al ejecutar el comando obtendremos el contenido de la funcion 

# ejercicio 2.3 cree una funci贸n generica para la clase "Baraja" que sirva de manera al azar (uniforme sin reemplazo) 9 cartas y se las asigne a un objeto jugador.

azar<-function(Baraja){                                    ####se creo una funci髇 donde se tomara el tama駉 especificado de elementos (9 cartas) uniformemente sin reemplazo
  sample(1:40,9,FALSE)}

azar()

jugador<-c()                                               ####se creo un objeto llamado jugador


print.Baraja<-function(jugador) {                           #### creamos el metodo "print" para la clase baraja donde nos permitiera imprimir y pegar los valores de la funcion azar
  print(paste(azar(jugador)))
}

jugador<-print.Baraja()                                      #### el print creado se le asigno al objeto jugador


# ejercicio 3. Dado lo siguiente, explique y argumente (con evidencia resultante de diferentes comandos) por qu茅 modificar el objeto "bubba" afecta a "louise" y viceversa? Recuerde comentar el c贸digo que use como argumento.

NordAmericain <- function(eatsBreakfast = TRUE, myFavorite = "cereal") {
  thisEnv <- environment()
  hasBreakfast <- eatsBreakfast
  favoriteBreakfast <- myFavorite
  me <- list(
    thisEnv = thisEnv,
    getEnv = function() {
      return(get("thisEnv", thisEnv))
    }
  )
  assign('this', me, envir = thisEnv)
  class(me) <- append(class(me), "NordAmericain")
  return(me)
}


bubba <- NordAmericain()                               ####al objeto bubba se le asigno inicialmente la funcion NordAmericain()                           
bubba
bubba <- NordAmericain(myFavorite="oatmeal")           #####luego se le asigna a bubba "oatmeal" como argumento
bubba
get("favoriteBreakfast", bubba$getEnv())

ls()                                                    ##### estando hasta el momento en el ambiente global la funci髇 y el objeto bubba     
louise <- bubba                                         ##### luego se es asignado al objeto louise los elementos de bubba
assign("favoriteBreakfast", "toast", louise$getEnv())    ##### se le asigna un nuevo elemento a louise
get("favoriteBreakfast", louise$getEnv())                 #### al obtener el "favoriteBreakfast" de ambos objetos se obtiene el mismo elemento "toast"
get("favoriteBreakfast", bubba$getEnv())
ls()                                                      ##### inicialmente podemos observar que bubba y louise se encuentran en el ambiente global
str(bubba)                                                 #### al observar la estructura de bubba y louise se evidencia que estan asignados en el mismo ambiente "environment: 0x00000227bab25308", 
str(louise)                                                 #### ademas presentan la misma estructura y por ende atributos, por ello al modificar cualquiera de los dos objetos estos se veran seran afectados
