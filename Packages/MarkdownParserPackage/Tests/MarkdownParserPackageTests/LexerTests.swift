//
//  LexerTests.swift
//  
//
//  Created by Александра Рязанова on 19.02.2024.
//

import XCTest
@testable import MarkdownParserPackage

final class LexerTests: XCTestCase {
	
	func test_tokenize_withHeader_shouldBeCorrectTokens() {
		let sut = Lexer()
		
		let tokens = sut.tokenize(headersString)

		XCTAssertEqual(
			tokens[0],
			.header(level: 1, text: makeNormalText("Header1")),
			"Не верный заголовок уровня 1"
		)
		XCTAssertEqual(
			tokens[2],
			.header(level: 2, text: makeNormalText("Header2")),
			"Не верный заголовок уровня 2"
		)
		XCTAssertEqual(
			tokens[4],
			.header(level: 3, text: makeNormalText("Header3")),
			"Не верный заголовок уровня 3"
		)
		XCTAssertEqual(
			tokens[6],
			.header(level: 4, text: makeNormalText("Header4")),
			"Не верный заголовок уровня 4"
		)
		XCTAssertEqual(
			tokens[8],
			.header(level: 5, text: makeNormalText("Header5")),
			"Не верный заголовок уровня 5"
		)
		XCTAssertEqual(
			tokens[10],
			.header(level: 6, text: makeNormalText("Header6")),
			"Не верный заголовок уровня 6"
		)
	}
	
	func test_tokenize_withBlockquote_shouldBeCorrectTokens() {
		let sut = Lexer()
		
		let tokens = sut.tokenize(blockquotesString)
		
		XCTAssertEqual(
			tokens[0],
			.blockquote(level: 1, text: makeNormalText("Blockquote1")),
			"Не верная цитата уровня 1"
		)
		XCTAssertEqual(
			tokens[2],
			.blockquote(level: 2, text: makeNormalText("Blockquote2")),
			"Не верная цитата уровня 2"
		)
		XCTAssertEqual(
			tokens[4],
			.blockquote(level: 3, text: makeNormalText("Blockquote3")),
			"Не верная цитата уровня 3"
		)
		XCTAssertEqual(
			tokens[6],
			.blockquote(level: 4, text: makeNormalText("Blockquote4")),
			"Не верная цитата уровня 4"
		)
		XCTAssertEqual(
			tokens[8],
			.blockquote(level: 5, text: makeNormalText("Blockquote5")),
			"Не верная цитата уровня 5"
		)
		XCTAssertEqual(
			tokens[10],
			.blockquote(level: 6, text: makeNormalText("Blockquote6")),
			"Не верная цитата уровня 6"
		)
	}
	
	func test_tokenize_withHorizontalLine_shouldBeCorrectTokens() {
		let sut = Lexer()
		
		let tokens = sut.tokenize(horizontalLineString)
		
		XCTAssertEqual(tokens[0], .horizontalLine, "Должен быть горизонтальная линия")
		XCTAssertEqual(tokens[2], .horizontalLine, "Должен быть горизонтальная линия")
		XCTAssertEqual(tokens[4], .horizontalLine, "Должен быть горизонтальная линия")
		XCTAssertNotEqual(tokens[6], .horizontalLine, "Не должно быть горизонтальной линией")
		XCTAssertNotEqual(tokens[8], .horizontalLine, "Не должно быть горизонтальной линией")
		XCTAssertNotEqual(tokens[10], .horizontalLine, "Не должно быть горизонтальной линией")
	}
	
	func test_tokenize_withUnorderedList_shouldBeCorrectTokens() {
		let text = makeNormalText("пункт")
		let sut = Lexer()
		
		let tokens = sut.tokenize(unorderedListString)
		
		XCTAssertEqual(tokens[0], .unorderedListItem(text: text), "Должен быть неупорядоченный список")
		XCTAssertEqual(tokens[1], .unorderedListItem(text: text), "Должен быть неупорядоченный список")
	}
	
	func test_tokenize_withOrderedList_shouldBeCorrectTokens() {
		let text = makeNormalText("пункт")
		let sut = Lexer()
		
		let tokens = sut.tokenize(orderedListString)
		
		XCTAssertEqual(tokens[0], .orderedListItem(text: text), "Должен быть упорядоченный список")
		XCTAssertEqual(tokens[1], .orderedListItem(text: text), "Должен быть упорядоченный список")
	}
	
	func test_tokenize_withParagraph_shouldBeCorrectTokens() {
		let sut = Lexer()
		
		let tokens = sut.tokenize(paragraphString)
		
		XCTAssertEqual(tokens[0], .textLine(text: makeNormalText("Параграф")), "Должен быть параграф")
		XCTAssertEqual(tokens[1], .textLine(text: makeNormalText("1 пункт")), "Должен быть параграф")
		XCTAssertEqual(tokens[2], .textLine(text: makeNormalText("-пункт")), "Должен быть параграф")
	}
	
	func test_tokenize_withCodeBlock_shouldBeCorrectTokens() {
		let sut = Lexer()
		
		let tokens = sut.tokenize(codeBlockString)
		
		XCTAssertEqual(tokens[0], .codeBlockMarker(level: 3, lang: "md"), "Должен быть начало блока кода")
		XCTAssertEqual(tokens[1], .codeLine(text: "строка кода"), "Должен быть параграф")
		XCTAssertEqual(tokens[2], .codeBlockMarker(level: 3, lang: ""), "Должен быть конец блока кода")
	}
	
	func test_tokenize_withText_shouldBeCorrectTokens() {
		let sut = Lexer()
		
		let tokens = sut.tokenize(textString)
		
		XCTAssertEqual(
			tokens[0],
			.textLine(text: Text(text: [Text.Part.italic(text: "курсив")])),
			"Текст должен быть курсивный"
		)
		XCTAssertEqual(
			tokens[1],
			.textLine(text: Text(text: [Text.Part.bold(text: "жирный")])),
			"Текст должен быть жирный"
		)
		XCTAssertEqual(
			tokens[2],
			.textLine(text: Text(text: [Text.Part.boldItalic(text: "жирный курсив")])),
			"Текст должен быть жирный и курсивный"
		)
		XCTAssertEqual(
			tokens[3],
			.textLine(text: Text(text: [Text.Part.normal(text: "нормальный")])),
			"Текст должен быть нормальный"
		)
		XCTAssertEqual(
			tokens[4],
			.textLine(text: Text(text: [Text.Part.inlineCode(text: "строка кода")])),
			"Текст должен быть строкой кода"
		)
	}
}

// MARK: - Private methods

private extension LexerTests {

	func makeNormalText(_ string: String) -> Text {
		Text(text: [Text.Part.normal(text: string)])
	}
}
