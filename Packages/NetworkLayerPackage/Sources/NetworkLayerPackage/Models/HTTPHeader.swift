//
//  HTTPHeader.swift
//  NetworkLayer
//
//  Created by Kirill Leonov 
//

import Foundation

public typealias HTTPHeader = [String: String]

/// Поля HTTP-заголовка. Содержит список часто используемых полей заголовка для устранения хардкода и избежания ошибок
/// написания полей.
public enum HeaderField {
	/// Авторизация, содержит токен и используется для OAuth2 авторизации
	case authorization(Token)
	/// Тип контента, содержит тип к
	case contentType(ContentType)
	case contentDisposition(ContentDisposition)

	/// Название ключа заголовка.
	public var key: String {
		switch self {
		case .authorization:
			return "Authorization"
		case .contentType:
			return "Content-Type"
		case .contentDisposition:
			return "Content-Disposition"
		}
	}

	/// Значение поля заголовка.
	public var value: String {
		switch self {
		case .authorization(let token):
			return "Bearer \(token.rawValue)"
		case .contentType(let contentType):
			return contentType.value
		case .contentDisposition(let contentDisposition):
			return contentDisposition.value
		}
	}
}
