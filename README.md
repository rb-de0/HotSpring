# HotSpring


[![apm](https://img.shields.io/apm/l/vim-mode.svg)]()
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![Build Status](https://travis-ci.org/rb-de0/Fluxer.svg?branch=master)](https://travis-ci.org/rb-de0/HotSpring)


A simple http client interface for Swift.
HotSpring also works on Linux.

## Requirements

### Swift

- Swift 4.0.3

### macOS

- macOS Sierra 10.12.2

### Linux

- Ubuntu 14.04 Trusty（test passed）

## Installation

Add the following to your dependencies in Package.swift.

### Swift Package Manager v3


```Swift
.Package(url: "https://github.com/rb-de0/HotSpring.git", majorVersion: 0)
```

### Swift Package Manager v4


```Swift
.package(url: "https://github.com/rb-de0/HotSpring.git", from: "0.3.0")
```

## Usage

HotSpring is just a package that provides an interface for HTTP requests. 
HTTP clients are not implemented in HotSpring, but we implemented an HTTP client using Just as a sample. Therefore, you can use JustHTTPClient.

The following is a sample.

```Swift
import HotSpring
import JustHTTPClient

enum SampleError: Error {
    case invalidResponse
}

struct SampleRequest: Request {
    
    let base = URL(string: "https://httpbin.org/get")!
    let path = ""
    let method = HTTPMethod.get
    
    func decodeResponse(_ data: Any) throws -> Data {
        
        guard let data = data as? Data else {
            throw SampleError.invalidResponse
        }
        
        return data
    }
}

let executor = Executor.Builder().addHTTPClient(JustHTTPClient()).build()
executor.execute(request) {
    print($0.value, $0.error)
}


```

## License

HotSpring is released under the MIT License. See the LICENSE file for more info.