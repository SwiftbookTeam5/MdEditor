//
//  Token.swift
//  MarkdownToHtml
//
//  Created by Kirill Leonov on 13.02.2024.
//

import Foundation

// MARK: - Token

/// Токен для синтасического анализа
public enum Token {
	/// Заголовок
	case header(level: Int, text: Text)

	/// Цитата
	case blockquote(level: Int, text: Text)

	/// Блок кода
	case codeBlockMarker(level: Int, lang: String)

	/// Строка кода
	case codeLine(text: String)

	/// Элемент неупорядоченного списка
	case unorderedListItem(text: Text)

	/// Элемент упорядоченного списка
	case orderedListItem(text: Text)

	/// Строки
	case textLine(text: Text)

	/// Ссылка
	case link(url: String, text: String)

	/// Картинка
	case image(url: String, size: Int)

	/// Перевод строки
	case lineBreak
	
	/// Горизонтальная линия
	case horizontalLine
}

// MARK: - Equatable

extension Token: Equatable {

	public static func == (lhs: Token, rhs: Token) -> Bool {
		switch (lhs, rhs) {
		case let (.header(level1, text1), .header(level2, text2)):
			return level1 == level2 && text1 == text2
		case let (.blockquote(level1, text1), .blockquote(level2, text2)):
			return level1 == level2 && text1 == text2
		case let (.codeBlockMarker(level1, lang1), .codeBlockMarker(level2, lang2)):
			return level1 == level2 && lang1 == lang2
		case let (.codeLine(text1), .codeLine(text2)):
			return text1 == text2
		case let (.unorderedListItem(text1), .unorderedListItem(text2)):
			return text1 == text2
		case let (.orderedListItem(text1), .orderedListItem(text2)):
			return text1 == text2
		case let (.textLine(text1), .textLine(text2)):
			return text1 == text2
		case let (.link(url1, text1), .link(url2, text2)):
			return url1 == url2 && text1 == text2
		case let (.image(url1, text1), .image(url2, text2)):
			return url1 == url2 && text1 == text2
		case (.lineBreak, .lineBreak):
			return true
		case (.horizontalLine, .horizontalLine):
			return true
		default:
			return false
		}
	}
}
