//
//  File.swift
//  
//
//  Created by Darshil Agrawal on 29/06/21.
//

import Foundation
import PotentCodables

public enum ION{
    enum Error: Swift.Error{
        case unsupportedType
    }
    public struct Number: Equatable,Hashable,Codable{
        public let value: String
        public let isInteger: Bool
        public let isNegative: Bool
        
        public init(_ value: String,isInteger: Bool, isNegative: Bool){
            self.value = value
            self.isInteger = isInteger
            self.isNegative = isNegative
        }
        public init(_ value: String) {
          self.value = value
          isInteger = value.allSatisfy { $0.isNumber }
          isNegative = value.hasPrefix("-")
        }

        public init(_ value: Double) {
          self.value = value.description
          isInteger = false
          isNegative = value < 0
        }

        public init(_ value: Int) {
          self.value = value.description
          isInteger = true
          isNegative = value < 0
        }

        public var integerValue: Int? {
          guard isInteger else { return nil }
          return Int(value)
        }

        public var unsignedIntegerValue: UInt? {
          guard isInteger, !isNegative else { return nil }
          return UInt(value)
        }

        public var floatValue: Float? {
          return Float(value)
        }

        public var doubleValue: Double? {
          return Double(value)
        }

        public var numberValue: Any? {
          if isInteger {
            if isNegative {
              if MemoryLayout<Int>.size == 4 {
                return Int(value) ?? Int64(value) ?? Decimal(string: value)
              }
              return Int(value) ?? Decimal(string: value)
            }
            if MemoryLayout<Int>.size == 4 {
              return Int(value) ?? Int64(value) ?? UInt(value) ?? UInt64(value) ?? Decimal(string: value)
            }
            return Int(value) ?? UInt(value) ?? Decimal(string: value)
          }
          return Double(value) ?? Decimal(string: value)
        }
    }
    case null
    case string(String)
    case number(Number)
    case bool(Bool)
    
    public var isNull: Bool{
        if case .null = self{
            return true
        }
        return false
    }
    public var stringValue: String? {
      guard case .string(let value) = self else { return nil }
      return value
    }

    public var numberValue: Any? {
      guard case .number(let value) = self else { return nil }
      return value.numberValue
    }

    public var integerValue: Int? {
      guard case .number(let value) = self else { return nil }
      return value.integerValue
    }

    public var unsignedIntegerValue: UInt? {
      guard case .number(let value) = self else { return nil }
      return value.unsignedIntegerValue
    }

    public var floatValue: Float? {
      guard case .number(let value) = self else { return nil }
      return value.floatValue
    }

    public var doubleValue: Double? {
      guard case .number(let value) = self else { return nil }
      return value.doubleValue
    }

    public var boolValue: Bool? {
      guard case .bool(let value) = self else { return nil }
      return value
    }
}

extension ION: Equatable {}
extension ION: Hashable {}
extension ION: Value{
    public var unwrapped: Any? {
        switch self {
        case .null: return nil
        case .bool(let value): return value
        case .string(let value): return value
        case .number(let value): return value
        }
    }
}

extension ION: ExpressibleByNilLiteral,ExpressibleByBooleanLiteral,ExpressibleByStringLiteral,ExpressibleByIntegerLiteral,ExpressibleByFloatLiteral{
    public init(nilLiteral: ()) {
        self = .null
    }
    public init(booleanLiteral value: BooleanLiteralType) {
      self = .bool(value)
    }

    public init(stringLiteral value: StringLiteralType) {
      self = .string(value)
    }

    public init(integerLiteral value: IntegerLiteralType) {
      self = .number(Number(value.description))
    }

    public init(floatLiteral value: FloatLiteralType) {
      self = .number(Number(value.description))
    }
    
}

extension ION.Number: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral, ExpressibleByStringLiteral {

  public init(stringLiteral value: String) {
    self.init(value)
  }

  public init(floatLiteral value: Double) {
    self.init(value)
  }

  public init(integerLiteral value: Int) {
    self.init(value)
  }

}

public extension ION {

  typealias Encoder = IONEncoder
  typealias Decoder = IONDecoder

}
