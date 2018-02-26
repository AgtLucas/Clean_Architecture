## WebService 

A **WebService** implements two **protocols**:

- **TargetType**
- **TargetTypeMapping**

And his **implementation** is: 

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
