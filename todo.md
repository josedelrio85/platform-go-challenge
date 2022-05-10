Digamos que en la plataforma GWI todos nuestros usuarios tienen acceso a una enorme lista de activos.

Queremos que nuestros usuarios tengan una lista peronal de favoritos, es decir, de activos que se han convertido en favoritos o en "estrellas" para que los tengan en su panel de control de la página principal para un acceso rápido.

Un activo puede ser uno de los siguientes:

- Gráfico (que tiene un pequeño título, títulos de ejes y datos)

- Insight (un pequeño texto que proporciona alguna información sobre un tema, por ejemplo, "El 40% de los millenials pasan más de 3 horas en las redes sociales al día")

- Audiencia (que es una serie de características, para este ejercicio vamos a centrarnos en:
  - el género (hombre, mujer), 
  - el país de nacimiento, 
  - los grupos de edad, 
  - las horas que pasan diariamente en los medios sociales, 
  - el número de compras del último mes), 
  - por ejemplo, hombres de 24 a 35 años que pasan más de 3 horas en los medios sociales diariamente.

Construir un servidor web que tenga algún endpoint para recibir un id de usuario y devolver una lista de todos los favoritos del usuario

También queremos endpoints que añadan un activo a los favoritos, lo eliminen o editen su descripción.

Los activos, obviamente, pueden compartir algunos atributos comunes (como su descripción), pero también tienen una estructura y datos completamente diferentes.

Depende de ti decidir la estructura y no estamos buscando algo excesivamente complejo aquí (especialmente para los casos de audiencias).

No hay necesidad de tener/desplegar/crear una base de datos real aunque nos gustaría discutir sobre las opciones de almacenamiento y las representaciones de los datos.

Tenga en cuenta que los usuarios no tienen límite en el número de activos que quieren en sus favoritos por lo que su servicio tendrá que proporcionar un tiempo de respuesta razonable.

Se requiere una aplicación de servidor que funcione con una API funcional, junto con un claro readme.md

También se valorará positivamente que las pruebas sean útiles y se superen.

Se agradece, aunque no es obligatorio, que se incluya un Dockerfile.

<!-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -->

- user => main entity

- activo (asset) => entity || candidate to interface ?? || 3 types => chart | insight | audience

- favourite or star => asset present in user favourite list => user must have a list of favourites

- user <=> favourite || 1:N || N >= 0

- endpoints:

  - get favourites from an user: [input] user id => [output] code + status + favourites list

  - add asset to user's favourite list: [input] user id, asset id + payload=> [output] code + status + description

  - remove asset from user's favourite list: [input] user id, asset id => [output] code + status + description

  - edit description from user's favourite list: [input] user id, asset id + payload => [output] code + status + description

DOMAIN LOGIC

- user:

  - get user's favourite list

  - add asset to user's favourite list

  - update asset description of an user favourite item

  - delete asset from the user favourite list

- storer:

  - user exist ? =>                       user.Exist(db)

  - retrieve favourites list =>           user.retrieveFavourites(db)

  - add asset to favourite list =>        user.addAssetToFavourites(db, asset)

  - update asset in favourite list =>     user.updateFavourite(db, asset)

  - remove asset from favourite list =>   user.removeFavourite(db, asset)


user {
  id
  Favourites List

  database ??? DI ??
}

AssetHandler interface {
  Push(user)
  Update(user)
  Pull(user)
}

graph {
  title
  axisTitle
  data
}

insight {
  description
}

audience {
  gender 
  birthCountry
  ageGroup
  dailyHoursSocialMedia
  purchasesLastMonth
}


<!-- -------------------------------------------- -->

endpoint retrieve favs

- get payload => user id (path | get)

- Transaction | check user existance + retrieve user-asset relation | commit-rollback transaction

- append results to user.favs

- return response


endpoint add asset to user favs

- get payload => user id + asset (path | post | payload (asset))

- Transaction | check user existance + store asset into storage + store user-asset relation | commit-rollback transaction

- return response


endpoint update fav in user list

- get payload => user id + asset (path | put | payload (asset))

- Transaction | check user existance + retrieve user's favs + check asset payload exists in user's favs + update asset | commit-rollback transaction

- return response


endpoint delete fav from user list

- get payload => user id + asset (path | delete)

- Transaction | check user existance + retrieve user's favs + check asset payload exists in user's favs + delet asset + delete user-asset relation | commit-rollback transaction

- return response
