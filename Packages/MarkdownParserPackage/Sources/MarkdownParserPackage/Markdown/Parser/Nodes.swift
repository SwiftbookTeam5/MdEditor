//
//  Nodes.swift
//  MarkdownToHtml
//
//  Created by Kirill Leonov on 16.02.2024.
//

import Foundation

/// Протокол для узла дерева
public protocol INode {
	/// Дочерние элементы узла
	var children: [INode] { get }
}

/// Базовый узел дерева
public class BaseNode: INode {
	/// Дочерние элементы узла
	public private(set) var children: [INode]

	public init(_ children: [INode] = []) {
		self.children = children
	}
}

/// Корневой узел дерева
public final class Document: BaseNode {}

extension Document {
	func accept<T: IVisitor>(visitor: T) -> [T.Result] {
		visitor.visit(node: self)
	}
}

/// Заголовок
public final class HeaderNode: BaseNode {
	public let level: Int

	public init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}

/// Цитата
public final class BlockquoteNode: BaseNode {
	public let level: Int

	public init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}

/// Параграф
public final class ParagraphNode: BaseNode {}

/// Блок кода
public final class CodeBlockNode: BaseNode {
	public let level: Int
	public let lang: String

	public init(level: Int, lang: String, children: [INode] = []) {
		self.level = level
		self.lang = lang
		super.init(children)
	}
}

/// Строка кода
public final class CodeLineNode: BaseNode {
	public let text: String

	public init(text: String) {
		self.text = text
	}
}

/// Cписок
public final class ListNode: BaseNode {
	public let level: Int

	public init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}

/// Неупорядоченный список
public final class UnorderedListNode: BaseNode {}

/// Упорядоченный список
public final class OrderedListNode: BaseNode {}

/// Горизонтальная линия
public final class HorizontalLineNode: BaseNode {}

/// Текст
public final class TextNode: BaseNode {
	public let text: String

	public init(text: String) {
		self.text = text
	}
}

/// Жирный текст
public final class BoldTextNode: BaseNode {
	public let text: String

	public init(text: String) {
		self.text = text
	}
}

/// Курсивный текст
public final class ItalicTextNode: BaseNode {
	public let text: String

	public init(text: String) {
		self.text = text
	}
}

/// Жирный и курсивный текст
public final class BoldItalicTextNode: BaseNode {
	public let text: String

	public init(text: String) {
		self.text = text
	}
}

/// Встроенный код
public final class InlineCodeNode: BaseNode {
	public let code: String

	public init(code: String) {
		self.code = code
	}
}

/// Символы
public final class EscapedCharNode: BaseNode {
	public let char: String

	public init(char: String) {
		self.char = char
	}
}

/// Перевод строки
public final class LineBreakNode: BaseNode {
	public init() {}
}

/// Ссылка
public final class LinkNode: BaseNode {
	public let url: String
	public let text: String
	
	public init(url: String, text: String) {
		self.url = url
		self.text = text
	}
}

/// Картинка
public final class ImageNode: BaseNode {
	public let url: String
	public let size: String

	public init(url: String, size: String) {
		self.url = url
		self.size = size
	}
}

public final class TaskNode: BaseNode {
	public let isDone: Bool
	
	public init(isDone: Bool, children: [INode] = []) {
		self.isDone = isDone
		super.init(children)
	}
}
