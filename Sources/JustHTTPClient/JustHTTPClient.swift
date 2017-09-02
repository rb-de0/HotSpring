import Foundation

import HotSpring
import Just

public final class JustHTTPClient: HTTPClient {
    
    public func sendRequest<T>(_ request: T, completionHandler: @escaping (RequestResult<T.Response>) -> ()) where T : Request {
        
        func handleResponse(_ response: Data?) throws -> T.Response {
            
            guard let responseData = response else {
                throw ResponseError.invalidResponseBody
            }
            
            return try request.decodeResponse(responseData)
        }
        
        let url = request.base.absoluteString + request.path
        let headers = request.headers ?? [:]
        let parameters = request.parameters ?? [:]
        
        guard let method = JustHTTPMethod(rawValue: request.method.rawValue) else {
            completionHandler(.error(RequestError.invalidMethod))
            return
        }
        
        let (json, data, params): (Any?, [String: Any], [String: Any])
        
        if request.method.bodyProvidable {
            
            params = [:]
            
            switch request.encoding {
            case .json:
                json = parameters
                data = [:]
            case .url:
                json = nil
                data = parameters
            }
            
        } else {
            params = parameters
            json = nil
            data = [:]
        }

        Just.request(
            method,
            url: url,
            params: params,
            data: data,
            json: json,
            headers: headers
        ) { r in
            
            do {
                let value = try handleResponse(r.content)
                completionHandler(.success(value))
            } catch {
                completionHandler(.error(error))
            }
        }
    }
}
