//
//  MarkdownParserManager.swift
//  
//
//  Created by Александра Рязанова on 21.02.2024.
//

import Foundation

/// Протокол лексического анализа текста
public protocol IMarkdownParserManager {
	
	/// Анализирует  входную строку и пребразовывает в структурированный формат
	/// - Parameter input: входная строка
	/// - Returns: дерево
	func analyse(_ input: String) -> Document
}

/// MarkdownParserManager
public final class MarkdownParserManager: IMarkdownParserManager {

	// MARK: - Dependencies

	private var lexer: ILexer
	private var parser: IParser

	// MARK: - Init
	
	/// Инициализатор
	public init(lexer: ILexer = Lexer(), parser: IParser = Parser()) {
		self.lexer = lexer
		self.parser = parser
	}

	// MARK: - Public methods

	/// Анализирует  входную строку и пребразовывает в структурированный формат
	/// - Parameter input: входная строка
	/// - Returns: дерево
	public func analyse(_ input: String) -> Document {
		let tokens = lexer.tokenize(input)
		let document = parser.parse(tokens: tokens)
		
		return document
	}
}
