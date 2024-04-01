//
//  NullEncodable.swift
//  NetworkLayer
//
//  Created by Kirill Leonov
//

import Foundation

/// Структура для кодирование nil и его передачи в сетевых запросах
@propertyWrapper public struct NullEncodable<T>: Codable where T: Codable {

	// MARK: - Public properties

	/// Значение кодирование
	public var wrappedValue: T?

	// MARK: - Init

	public init(wrappedValue: T?) {
		self.wrappedValue = wrappedValue
	}

	// MARK: - Public methods

	/// Кодирование
	/// - Parameter encoder: Объект, который может кодировать значения в собственный формат для внешнего представления.
	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()

		switch wrappedValue {
		case .none:
			try container.encodeNil()
		case .some(let wrapped):
			try container.encode(wrapped)
		}
	}
}
