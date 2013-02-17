Servidor RESTful para el PFC
============================

Creado por Daniel López usando [Sinatra](http://www.sinatrarb.com/).

Opciones disponibles:

* URL:
  * / => Muestra todos los productos de la tienda
  * /new/nombre => Añade un nuevo producto a la tienda
  * /new/nombre/X => Añade X nuevos productos a la tienda
* JSON:
  * /products => Muestra todos los productos de la tienda
  * /product/X => Muestra el producto con id X de la tienda