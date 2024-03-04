//
//  MarkdownToDocument.swift
//  
//
//  Created by Kirill Leonov on 24.02.2024.
//

import Foundation

/// Протокол для конвертации в документ
public protocol IMarkdownToDocument {

	/// Конвертации в документ
	/// - Parameter markdownText: текст
	/// - Returns: документ
	func convert(markdownText: String) -> Document
}

/// Класс для конвертации в документ
public final class MarkdownToDocument: IMarkdownToDocument {
	
	// MARK: - Private properties

	private let lexer = Lexer()
	private let parser = Parser()

	// MARK: - Init

	public init() { }

	// MARK: - Public methods
	
	/// Конвертации в документ
	/// - Parameter markdownText: текст
	/// - Returns: документ
	public func convert(markdownText: String) -> Document {
		let tokens = lexer.tokenize(markdownText)
		let document = parser.parse(tokens: tokens)

		return document
	}
}
