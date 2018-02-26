# iOS Large Project Architecture Definition

The following document describes the architecture defined by the Mobile Competence Center iOS Team to use in large projects. The document intends to describe each element of the architecture in a very simple way.

When developing an application it's very important to think about which are the available resources, how much time the team has in order to achieve the project's deadline, what's the general iOS architecture knowledge of the team, if it's a simple demo project or it's a long term app with many future updates... All these questions must be taken in account to decide which architecture apply.

There are many online resources discussing the use of one architecture amongst another one. The following link compares the main aspects of the *MVC, MVP, MVVM and VIPER*.

<https://medium.com/ios-os-x-development/ios-architecture-patterns-ecba4c38de52#.rxgetczcu>

It's important to note that each approach has its own advantages and caveats. Remember, choosing the proper architecture is always a very important step on any application development.

## Based on VIPER

After checking many architecture approaches on the net, the MCC decided to use a lighly modified version of VIPER architecture. This document doesn't fully describe the VIPER architecture so it's recommended to read about it on the net: 

* <https://www.ckl.io/blog/ios-project-architecture-using-viper/>
* <http://www.mttnow.com/blog/architecting-mobile-apps-with-bviper-modules>
* <https://swifting.io/blog/2016/03/07/8-viper-to-be-or-not-to-be/>
* <https://www.objc.io/issues/13-architecture/viper/>

The main reasons for choosing this architecture are:

* It covers the navigation responsibility (Routing). Other architecture approaches don't.
* It specifies the use of different entity layers (Entity).
* It follows the distribution of responsibilities in a very good way.
* It ensures very well the future scalability of large projects.
* Has a very good testability.
* Very easy to work with in teams, each team member can focus on each separated module avoiding future conflicts.

Of course, it also has some disadvantages:

* The need of writing a huge amount of interface for classes with very small responsibilities.
* The whole team needs to understand the architecture concepts very well.

VIPER has also some problems, majority of them come when digging into the implementation details. At first glance each architecture seems very well defined, but it's when the development starts the real problems appear. The following links contain some of these issues:

* <http://stackoverflow.com/questions/28995640/questions-about-viper-clean-architecture>
* <https://github.com/mutualmobile/VIPER-TODO/issues/4>

Choosing VIPER for a Project?

