public final class Executor {
    
    public final class Builder {
        
        private var _client: HTTPClient?
        private var _modifiers = [Modifier]()
        
        public init() {}
        
        public func addHTTPClient(_ client: HTTPClient) -> Self {
            _client = client
            return self
        }
        
        public func addModifier(_ modifier: Modifier) -> Self {
            _modifiers.append(modifier)
            return self
        }
        
        public func build() -> Executor {
            
            guard let client = _client else {
                fatalError("must be add http client.")
            }
            
            return Executor(client: client, modifiers: _modifiers)
        }
    }
    
    private let client: HTTPClient
    private let modifiers: [Modifier]
    
    init(client: HTTPClient, modifiers: [Modifier]) {
        self.client = client
        self.modifiers = modifiers
    }
    
    public func execute<T: Request>(_ request: T, completionHandler: @escaping (RequestResult<T.Response>) -> ()) {
        
        let context = RequestContext(request)
        modifiers.forEach {
            $0.modify(context: context)
        }
        
        let anyRequest = AnyRequest(request, context: context)
        
        client.sendRequest(anyRequest, completionHandler: completionHandler)
    }
}
