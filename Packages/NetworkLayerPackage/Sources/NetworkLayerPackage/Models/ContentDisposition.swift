//
//  ContentDisposition.swift
//  
//
//  Created by Александра Рязанова on 29.03.2024.
//

import Foundation

/// Тип как обрабатывать контект
public enum ContentDisposition {
	/// Multi part данные.
	case multipart(name: String, filename: String)
	
	/// Возвращает значение типа расположения для передачи в HTTP заголовке.
	public var value: String {
		switch self {
		case .multipart(let name, let filename):
			return "form-data; name=\"\(name)\"; filename=\"\(filename)\""
		}
	}
}
