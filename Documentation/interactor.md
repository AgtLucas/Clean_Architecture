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

In other words, a ** transaction** is the **entity** info we want to fetch from an **external DataSource**, and it will be recieved as a **Data Transfer Object**.

Transactions are methods of the Repository class, named with the prefix:
- **Request**, for a Network transaction
- **Query**, for a DDBB transaction