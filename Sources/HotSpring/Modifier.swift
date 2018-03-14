
public final class RequestContext {
    
    var headers: [String : String]?
    var parameters: [String : Any]?
    
    init<T: Request>(_ request: T) {
        headers = request.headers
        parameters = request.parameters
    }
}

protocol Modifier {
    func modify(context: RequestContext)
}
