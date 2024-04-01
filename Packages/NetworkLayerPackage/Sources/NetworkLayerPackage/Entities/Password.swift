//
//  Password.swift
//  NetworkLayer
//
//  Created by Kirill Leonov 
//

/// Пароль пользователя.
public struct Password: MaskStringConvertible {
	/// Значение пароля.
	public let rawValue: String
	
	public init(rawValue: String) {
		self.rawValue = rawValue
	}
}
