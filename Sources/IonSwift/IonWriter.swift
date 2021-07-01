//
//  File.swift
//  
//
//  Created by Darshil Agrawal on 01/07/21.
//

import Foundation

struct IONWriter{
    enum Error: Swift.Error {
        case invalidNumber(Double)
    }
    var ident = 0
    let pretty: Bool
    let sortedKeys: Bool
    let writer: (String?) -> Void
    
    init(pretty: Bool = false,sortedKeys: Bool = false,writer: @escaping (String?) -> Void){
        self.pretty = pretty
        self.sortedKeys = sortedKeys
        self.writer = writer
    }
    
    mutating func serialize(_ object: ION) throws {
        switch object {
        case .null:
            try serializeNull()
        case .string(let string):
            try serializeString(string)
        case .bool(let bool):
            writer(bool.description)
        case .number(let number):
            try serializeFloat(number.value)
        
        case .array(let array):
            try serializeArray(array)
        case .object(let dict):
            try serializeDictionary(dict)
        }
    }
    
    func serializeNull() throws {
        writer("null")
    }
    
    private func serializeFloat(_ str: String) throws {
        var str = str
        if str.hasSuffix(".0"){
            str.removeLast(2)
        }
        writer(str)
    }
    
    func serializeString(_ str: String) throws {
        writer("\"")
        for scalar in str.unicodeScalars{
            switch scalar{
            case "\"":
              writer("\\\"") // U+0022 quotation mark
            case "\\":
              writer("\\\\") // U+005C reverse solidus
            case "/":
              writer("\\/") // U+002F solidus
            case "\u{8}":
              writer("\\b") // U+0008 backspace
            case "\u{c}":
              writer("\\f") // U+000C form feed
            case "\n":
              writer("\\n") // U+000A line feed
            case "\r":
              writer("\\r") // U+000D carriage return
            case "\t":
              writer("\\t") // U+0009 tab
            case "\u{0}" ... "\u{f}":
                writer("\\u000\(String(scalar.value,radix: 16))") // U+0000 to U+000F
            case "\u{10}" ... "\u{1f}":
              writer("\\u00\(String(scalar.value, radix: 16))") // U+0010 to U+001F
            default:
              writer(String(scalar))
            }
        }
        writer("\"")
    }
    mutating func serializeArray(_ array: [ION]) throws {
        writer("Serializing array")
    }
    
    mutating func serializeDictionary(_ dict: [String: ION]) throws {
        writer("Serializing Dictionary")
    }
}
