
public enum HTTPMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case options = "OPTIONS"
    case put = "PUT"
    case delete = "DELETE"
    case trace = "TRACE"
    case patch = "PATCH"
    case connect = "CONNECT"
    
    public var bodyProvidable: Bool {
        
        switch self {
        case .get, .head, .delete:
            return false
            
        default:
            return true
        }
    }
}
