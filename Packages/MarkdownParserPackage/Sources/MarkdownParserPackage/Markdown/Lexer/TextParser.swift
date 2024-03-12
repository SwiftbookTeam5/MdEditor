//
//  TextParser.swift
//  MarkdownToHtml
//
//  Created by Kirill Leonov on 13.02.2024.
//

import Foundation

final class TextParser {

	private struct PartRegex {
		let type: PartType
		let regex: NSRegularExpression

		enum PartType {
			case normal
			case bold
			case italic
			case boldItalic
			case inlineCode
			case escapedChar
		}

		init(type: TextParser.PartRegex.PartType, pattern: String) {
			self.type = type
			self.regex = try! NSRegularExpression(pattern: pattern) // swiftlint:disable:this force_try
		}
	}

	private let partRegexes = [
		PartRegex(type: .escapedChar, pattern: #"^\\([\\\`\*\_\{\}\[\]\<\>\(\)\+\-\.\!\|#]){1}"#),
		PartRegex(type: .normal, pattern: #"^(.*?)(?=[\*`\\]|$)"#),
		PartRegex(type: .boldItalic, pattern: #"^\*\*\*(.*?)\*\*\*"#),
		PartRegex(type: .bold, pattern: #"^\*\*(.*?)\*\*"#),
		PartRegex(type: .italic, pattern: #"^\*(.*?)\*"#),
		PartRegex(type: .inlineCode, pattern: #"^`(.*?)`"#)
	]

	func parse(rawText text: String) -> Text {
		var parts = [Text.Part]()
		var range = NSRange(text.startIndex..., in: text)

		while range.location != NSNotFound && range.length != 0 {
			let startPartsCount = parts.count
			for partRegex in partRegexes {
				if let math = partRegex.regex.firstMatch(in: text, range: range),
				   let group0 = Range(math.range(at: 0), in: text),
				   let group1 = Range(math.range(at: 1), in: text) {

					let extractedText = String(text[group1])
					if !extractedText.isEmpty {
						switch partRegex.type {
						case .normal:
							parts.append(.normal(text: extractedText))
						case .bold:
							parts.append(.bold(text: extractedText))
						case .italic:
							parts.append(.italic(text: extractedText))
						case .boldItalic:
							parts.append(.boldItalic(text: extractedText))
						case .inlineCode:
							parts.append(.inlineCode(text: extractedText))
						case .escapedChar:
							parts.append(.escapedChar(char: extractedText))
						}
						range = NSRange(group0.upperBound..., in: text)
						break
					}
				}
			}

			if parts.count == startPartsCount {
				let extractedText = String(text[Range(range, in: text)!]) // swiftlint:disable:this force_unwrapping
				parts.append(.normal(text: extractedText))
				break
			}
		}

		return Text(text: parts)
	}
}
