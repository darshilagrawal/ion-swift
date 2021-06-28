//
//  IONDecoder.swift
//  Amazon-ion
//
//  Created by Darshil Agrawal on 28/06/21.
//

import Foundation

final class IONDecoder: Decoder {
    let data: Data? = nil
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        fatalError()
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        fatalError()
    }
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        return KeyedDecodingContainer(KDC(data!))
    }
    
    struct KDC<key: CodingKey>: KeyedDecodingContainerProtocol{
        var codingPath: [CodingKey] = []
        var allKeys: [Key] = []
        let element: Data
        init(_ element: Data) {
            self.element = element
        }
        func contains(_ key: Key) -> Bool {
            return data.child(for: key) != nil
        }
        func child(for key: CodingKey) throws -> Data{
            guard let child = data.child(for: key) else{
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: codingPath, debugDescription: "Error"))
            }
        }
    }
    
    
    
}
