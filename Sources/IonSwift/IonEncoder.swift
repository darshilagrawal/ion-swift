//
//  File.swift
//  
//
//  Created by Darshil Agrawal on 29/06/21.
//

import Foundation
import PotentCodables

public class IONEncoder {
    public static let `default` = IONEncoder()

}

public struct IONEncoderTransform: InternalEncoderTransform,InternalValueSerializer,InternalValueStringifier{
    public static var emptyKeyedContainer = ION.object([:])
    
    public static var emptyUnkeyedContainer = ION.array([])
    
    public static func box(_ value: Float, encoder: InternalValueEncoder<ION, IONEncoderTransform>) throws -> ION {
        return .number(.init(value.description))
    }
    
    public static func box(_ value: Double, encoder: InternalValueEncoder<ION, IONEncoderTransform>) throws -> ION {
        return .number(.init(value.description))

    }
    
    public static func box(_ value: Decimal, encoder: InternalValueEncoder<ION, IONEncoderTransform>) throws -> ION {
        return .number(.init(value.description))

    }
    
    public static func box(_ value: Data, encoder: InternalValueEncoder<ION, IONEncoderTransform>) throws -> ION {
        return .number(.init(value.description))

    }
    
    public static func box(_ value: URL, encoder: InternalValueEncoder<ION, IONEncoderTransform>) throws -> ION {
        return .string(.init(value.absoluteString))

    }
    
    public static func box(_ value: UUID, encoder: InternalValueEncoder<ION, IONEncoderTransform>) throws -> ION {
        return .string(.init(value.uuidString))

    }
    
    public static func box(_ value: Date, encoder: InternalValueEncoder<ION, IONEncoderTransform>) throws -> ION {
        return .string(.init(value.description))
    }
    
    public static func unkeyedValuesToValue(_ values: [ION], encoder: InternalValueEncoder<ION, IONEncoderTransform>) throws -> ION {
        return .array(values)
    }
    
    public static func keyedValuesToValue(_ values: [String : ION], encoder: InternalValueEncoder<ION, IONEncoderTransform>) throws -> ION {
        return .object(values)
    }
    
    public static func data(from value: ION, options: Options) throws -> Data {
        var writingOptions: IONSerialization.WritingOptions = []
        return try IONSerialization.data(from: value, options: writingOptions)
    }
    
    public static func string(from value: ION, options: Options) throws -> String {
        var writingOptions: IONSerialization.WritingOptions = []

        return try IONSerialization.string(from: value, options: writingOptions)
    }
    
    
    public typealias Value = ION
    public typealias Encoder = InternalValueEncoder<Value, Self>
    public typealias State = Void

    public struct Options: InternalEncoderOptions{
        public var keyEncodingStrategy: KeyEncodingStrategy
        
        public var userInfo: [CodingUserInfoKey : Any]
        
        
    }
    public static func boxNil(encoder: Encoder) throws -> ION { return .null }
    public static func box(_ value: Bool, encoder: Encoder) throws -> ION { return .bool(value) }
    public static func box(_ value: Int, encoder: Encoder) throws -> ION { return .number(.init(value.description)) }
    public static func box(_ value: Int8, encoder: Encoder) throws -> ION { return .number(.init(value.description)) }
    public static func box(_ value: Int16, encoder: Encoder) throws -> ION { return .number(.init(value.description)) }
    public static func box(_ value: Int32, encoder: Encoder) throws -> ION { return .number(.init(value.description)) }
    public static func box(_ value: Int64, encoder: Encoder) throws -> ION { return .number(.init(value.description)) }
    public static func box(_ value: UInt, encoder: Encoder) throws -> ION { return .number(.init(value.description)) }
    public static func box(_ value: UInt8, encoder: Encoder) throws -> ION { return .number(.init(value.description)) }
    public static func box(_ value: UInt16, encoder: Encoder) throws -> ION { return .number(.init(value.description)) }
    public static func box(_ value: UInt32, encoder: Encoder) throws -> ION { return .number(.init(value.description)) }
    public static func box(_ value: UInt64, encoder: Encoder) throws -> ION { return .number(.init(value.description)) }
    public static func box(_ value: String, encoder: Encoder) throws -> ION { return .string(value) }
    
    
}
