//
//  File.swift
//  
//
//  Created by Александра Рязанова on 19.02.2024.
//

import Foundation

/// Описание текста
public struct Text {
	/// Части текста
	public let text: [Part]
	
	/// Описание частей текста
	public enum Part {
		/// Нормальный текст
		case normal(text: String)
		
		/// Жирный текст
		case bold(text: String)
		
		/// Курсивный текст
		case italic(text: String)
		
		/// Жирный и курсивный
		case boldItalic(text: String)
		
		/// Встроенный код
		case inlineCode(text: String)
		
		/// Символы
		case escapedChar(char: String)
	}
	
	/// Инициализатор
	public init(text: [Part]) {
		self.text = text
	}
}

// MARK: - Equatable

extension Text: Equatable {}

extension Text.Part: Equatable {
	
	public static func == (lhs: Text.Part, rhs: Text.Part) -> Bool {
		switch (lhs, rhs) {
		case let (.normal(text1), .normal(text2)):
			return text1 == text2
		case let (.bold(text1), .bold(text2)):
			return text1 == text2
		case let (.italic(text1), .italic(text2)):
			return text1 == text2
		case let (.boldItalic(text1), .boldItalic(text2)):
			return text1 == text2
		case let (.inlineCode(text1), .inlineCode(text2)):
			return text1 == text2
		case let (.escapedChar(text1), .escapedChar(text2)):
			return text1 == text2
		default:
			return false
		}
	}
}
