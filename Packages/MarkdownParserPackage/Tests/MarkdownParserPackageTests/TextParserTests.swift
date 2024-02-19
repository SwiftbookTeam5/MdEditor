//
//  TextParserTests.swift
//  
//
//  Created by Александра Рязанова on 22.02.2024.
//

import XCTest
@testable import MarkdownParserPackage

final class TextParserTests: XCTestCase {

	func test_parse_withNormalText_shouldBeCorrectPart() {
		let sut = TextParser()

		let text = sut.parse(rawText: "Нормальный")

		XCTAssertEqual(
			text.text[0],
			Text.Part.normal(text: "Нормальный"),
			"Не верный парсинг нормального текста"
		)
	}

	func test_parse_withBoldText_shouldBeCorrectPart() {
		let sut = TextParser()

		let text = sut.parse(rawText: "**Жирный**")

		XCTAssertEqual(
			text.text[0],
			Text.Part.bold(text: "Жирный"),
			"Не верный парсинг жирного текста"
		)
	}
	
	func test_parse_withItalicText_shouldBeCorrectPart() {
		let sut = TextParser()
		
		let text = sut.parse(rawText: "*Курсивный*")
		
		XCTAssertEqual(
			text.text[0],
			Text.Part.italic(text: "Курсивный"),
			"Не верный парсинг жирного текста"
		)
	}
	
	func test_parse_withBoldAndItalicText_shouldBeCorrectPart() {
		let sut = TextParser()
		
		let text = sut.parse(rawText: "***Жирный и курсивный***")
		
		XCTAssertEqual(
			text.text[0],
			Text.Part.boldItalic(text: "Жирный и курсивный"),
			"Не верный парсинг жирного и курсивного текста"
		)
	}

	func test_parse_withInlineCode_shouldBeCorrectPart() {
		let sut = TextParser()

		let text = sut.parse(rawText: "`Код`")

		XCTAssertEqual(
			text.text[0],
			Text.Part.inlineCode(text: "Код"),
			"Не верный парсинг встроенного кода"
		)
	}
}
