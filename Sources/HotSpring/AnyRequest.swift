import Foundation

final class AnyRequest<T: Request>: Request {
    
    typealias Response = T.Response
    
    let base: URL
    let path: String
    let method: HTTPMethod
    let headers: [String : String]?
    let parameters: [String : Any]?
    let encoding: ParameterEncoding
    let _decodeResponse: (Any) throws -> Response
    
    init(_ request: T, context: RequestContext) {
        base = request.base
        path = request.path
        method = request.method
        headers = context.headers
        parameters = context.parameters
        encoding = request.encoding
        _decodeResponse = request.decodeResponse
    }
    
    func decodeResponse(_ data: Any) throws -> Response {
        return try _decodeResponse(data)
    }
}
