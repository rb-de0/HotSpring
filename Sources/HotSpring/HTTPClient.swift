
public protocol HTTPClient {
    
    func sendRequest<T: Request>(_ request: T, completionHandler: @escaping (RequestResult<T.Response>) -> ())
}
