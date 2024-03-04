//
//  TextPreviewPresenter.swift
//  MdEditor
//
//  Created by Kirill Leonov on 16.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import Foundation
import MarkdownParserPackage

protocol ITextPreviewPresenter {

	/// Отображение экрана с текстом файла.
	/// - Parameter response: Подготовленные к отображению данные.
	func present(response: TextPreviewModel.Response)
}

final class TextPreviewPresenter: ITextPreviewPresenter {

	// MARK: - Dependencies

	private weak var viewController: ITextPreviewViewController?
	private let converter: IMarkdownToAttributedTextConverter

	// MARK: - Initialization

	init(viewController: ITextPreviewViewController?, converter: IMarkdownToAttributedTextConverter) {
		self.viewController = viewController
		self.converter = converter
	}

	// MARK: - Public methods

	/// Отображение экрана с текстом файла.
	/// - Parameter response: Подготовленные к отображению данные.
	func present(response: TextPreviewModel.Response) {
		let text = converter.convert(markdownText: response.fileContent)

		let viewModel = TextPreviewModel.ViewModel(
			currentTitle: response.fileUrl.lastPathComponent,
			text: NSAttributedString(attributedString: text)
		)
		viewController?.render(viewModel: viewModel)
	}
}
