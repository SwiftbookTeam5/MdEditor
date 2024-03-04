//
//  Lexer.swift
//  MdEditor
//
//  Created by Александра Рязанова on 17.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation

/// Протокол лексического анализа текста
public protocol ILexer {

	/// Анализирует  входную строку и пребразовывает в последовательность токенов.
	/// - Parameter input: входная строка
	/// - Returns: токены
	func tokenize(_ input: String) -> [Token]
}

/// Lexer анализирует входную строку и преобразует ее в последовательность токенов.
public final class Lexer: ILexer {

	// MARK: - Init

	/// Инициализатор 
	public init() {}

	// MARK: - Public methods

	/// Анализирует  входную строку и пребразовывает в последовательность токенов.
	/// - Parameter input: входная строка
	/// - Returns: токены
	public func tokenize(_ input: String) -> [Token] {

		let lines = input.components(separatedBy: .newlines)
		var tokens = [Token?]()
		var inCodeBlock = false

		for line in lines {
			if let codeBlockToken = parseCodeBlockMarker(rawText: line) {
				tokens.append(codeBlockToken)
				inCodeBlock.toggle()
				continue
			}

			if let listBlockToken = parseOrderedList(rawText: line) {
				tokens.append(listBlockToken)
				continue
			}

			if let listBlockToken = parseUnorderedList(rawText: line) {
				tokens.append(listBlockToken)
				continue
			}
			
			if let horizontalLine = parseHorizontalLine(rawText: line) {
				tokens.append(horizontalLine)
				continue
			}

			if !inCodeBlock {
				tokens.append(parseLineBreak(rawText: line))
				tokens.append(parseHeader(rawText: line))
				tokens.append(parseBlockquote(rawText: line))
				tokens.append(parseParagraph(rawText: line))
				tokens.append(parseLink(rawText: line))
			} else {
				tokens.append(.codeLine(text: line))
			}
		}

		return tokens.compactMap { $0 }
	}
}

// MARK: - Private methods

private extension Lexer {

	func parseLineBreak(rawText: String) -> Token? {
		if rawText.isEmpty {
			return .lineBreak
		}

		return nil
	}

	func parseHeader(rawText: String) -> Token? {
		let pattern = #"^(#{1,6})\s+(.+)"#

		if let headerLevel = rawText.group(for: pattern)?.count, let text = rawText.group(for: pattern, group: 2) {
			let headerText = parseText(rawText: text)
			return .header(level: headerLevel, text: headerText)
		}

		return nil
	}

	func parseBlockquote(rawText: String) -> Token? {
		let pattern = #"^(>{1,6})\s+(.+)"#

		if let blockquoteLevel = rawText.group(for: pattern)?.count, let text = rawText.group(for: pattern, group: 2) {
			let blockquoteText = parseText(rawText: text)
			return .blockquote(level: blockquoteLevel, text: blockquoteText)
		}

		return nil
	}

	func parseUnorderedList(rawText: String) -> Token? {
		let pattern = #"^-\s+(.+)"#

		if let text = rawText.group(for: pattern) {
			let blockquoteText = parseText(rawText: text)
			return .unorderedListItem(text: blockquoteText)
		}

		return nil
	}

	func parseOrderedList(rawText: String) -> Token? {
		let pattern = #"^\d{1,6}.\s+(.+)"#

		if let text = rawText.group(for: pattern) {
			let blockquoteText = parseText(rawText: text)
			return .orderedListItem(text: blockquoteText)
		}

		return nil
	}

	func parseParagraph(rawText: String) -> Token? {
		if rawText.isEmpty { return nil }

		let pattern = #"^([^#>].*)"#

		if let text = rawText.group(for: pattern) {
			let textLine = parseText(rawText: text)
			return .textLine(text: textLine)
		}

		return nil
	}

	func parseCodeBlockMarker(rawText: String) -> Token? {
		let pattern = #"^'{2,6}(.*)"#

		if let text = rawText.group(for: pattern) {
			let level = rawText.filter { $0 == "'" }.count
			return .codeBlockMarker(level: level, lang: text)
		}

		return nil
	}
	
	func parseLink(rawText: String) -> Token? {
		let pattern = #"^(?<!\!)\[(.+?)\]\((.+?)\)"#
		
		if let text = rawText.group(for: pattern), let url = rawText.group(for: pattern, group: 2) {
			return .link(url: url, text: text)
		}
		
		return nil
	}
	
	func parseHorizontalLine(rawText: String) -> Token? {
		let pattern = #"^(-{3,}|_{3,}|\*{3,})$"#
		
		if rawText.group(for: pattern) != nil {
			return .horizontalLine
		}
		
		return nil
	}

	func parseText(rawText: String) -> Text {
		TextParser().parse(rawText: rawText)
	}
}
