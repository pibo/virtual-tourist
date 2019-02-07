# Virtual Tourist

O último app do Nanodegree da Udacity. Este app permite que o usuário marque uma localização no mapa e o app criará um álbum de fotos do local. As fotos serão baixadas para o iPhone e ficarão armazenadas até que o usuário as apague explicitamente. Os locais (pins) e posição do mapa também ficarão salvos. 

### Conceitos utilizados

No desenvolvimento deste app foram aprendidos os seguintes conceitos:

* Armazenamento de dados no `UserDefaults`
* Alteração da localização do mapa com `setRegion`
* Localização do usuário com `MKUserTrackingBarButtonItem` e `CLLocationManager().requestWhenInUseAuthorization`
* Notificações disparadas no life cycle do app, como `UIApplication.willTerminateNotification`
* Criação de um view controller estilo alert (para exibir o onboarding)
* Utilização de um `DataController` para acessar um `NSPersistentContainer`
* Criação de entidades do `Core Data`
* Gestos personalizados no `MapView`
* Geocode reverso com `CLGeocoder` para encontrar nome do local conforme coordenada
* Uso do `NSFetchedResultsController` e `NSFetchedResultsControllerDelegate` para separação de model/view
* Customização do `detailCalloutView` utilizando um `UIStackView` totalmente customizado

### Instalação

Basta clonar o repositório e abrir o arquivo de projeto `Virtual Tourist.xcodeproj`.

### Requisitos

O app foi desenvolvido com **Swift 4.2.1** e **Xcode 10.1**.
