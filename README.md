# ion-swift

A Swift implementation of [Amazon Ion](https://amzn.github.io/ion-docs/).

This repository was created for https://github-externships.github.io/externship/.

## Objective

What we’d like to do as part of this project is build a Swift implementation of Amazon Ion.

There are implementations in other languages that can be used as reference:

- [C](https://github.com/amzn/ion-c)
- [Go](https://github.com/amzn/ion-go)
- [Java](https://github.com/amzn/ion-java)
- [JavaScript](https://github.com/amzn/ion-js)
- [Python](https://github.com/amzn/ion-python)
- [.Net](https://github.com/amzn/ion-dotnet) 

The spec is documented [here](https://amzn.github.io/ion-docs/docs.html).

We need to support both the binary (this will come first) and text formats.

The expectation is to enusre that developers can use Swift’s Codable/Decodable to encode/decode to/from Ion.

Expected usage:

```swift
import Foundation
import Ion

struct S: Codable {
    var p: String
}

let s = S(p: "test")
let encoder = IonBinaryEncoder()
let encodedYAML = try encoder.encode(s)

let decoder = IonBinaryDecoder()
let decoded = try decoder.decode(S.self, from: encodedYAML)
s.p == decoded.p
```

```swift
import Foundation
import Ion

struct S: Codable {
    var p: String
}

let s = S(p: "test")
let encoder = IonTextEncoder()
let encodedYAML = try encoder.encode(s)

let decoder = IonTextDecoder()
let decoded = try decoder.decode(S.self, from: encodedYAML)
s.p == decoded.p
```

There is an excellent Swift implementation of Yaml called [Yams](https://github.com/jpsim/Yams). The idea is to bring a similar implementation to Ion.

## Approach

We will first need to setup automated tests using GitHub Actions to ensure we know when we become compliant. There is a [test suite](https://github.com/amzn/ion-tests). The project will be considered complete once the test suite passes.

Architecturally, we have 2 possible approaches to take:

### Option 1

The first (and preferred) option is to build a pure Swift implementation.

#### Advantages

- Memory safety
- No dependencies

#### Disadvantages

- We don't benefit from bug fixes and performance improvements made to the C implementation
- Will likely take longer to do than Option 2

### Option 2

The second option is to build a Swift API on top of the existing C implementation 

#### Advantages

- We don’t need to reimplement what the C library already does, hence is likely easier and quicker to do
- We can easily pick up bug fixes and performance improvements made to the C implementation

#### Disadvantages

- No memory safety
- Dependency on C implementation
