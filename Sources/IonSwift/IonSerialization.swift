//
//  File.swift
//  
//
//  Created by Darshil Agrawal on 01/07/21.
//

import Foundation

public struct IONSerialization{
    
    public enum Error: Swift.Error{
        case fragmentDisallowed
        case noValue
    }
    
    public struct ReadingOptions: OptionSet{
        public let rawValue: UInt
        
        public init(rawValue: UInt) {
            self.rawValue = rawValue
        }
        public static let allowFragments = ReadingOptions(rawValue: 1 << 0)
    }
    
    public struct WritingOptions: OptionSet {
        public let rawValue: UInt
        public init(rawValue: UInt) {
            self.rawValue = rawValue
        }
        public static let sortedKeys = WritingOptions(rawValue: 1 << 0)
        public static let prettyPrinted = WritingOptions(rawValue: 1 << 1)
    }
    public static func data(from ion: ION,options: WritingOptions = []) throws -> Data {
        return try string(from: ion,options: options).data(using: .utf8)!
    }
    public static func string(from ion: ION,options: WritingOptions = []) throws -> String{
        var output = String()
        var writer = IONWriter(pretty: options.contains(.prettyPrinted), sortedKeys: options.contains(.sortedKeys)) {
            guard let str = $0 else { return }
            output.append(str)
        }
        try writer.serialize(ion)
        
        return output
    }
    
    private init() {}
}
