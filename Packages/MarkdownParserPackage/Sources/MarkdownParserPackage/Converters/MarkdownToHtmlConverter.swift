//
//  MarkdownToHtmlConverter.swift
//
//  Created by Kirill Leonov on 22.05.2023.
//

import Foundation

/// Протокол для конвертации в документ
public protocol IMarkdownToHtmlConverter {

	/// Конвертации в HTML
	/// - Parameter markdownText: текст
	/// - Returns: HTML строка
	func convert(markdownText: String) -> String
}

/// Класс для конвертации в HTML
public final class MarkdownToHtmlConverter {

	// MARK: - Private properties

	private let markdownToDocument = MarkdownToDocument()

	// MARK: - Init

	public init() { }
	
	// MARK: - Public methods
	
	/// Конвертации в HTML
	/// - Parameter markdownText: текст
	/// - Returns: HTML строка
	public func convert(markdownText: String) -> String {
		let document = markdownToDocument.convert(markdownText: markdownText)

		let visitor = HtmlVisitor()
		let html = document.accept(visitor: visitor)
		
		return makeHtml(html.joined())
	}
	
	// MARK: - Internal methods

	func makeHtml(_ text: String) -> String {
		return "<!DOCTYPE html><html><head><style> body {font-size:300%;}</style></head><boby>\(text)</boby></html>"
	}
}
