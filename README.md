**Description of App :**
User opens the app and is presented with a random image of a cat along with a random cat fact 
Each subsequent tap on the screen will generate a new random image and new cat fact 
**Tools**: Xcode 15.3 
**Language**: Swift 

**VIPER Architecture Information**

**View**: Handles UI and contains Layout constraints of image and Content
**Interactor**: Contains business logic like fetching image data from url and attaching to presenter 
**Presenter**: Mediates between the View and Interactor . Loading data from interactor protocol and we Will use in View.
**Entity** : Represents the data model class . We created model class using Struct and Decodable protocol. 
**Router**:  Navigates to ViewController and adding all the presenter, interaction, router, presenter to View


**API Information :** 
We are fetching the image and content from below API 
https://api.thecatapi.com/v1/images/search?limit=10
https://meowfacts.herokuapp.com/?id=3

**Screenshot **
![Simulator Screenshot - iPhone 15 Pro - 2024-11-04 at 21 13 11](https://github.com/user-attachments/assets/2b000f9b-2138-48d0-a124-78094369458c)
![Simulator Screenshot - iPhone 15 Pro - 2024-11-04 at 21 13 14](https://github.com/user-attachments/assets/f97720c5-2a66-4dd0-b313-dbfcb69e4dfd)

**TestCases **
<img width="862" alt="Screenshot 2024-11-04 at 9 19 20 PM" src="https://github.com/user-attachments/assets/7f22e8ae-d17f-40dc-ae1e-8adb9e1bf99a">

**Classes** 
RandomImageView
**RandomImageInteractor**
protocol RandomImageInteractorProtocol: AnyObject {
    func fetchRandomContent()
}
fetchRandomImage()
fetchRandomFact()
**RandomImagePresenter**
protocol RandomImageInteractorOutputProtocol: AnyObject {
    func didFetchRandomImage(_ image: ImageModel)
    func didFetchRandomFact(_ fact: CatFactResponse)
}
**ImageModel**
struct ImageModel: Decodable {
    let id: String
    let url: String
    let width: Int
    let height: Int
}

struct CatFactResponse: Codable {
    let data: [String]
}

**RandomImageRouter**
Creates Viewe and Navigates to ViewController and binding all the Presenter, Entity(Model), Interactor
