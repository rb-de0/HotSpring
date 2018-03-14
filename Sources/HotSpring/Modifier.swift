
public final class RequestContext {
    
    var headers: [String : String]?
    var parameters: [String : Any]?
    
    init<T: Request>(_ request: T) {
        headers = request.headers
        parameters = request.parameters
    }
}

public protocol Modifier {
    func modify(context: RequestContext)
}