![ViperOrNot](https://gitlab.kazan.atosworldline.com/t21-ios-base-projects/architecture-definition/uploads/309fae92a82143f2148bdfdda7a77aa2/ViperOrNot.jpg)

## iOS MCC Large Project Architecture overview

The following diagram shows an entire overview of the defined architecture for **Large iOS Projects**.

Three main aspects of the diagram should be taken in account: 

**Left side**: Existence of three different **layers** in order to separate the responsabilities of the software.

**Middle part**: Different **classes** conforming each module and service provider classes.

**Right side**: Different **data objects** used to transport data through different layers.

![WL_iOS_-_Large_Project_Architecture__2_](https://gitlab.kazan.atosworldline.com/t21-ios-base-projects/architecture-definition/uploads/a5820fdae4aaa877c57a291103187dfa/WL_iOS_-_Large_Project_Architecture__2_.png)




### Layers

The defined architecture defines 3 different layers:

* **Presentation Layer**: the presentation layer is the responsible of presenting and updating all the UI to the user. It is also the responsible of managing the navigation, presenting and dismissing the different views when requested. Views, Presenters and Wireframes belong to this layer.
* **Business Layer (Domain Layer)**: the business logic layer, as it name states, holds all the business logic from the app. This layer will offer all the needed interfaces and methods to perform the different Use Cases defined. This layer is not aware of any UI part. Interactors and Workers belong to this layer. 
* **Data Layer**: the data layer holds all the services and resources that business logic layer may need in order to satisfy their use cases or business logic actions. As a consequence this data layer is very agnostic between projects. A data layer probably contains an HTTPRequester, a CoreDataStore, a RealmStore, a KeyChainStore classes... These services must be horizontal to Modules avoiding code duplication.

---

### Classes

##### Module Classes

VIPER relies on creating different modules to separate each screen or Use Case of the app (remember to check further VIPER documentation on the net). A fast description of each module according VIPER rules is: 

* **ViewController**: encapsulates the actual views, starting from view controllers.
* **Interactor**: encapsulates all the business logic and datasource access.
* **Presenter**: encapsulates the presentation logic.
* **Wireframe**: encapsulates the navigation logic.
* **Builder**: encapsulates the creation of its belonging entire module.

The **Builder** module part addition is based on this post [BVIPER architecture](http://www.mttnow.com/blog/architecting-mobile-apps-with-bviper-modules). The Builder decouples the module creation responsibility from the legacy Wireframe part.

There are some posts that suggest that each *Use Case* should be separated on one different module, but putting that in practice would lead to implement too many different modules in some cases. As iOS devs come from the MVC implicit native model, each **module** will be related to each different **View (ViewController)**, for example:

* LoginModule (related to a LoginViewController screen which contains one username/password form).
* PromotionsListModule (related to a PromotionsListViewController screen which holds a tableview of promotion cells).
* PromotionDetailModule (related to a PromotionDetailViewController screen which contains detailed info about a concrete promotion).
* ...

On the iOS platform navigation happens from UIViewController to UIViewController. It is foolish to fight against the framework, so a Module should be presenting itself to the outside world as a standard UIViewController.

![viper_modules](https://gitlab.kazan.atosworldline.com/t21-ios-base-projects/architecture-definition/uploads/4c6744df34e190b88c344ed6d617aa0d/viper_modules.png)

Each module with its own **View, Presenter, Interactor, Wireframe** and **Builder** classes. Also, the different Protocols **ViewModelHandler**, **EventHandler**, **ResponseHandler**, **RequestHandler** & **NavigationHandler** (when using a Protocol Oriented Programming approach).

![viper_vcs](https://gitlab.kazan.atosworldline.com/t21-ios-base-projects/architecture-definition/uploads/e4a883f42abf42c19e1844be76b2e88c/viper_vcs.png)

#### Memory ownership

It's very important to understand that the **View** class holds all the module classes regarding **memory** **ownership**. So if the View is deallocated, then all the module is deallocated as well (The builder class is an static factory class, so it's not instanced anywhere). With this approach, a module can be represented entirely by its View class.

The use of Protocol oriented programming between View, Presenter, Interactor and Wireframe "is optional". Of course, it's always better to decouple a concrete implementation from the interface, but omitting them in tight schedule projects could leverage the classes and protocols complexity.



###### Workers

In the diagram, some Worker classes appear. VIPER focuses very well on decoupling responsibilities but it lacks a bit on reusability. Workers fill this lack of reusability providing some static methods to perform **common business actions**. They also avoid code duplication and improve the team productivity. 

A simple example would be, an application which requests a list of Promotions (GetPromotions WebService) from more than one screen. That would lead to request this information from more than one Interactor and each Interactor would have to configure the WebService call and the corresponding NSURLRequest. If we add a Worker that provides an static method to perform this call, all this configuration stops being duplicated on each Interactor, and we reuse the same code. 

This approach should be used as much as possible trying to figure out which kind of Business Logic can be decoupled from the Interactors. Another clear example would be a Worker which offers some methods to query information from the DB (is the authorization token expired?, is the user logged in?). This kind of queries tend to be used in more than one place.

Another gap filled by the Workers are the special cases where some **Business Rules** or **Use Cases** are **not** related with any kind of **UI**. In these cases, creating BVIPER modules would lead to unused module parts. Instead, the Worker can accomplish the needed use cases in a very similar way the Interactor class does.

In order to facilitate the use of these Workers try to keep them as as simple **static classes** which offer a **set of static methods** (input > output, stateless). The main reason for this is to avoid having to inject the Workers during the creation of each module (that would lead to a more complex module creation scenario). If for any reason they need to store some kind of state info, the use of *in-memory CoreData or Realm stacks* approach could be used. Also *dependency injection frameworks like Typhoon* could be used.

###### Providers

The last type of classes is the **Resource Providers**. These classes belong to the **Data Layer** and they are responsible of retrieving the required Data from REST **APIs**, **DataBase** stacks or other sources. These classes are usually external dependencies.

Interactors and Workers use these classes to retrieve and send the data. Resource Provider classes must not know about the Business Logic of the app, neither services. They always **work** with **DTO's** objects, **not Domain Objects**. They should be ready to be used on other projects without any further modification, for example a generic HTTPRequester like the Alamofire framework (AFNetworking) pod.

---

### Data

VIPER also specifies different roles for the data holder classes. It defines that **Entities** must be used only in the Business Logic layer, not in the Presentation one. So at the very beginning VIPER applies a separation between the Business Logic Data and the UI/Presentation Data. This architecture adds a bit more, using three different data holder classes in order to decouple each layer properly.

* **View Model** objects are the ones used to keep an exact representation of the Presentation layer and UI. Storing the UI components values and also information about all the Views. In other architectures these objects have a big role, for example in the MVVM, where the binding between these objects and the UI View components ensures the View gets updated when the view model changes.
* **Entities** or **Business Objects** are the business logic model (also known as **Domain Model**) objects used to satisfy the different use cases of the app. Many VIPER sources specify that Entities must not be passed to the Presenter and they are only used by the Interactors (and Workers as well).
* **DTO** objects (depending of its source they can be named **DAO's** or **VO's** too) are used to represent information from the resource providers (DB stores and API related services). They don't contain any Use Case related information, only plain data which then will be translated to Entities (Domain Model). 
 
Yet the restrictions are true regarding which class should use each type of data holding class, the architecture needs some bridging classes to translate from one data model to another. For example, to translate from Domain Model to Presentation Model.

In this case the architecture should follow the *Clean Architecture* approach which defines that **Business Object** classes must be **mapped to View Model** classes in the **Presenter**. This conflicts directly with some statements of VIPER architecture like: *"Entities are only manipulated by the Interactor. The Interactor never passes entities to the presentation layer (i.e. Presenter)"*.

**The defined architecture doesn't respect this statement**, and leaves the translating process to the Presenter. It could be decoupled to a mapper class as well.

The following picture shows an example scenario where the Mapper is decoupled in a Presentation Model Builder class.

![translate_to_presentation_model](https://gitlab.kazan.atosworldline.com/t21-ios-base-projects/architecture-definition/uploads/2edc65b5f872c1c01b4952708d82056f/translate_to_presentation_model.png)

### Bridging between layers

VIPER layering allows for great decoupling, but the **way Modules should be built** and **communicate** is left to the designer.

It's important to understand that the **bridge between** the **Presentation Layer** and the **Business Layer** falls into the **Presenter class**. The Presenter receives the Business Objects from the Interactor (Domain Model) and translates them into View Models (Presentation Model).

* The View informs the Presenter on user interactions.
* The Presenter creates an immutable Presentation Model from Domain Model provided by the Interactor.
* The Presenter provides the View with the Presentation Model.

Also, **Data Layer** resource **provider** classes could be **reused** through **different** **projects**. For example, an HTTPRequester must not know about any specific webservice. It's only responsible of requesting resources to an API and returning the received response. The Business Layer as a Business Object or Interactor are the ones who configure each webservice call and send them through the HTTPRequester.

With the current memory ownserships described before, the root navigation controller (the majority of times a native UINavigationController) holds all the different modules, avoiding any complex ownerships which could lead to memory leaks in a future. 
