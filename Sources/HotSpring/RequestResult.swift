
public enum RequestResult<T> {
    
    case success(T)
    case error(Error)
    
    public var value: T? {
        switch self {
        case .success(let value):
            return value
        default:
            return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .error(let error):
            return error
        default:
            return nil
        }
    }
}
