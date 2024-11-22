UALA CHALLENGE
NAME: Romel Dudikoff Idme Calderon

-Español:

PARA INSTALAR EL APP, SOLO NECESITAS CLONAR EL REPOSITORIO EN UN XCODE 16.1 O SUPERIOR, Y BUILDEARLO, NO DEBERIA HABER PROBLEMAS DE BUILD YA QUE NO UTILIZO NINGUNA LIBRERIA DE TERCEROS(EJEMPLO - COCOA PODS)

UI:
Para este reto tecnico primero tome en cuenta la tecnologia de UI, la cual se escogio SwiftUI asi que utilize Componentes de esa tecnologia como GeometryReader para manejar las condiciones de las vistas ,Horizontal(para ubicar el MapView en un costado) y vertical(para pushear al mapView)

Arquitectura:
Utilize MVVM ya que funciona muy bien con SwiftUI para las llamadas asincronas y demas bondades

Utilize CoreData para la persistencia de datos ya que se necesita setear los items Favoritos incluso cuando se cierre el app creando un entity (CoreModel) para setear los datos iba llamando mediante una paginacion

Utilize URLSession para hacer la llamada al gist y poder sacar los datos necesarios (de 50 en 50) ya que utiliza paginacion por que los archivos son mas de 200k items, esto ocuparia un acoplamiento en la app y el celular llegaria a maxima capacidad de procesamiento

Para el filtro, utilize HasPrefix el cual ayudara a tomar las primeras letras para buscar las ciudades y no solo un contains (eso aplicaria el filtro de otras maneras)

Finalmente intente seguir una arquitectura normal y escalable como por ejemplo agregarle clean arquitecture, etc para seguir mejorando la modularidad.

ENGLISH:
To install the app, you just need to clone the repository in Xcode 16.1 or higher, and build it. There should be no build issues as I do not use any third-party libraries (e.g., CocoaPods).

UI: For this technical challenge, I first took into account the UI technology, which was chosen as SwiftUI. I used components from this technology, such as GeometryReader, to manage the view conditions—Horizontal (to position the MapView on the side) and Vertical (to push the MapView).

Architecture: I used MVVM because it works very well with SwiftUI for asynchronous calls and other benefits.

I used CoreData for data persistence, as it was necessary to set Favorite items even when the app is closed. I created an entity (CoreModel) to set the data, which was called via pagination.

I used URLSession to make the call to the gist and fetch the necessary data (50 items at a time) because it uses pagination, as the files contain over 200,000 items. This would create tight coupling in the app, and the phone would reach its processing limit.

For the filter, I used HasPrefix, which helps to get the first few letters to search for cities, rather than just using contains (which would apply the filter in other ways).

Finally, I tried to follow a standard, scalable architecture, such as adding Clean Architecture, to keep improving modularity.
