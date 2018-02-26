# iOS WORLDLINE ARCHITECTURE

**Architecture** 
![alt text][architecture]

[architecture]: /Users/jonattan/Desktop/architecture.png "Architecture Diagram"

# Fetch data from external DataSource
## Interactor > Repository > Provider > DataSource

## Interactor

Contains the business logic.

The **Interactor** uses some **Repository** in order to make a **transaction** to:

* Get data from a **Provider**
* Set data to a **Provider**.

### Entity Concept

**Entities** are the model objects manipulated by an **Interactor**. **Entities** are only manipulated by the Interactor. The Interactor never passes entities to the presentation layer (i.e. Presenter).

Entities also tend to be PONSOs. If you are using Core Data, you will want your managed objects to remain behind your data layer. Interactors should not work with NSManagedObjects.

**Add info about implementation with RealmObjects or NSManagedObjects


### Transaction concept

A **transaction** is the action sended from the **Interactor** to the **Repository** related to an **Entity data** that is wanted to fetch or send to the **external DataSource**.

It can be the **business representation** of a network **Service**, a **Query** from a DDBB, or another kind of request of an object from some source of data. 

In other words, a **transaction** is the **entity** info we want to fetch from an **external DataSource**, and it will be recieved as a **Data Transfer Object**.

Transactions are methods of the Repository class, named with the prefix:
- **Request**, for a Network transaction
- **Query**, for a DDBB transaction


### How to fetch or send the Data?
As we can see at the diagram, the **Repository** recieves and send **Data Transfer Objects**, so for a transaction:

* We must define a **WebService** called **TransactionRequestDTO** that englobes the multiple DTO options for when we request it, because it inherits from the WebService Class, wich implements the Moya protocols and our own protocols (**TargetType**, **Target**) 
* We must define a **Enum** called **TransactionResponseDTO** for when we send a DTO.

So, for example, if we need to request a Target from an API, we create an **TransactionResponseDTO Enum** wich contains two posible values:

* **TargetDTO class**
* **TargetFailDTO class**

```swift
enum  AccessTokenResponseDTO {
    case success(accessTokenDTO: AccessTokenDTO)
    case fail(accesTokenFailDTO: AccesTokenFailDTO)
}
```
## WebService 

A **WebService** implements two **protocols**:

- **TargetType**
- **TargetTypeMapping**

**And his implementation is: **

```swift
public class WebService <ResponseClassType> : TargetType, TargetTypeMapping {

    public var baseURL: URL { return URL(string: "https://swapi.co/api")! }

    public var path: String {
        return ""
    }

    public var method: Moya.Method {
        return .get
    }

    public var parameters: [String: Any]? {
        return nil
    }

    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    public var sampleData: Data {
        return "Sample data".utf8Encoded
    }

    public var task: Task {
        return .request
    }

    public var mapping: Mapping<HTTPRequesterResult<Moya.Response, MoyaError>, ResponseClassType> {
        //BaseService mapping is not valid, overwrite it.
        return Mapping({ _ in return ("" as! ResponseClassType) })
    }

}
```


### How to handle the responseDTO recieved?

When the **Interactor** calls to the **Repository** in order to make a **transaction** related to a **Target**:

* Indicate a **handleTargetResponseDTO** **closure** in order to **map** the ** TargetResponseDTO Enum** recieved to the correct **Entity**

That's because the **Interactor** is who knows how to **add business logic** to this kind of **mapping**.

```swift
//Interactor request
func requestTarget(parameter: Any) {
        self.targetRepository.executeTargetTransaction(parameter: Any, handleTargetResponseDTO: 
        {(targetResponseDTO) in
            switch(targetResponseDTO){
            
            case let .success(targetDTO: TargetDTO):
                //Create the Entity from DTO adding business logic.
    
            case let .fail(targetFailDTO: TargetFailDTO):
                break
            }
        }
    }
```
The **switch** at this closure must map the **different cases** of a **targetDTO** recieved **in order to create the correct Entity**.

So let's see what is going to do the **Repository** with the **request target transaction** from the **Interactor**.

## Repository


A **Repository** implements the protocol that allows **transactions** related to a **Target**, named *__TargetTransactionsHandler__*.

```swift
protocol TargetTransactionsHandler {
    func fetchTargetSending(someParameter: Any, handleAccessTokenResponseDTO: @escaping (AccessTokenResponseDTO) -> () )
}
```


The repository is the class beetwen the Interactor and the the Provider.


The **Repository** uses the **Provider** framework methods in order to fetch data from the **DataSource**.

### Network Case

In order to do a **providerRequest** to fetch some data from the Network External Data Source, we must declare:



* An object called **TargetRequestDTO** sended to the **Provider**, wich includes all the data to create a RequestObject in the form requiered from the Provider implementation ( For example a URLRequest ) and a Mapping.

This object is a WebService Object

* The object called **TargetResponseDTO** that we expect to recieve like a Response from the Provider.


```swift
func requestDoLogin( _ userName: String, _ password: String, _ completion: @escaping (_ response : GetLoginResponseDTO) -> ()) {
        let provider = SharedContainer().resolve(HTTPProvider.self)!
        provider.request(GetLoginRequestDTO(userName,password),{ (response : GetLoginResponseDTO) in
            completion(response)
        })
    }
```


See the **TargetRequestDTO** implementation at the **Sample Project** for more info.

The only think you need to know is that **TargetRequestDTO** implements the protocols **TargetType** & **TargetTypeMapping**, and that allows the **TargetRequestDTO** to apply the Mapping to the External Data Source data receiver ( like Bytes, or a JSON, or something like that ) in order to get a **TargetResponseDTO** object.

## Provider

The **Provider** is the abstraction of the DataSource Framework with the especifications of our App, so we configure our provider in order to make requests to the diferent external dataSources.

We can have different Providers for the different DataSources, like DDBB or Network.

The implementation of our Provider for a Network is the **T21HTTPRequester**. You must configure your own Provider using the inherit from the T21HTTPRequester, configuring it with the App 











