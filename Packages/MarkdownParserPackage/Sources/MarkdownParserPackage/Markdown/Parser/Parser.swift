//
//  Parser.swift
//  MarkdownToHtml
//
//  Created by Kirill Leonov on 16.02.2024.
//

import Foundation

/// Протокол для синтаксические анализ текста
public protocol IParser {

	/// Анализирует входные токены и преобразует в структурированный формат
	/// - Parameter tokens: токены
	/// - Returns: дерево
	func parse(tokens: [Token]) -> Document
}

/// Parser анализирует входные токены и преобразует в структурированный формат
public final class Parser: IParser {

	// MARK: - Init

	/// Инициализатор
	public init() {}

	// MARK: - Public methods

	/// Анализирует входные токены и преобразует в структурированный формат
	/// - Parameter tokens: токены
	/// - Returns: дерево
	public func parse(tokens: [Token]) -> Document {
		var tokens = tokens
		var result = [INode]()

		while !tokens.isEmpty {
			var nodes = [INode?]()
			nodes.append(parseHeader(tokens: &tokens))
			nodes.append(parseBlockquote(tokens: &tokens))
			nodes.append(parseUnorderedList(tokens: &tokens))
			nodes.append(parseOrderedList(tokens: &tokens))
			nodes.append(parseHorizontalLine(tokens: &tokens))
			nodes.append(parseParagraph(tokens: &tokens))
			nodes.append(parseLineBreak(tokens: &tokens))
			nodes.append(parseLink(tokens: &tokens))

			let resultNodes = nodes.compactMap { $0 }

			if resultNodes.isEmpty, !tokens.isEmpty {
				tokens.removeFirst()
			} else {
				result.append(contentsOf: resultNodes)
			}
		}

		return Document(result)
	}
}

// MARK: - Private methods

private extension Parser {

	func parseHeader(tokens: inout [Token]) -> HeaderNode? {
		guard let token = tokens.first else {
			return nil
		}

		if case let .header(level, text) = token {
			tokens.removeFirst()
			return HeaderNode(level: level, children: parseText(token: text))
		}

		return nil
	}

	func parseBlockquote(tokens: inout [Token]) -> BlockquoteNode? {
		guard let token = tokens.first else {
			return nil
		}

		if case let .blockquote(level, text) = token {
			tokens.removeFirst()
			return BlockquoteNode(level: level, children: parseText(token: text))
		}

		return nil
	}

	func parseParagraph(tokens: inout [Token]) -> ParagraphNode? {
		var textNodes = [INode]()

		while !tokens.isEmpty {
			guard let token = tokens.first else { return nil }
			if case let .textLine(text) = token {
				tokens.removeFirst()
				textNodes.append(contentsOf: parseText(token: text))
			} else if case .lineBreak = token {
				tokens.removeFirst()
				break
			} else {
				break
			}
		}

		if !textNodes.isEmpty {
			return ParagraphNode(textNodes)
		}

		return nil
	}

	func parseUnorderedList(tokens: inout [Token]) -> ListNode? {
		guard let token = tokens.first else {
			return nil
		}

		if case .unorderedListItem = token {
			var lineNodes = [INode]()

			while !tokens.isEmpty {
				guard let token = tokens.first else { return nil }
				if case let .unorderedListItem(text) = token {
					tokens.removeFirst()
					lineNodes.append(UnorderedListNode(parseText(token: text)))
				} else {
					break
				}
			}

			if !lineNodes.isEmpty {
				return ListNode(level: 1, children: lineNodes)
			}
		}

		return nil
	}

	func parseOrderedList(tokens: inout [Token]) -> ListNode? {
		guard let token = tokens.first else {
			return nil
		}

		if case .orderedListItem = token {
			var lineNodes = [INode]()

			while !tokens.isEmpty {
				guard let token = tokens.first else { return nil }
				if case let .orderedListItem(text) = token {
					tokens.removeFirst()
					lineNodes.append(OrderedListNode(parseText(token: text)))
				} else {
					break
				}
			}

			if !lineNodes.isEmpty {
				return ListNode(level: 1, children: lineNodes)
			}
		}

		return nil
	}

	func parseCodeBlock(tokens: inout [Token]) -> CodeBlockNode? {
		guard let token = tokens.first else {
			return nil
		}

		if case let .codeBlockMarker(level, lang) = token {
			var lineNodes = [INode]()
			tokens.removeFirst()

			while !tokens.isEmpty {
				guard let token = tokens.first else { return nil }
				if case let .codeLine(text) = token {
					tokens.removeFirst()
					lineNodes.append(CodeLineNode(text: text))
				} else if case .codeBlockMarker = token {
					tokens.removeFirst()
					break
				} else {
					break
				}
			}

			if !lineNodes.isEmpty {
				return CodeBlockNode(level: level, lang: lang, children: lineNodes)
			}
		}

		return nil
	}

	func parseImage(tokens: inout [Token]) -> ImageNode? {
		guard let token = tokens.first else {
			return nil
		}

		if case let .image(url, size) = token {
			tokens.removeFirst()
			return ImageNode(url: url, size: String(size))
		}

		return nil
	}
	
	func parseLink(tokens: inout [Token]) -> LinkNode? {
		guard let token = tokens.first else {
			return nil
		}
		
		if case let .link(url, text) = token {
			tokens.removeFirst()
			return LinkNode(url: url, text: text)
		}
		
		return nil
	}
	
	func parseHorizontalLine(tokens: inout [Token]) -> HorizontalLineNode? {
		guard let token = tokens.first else {
			return nil
		}
		
		if case .horizontalLine = token {
			tokens.removeFirst()
			return HorizontalLineNode()
		}
		
		return nil
	}

	func parseLineBreak(tokens: inout [Token]) -> LineBreakNode? {
		guard let token = tokens.first else {
			return nil
		}

		if case .lineBreak = token {
			tokens.removeFirst()
			return LineBreakNode()
		}

		return nil
	}

	func parseText(token: Text) -> [INode] {
		var textNodes = [INode]()
		token.text.forEach { part in
			switch part {
			case .normal(let text):
				textNodes.append(TextNode(text: text))
			case .bold(let text):
				textNodes.append(BoldTextNode(text: text))
			case .italic(let text):
				textNodes.append(ItalicTextNode(text: text))
			case .boldItalic(let text):
				textNodes.append(BoldItalicTextNode(text: text))
			case .inlineCode(let text):
				textNodes.append(InlineCodeNode(code: text))
			case .escapedChar(let char):
				textNodes.append(EscapedCharNode(char: char))
			}
		}

		return textNodes
	}
}
