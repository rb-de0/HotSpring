import XCTest
@testable import HotSpring
@testable import JustHTTPClient

let timeout = 10.0

class JustHTTPClientTests: XCTestCase {
    
    private enum TestError: Error {
        case invalidResponse
        case invalidResponseStructure
    }
    
    private struct TestRequest: Request {
        
        var base: URL
        var path: String
        var method: HTTPMethod
        var parameters: [String : Any]?
        var headers: [String : String]?
        var encoding: ParameterEncoding
        
        init(base: URL, path: String, method: HTTPMethod, parameters: [String: Any]? = nil, headers: [String : String]? = nil, encoding: ParameterEncoding = .json) {
            self.base = base
            self.path = path
            self.method = method
            self.parameters = parameters
            self.headers = headers
            self.encoding = encoding
        }
        
        var client: HTTPClient {
            return JustHTTPClient()
        }
        
        func decodeResponse(_ data: Any) throws -> [String: Any] {

            guard let data = data as? Data else {
                throw TestError.invalidResponse
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                let dic = json as? [String: Any] else {
                    
                throw TestError.invalidResponseStructure
            }

            return dic
        }
    }
    
    // MARK: - Tests
    
    static var allTests = [
        ("testExample", testBasicResponse),
        ("testQueryParameter", testQueryParameter),
        ("testQueryParameters", testQueryParameters),
        ("testJSONBody", testJSONBody),
        ("testFormBody", testFormBody)
    ]
    
    func testBasicResponse() {
        
        let expectation = self.expectation(description: #function)
        let base = URL(string: "https://httpbin.org/get")!
        
        var response: [String: Any]?
        
        TestRequest(base: base, path: "", method: .get, parameters: nil, headers: nil).send { result in
            response = result.value
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
        
        XCTAssertEqual(response?["url"] as? String, "https://httpbin.org/get")
    }
    
    func testQueryParameter() {
        
        let expectation = self.expectation(description: #function)
        let base = URL(string: "https://httpbin.org/get?value=10")!
        
        var response: [String: Any]?
        
        TestRequest(base: base, path: "", method: .get, parameters: nil, headers: nil).send { result in
            response = result.value
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
        
        XCTAssertEqual((response?["args"] as? [String: Any])?["value"] as? String, "10")
    }
    
    func testQueryParameters() {
        
        let expectation = self.expectation(description: #function)
        let base = URL(string: "https://httpbin.org/get?offset=1")!
        
        var response: [String: Any]?
        
        TestRequest(base: base, path: "", method: .get, parameters: ["limit": 20], headers: nil).send { result in
            response = result.value
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
        
        XCTAssertNil((response?["args"] as? [String: Any])?["offset"])
        XCTAssertEqual((response?["args"] as? [String: Any])?["limit"] as? String, "20")
    }
    
    func testJSONBody() {
        
        let expectation = self.expectation(description: #function)
        let base = URL(string: "https://httpbin.org/post")!
        
        var response: [String: Any]?
        
        TestRequest(base: base, path: "", method: .post, parameters: ["value": 10], headers: nil).send { result in
            response = result.value
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: timeout, handler: nil)

        XCTAssertEqual((response?["json"] as? [String: Any])?["value"] as? Int, 10)
        XCTAssertEqual((response?["headers"] as? [String: Any])?["Content-Type"] as? String, "application/json")
    }
    
    func testFormBody() {
        
        let expectation = self.expectation(description: #function)
        let base = URL(string: "https://httpbin.org/post")!
        
        var response: [String: Any]?
        
        TestRequest(base: base, path: "", method: .post, parameters: ["value": 10], headers: nil, encoding: .url).send { result in
            response = result.value
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
        
        XCTAssertEqual((response?["form"] as? [String: Any])?["value"] as? String, "10")
        XCTAssertEqual((response?["headers"] as? [String: Any])?["Content-Type"] as? String, "application/x-www-form-urlencoded")
    }
}
