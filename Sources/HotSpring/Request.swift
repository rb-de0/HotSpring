import Foundation

public protocol Request {
    
    associatedtype Response
    
    var base: URL { get }
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var encoding: ParameterEncoding? { get }
    
    var client: HTTPClient { get }
    
    func decodeResponse(_ data: Any) throws -> Response
}

// MARK: - Default Implementation
public extension Request {
    
    var headers: [String: String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var encoding: ParameterEncoding? {
        return nil
    }
}
