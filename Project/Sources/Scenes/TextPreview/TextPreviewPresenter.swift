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

	// MARK: - Initialization

	init(viewController: ITextPreviewViewController?) {
		self.viewController = viewController
	}

	// MARK: - Public methods

	/// Отображение экрана с текстом файла.
	/// - Parameter response: Подготовленные к отображению данные.
	func present(response: TextPreviewModel.Response) {
		let viewModel = TextPreviewModel.ViewModel(
			currentTitle: response.fileUrl.lastPathComponent,
			text: NSAttributedString(string: response.fileContent)
		)
		viewController?.render(viewModel: viewModel)
	}
}
