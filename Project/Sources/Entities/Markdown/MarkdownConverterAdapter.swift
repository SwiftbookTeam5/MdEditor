//
//  MarkdownConverterAdapter.swift
//  MdEditor
//
//  Created by Александра Рязанова on 13.03.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation
import MarkdownParserPackage
import FileManagerPackage

protocol IMarkdownConverterAdapter {

	/// Конвертация в PDF
	/// - Parameters:
	///   - file: файл
	///   - completion: данные
	func convertToPDF(file: File, completion: @escaping (Data?) -> Void)
}

final class MarkdownConverterAdapter: IMarkdownConverterAdapter {

	// MARK: - Private properties

	private let converterToAttributedText = MarkdownToAttributedTextConverter()
	private let converterToPDF = MarkdownToPdfConverter()

	// MARK: - Internal methods

	/// Конвертация в PDF
	/// - Parameters:
	///   - file: файл
	///   - completion: данные
	func convertToPDF(file: File, completion: @escaping (Data?) -> Void) {
		DispatchQueue.global(qos: .userInitiated).async {
			guard let data = file.contentOfFile(), let fileContent = String(data: data, encoding: .utf8) else {
				completion(nil)
				return
			}

			let text = self.converterToAttributedText.convert(markdownText: fileContent)
			let dataPDF = self.converterToPDF.convert(markdownText: text.string, pdfAuthor: "", pdfTitle: file.name)

			completion(dataPDF)
		}
	}
}
