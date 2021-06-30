//
//  Amazon_ion.swift
//  Amazon-ion
//
//  Created by Darshil Agrawal on 28/06/21.
//

import Foundation

public enum ION:Equatable,Hashable{
    case bool(Bool)
    case null
    case number(UInt8)
    case double(Float64)
    case utf8String(String)
    case boolean(Bool)
    public var isNull: Bool{
        if case .null = self {return true}
        return false
    }
    public var booleanValue: Bool?{
        if type == .bool
        return ()
    }
    
}


extension ION: ExpressibleByNilLiteral,ExpressibleByStringLiteral,ExpressibleByBooleanLiteral,ExpressibleByFloatLiteral{
    public init(nilLiteral: ()) {
        self = .null
    }
    public init(floatLiteral value: Double) {
        self = .double(value)
    }
    public init(stringLiteral value: String) {
        self = .utf8String(value)
        }
    public init(booleanLiteral value: Bool) {
        self = .boolean(value)
    }
}

extension ION: Value{

    public var unwrapped: Any? {
        switch self {
        case .null: return nil
        case .boolean(let value): return value
        case .utf8String(let value): return value
        case .double(let value): return value
        default: fatalError()
        }
    }

}

public extension ION {
    typealias Encoder = IONEncoder
    typealias Decoder = IONdecoder
}
