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
	/// - Parameter file: файл
	/// - Returns: данные
	func convertToPDF(file: File) -> Data?
}

final class MarkdownConverterAdapter: IMarkdownConverterAdapter {

	// MARK: - Private properties

	private let converterToAttributedText = MarkdownToAttributedTextConverter()
	private let converterToPDF = MarkdownToPdfConverter()

	// MARK: - Internal methods

	/// Конвертация в PDF
	/// - Parameter file: файл
	/// - Returns: данные
	func convertToPDF(file: File) -> Data? {
		guard let data = file.contentOfFile(), let fileContent = String(data: data, encoding: .utf8) else { return nil }

		let text = converterToAttributedText.convert(markdownText: fileContent)
		let dataPDF = converterToPDF.convert(markdownText: text.string, pdfAuthor: "", pdfTitle: file.name)

		return dataPDF
	}
}
