//
//  MarkdownToAttributedTextConverter.swift
//
//  Created by Kirill Leonov on 22.05.2023.
//

import Foundation

/// Протокол для конвертации в AttributedString
public protocol IMarkdownToAttributedTextConverter {

	/// Конвертации в AttributedString
	/// - Parameter markdownText: текст
	/// - Returns: строка
	func convert(markdownText: String) -> NSMutableAttributedString
}

/// Класс для конвертации в AttributedString
public final class MarkdownToAttributedTextConverter: IMarkdownToAttributedTextConverter {

	// MARK: - Private properties

	private let markdownToDocument = MarkdownToDocument()

	// MARK: - Init

	public init() {}

	// MARK: - Public methods
	
	/// Конвертации в AttributedString
	/// - Parameter markdownText: текст
	/// - Returns: строка
	public func convert(markdownText: String) -> NSMutableAttributedString {
		let document = markdownToDocument.convert(markdownText: markdownText)
		
		return convert(document: document)
	}
	
	// MARK: - Internal methods

	func convert(document: Document) -> NSMutableAttributedString {
		let visitor = AttributedTextVisitor()
		
		let result = document.accept(visitor: visitor)
		return result.joined()
	}
}
