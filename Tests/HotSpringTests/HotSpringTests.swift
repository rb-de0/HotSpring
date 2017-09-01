import XCTest
@testable import HotSpring
@testable import JustHTTPClient

class HotSpringTests: XCTestCase {
    
    struct TestRequest: Request {
        
        var base: URL {
            return URL(string: "https://httpbin.org/get")!
        }
        
        var path: String {
            return ""
        }
        
        var method: HTTPMethod {
            return .get
        }
        
        var client: HTTPClient {
            return JustHTTPClient()
        }
        
        func decodeResponse(_ data: Any) throws -> String {
            return ""
        }
    }
    
    func testExample() {
        
        let expectation = self.expectation(description: #function)
        
        TestRequest().send { _ in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
