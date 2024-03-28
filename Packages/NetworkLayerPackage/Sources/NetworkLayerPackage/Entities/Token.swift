//
//  Token.swift
//  NetworkLayer
//
//  Created by Kirill Leonov 
//

/// Авторизационный токен.
public struct Token: MaskStringConvertible {
	/// Значение авторизационного токена
	public let rawValue: String
	
	public init(rawValue: String) {
		self.rawValue = rawValue
	}
}
