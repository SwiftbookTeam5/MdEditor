//
//  TextPreviewAssembler.swift
//  MdEditor
//
//  Created by Kirill Leonov on 16.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import Foundation
import FileManagerPackage
import MarkdownParserPackage

final class TextPreviewAssembler {

	/// Сборка модуля просмотра файла
	/// - Parameters:
	///   - file: файл
	///   - converter: конвертер для отображения
	///   - converterToExport: конвертор для экспорта
	///   - delegate: делегат навигации
	/// - Returns: контроллер с проставленными зависимостями VIP цикла.
	func assembly(
		file: File,
		converter: IMarkdownToAttributedTextConverter,
		converterToExport: IMarkdownConverterAdapter,
		delegate: ITextPreviewDelegate
	) -> TextPreviewViewController {
		let viewController = TextPreviewViewController()
		let presenter = TextPreviewPresenter(viewController: viewController, converter: converter)
		let interactor = TextPreviewInteractor(
			presenter: presenter,
			file: file,
			delegate: delegate,
			converterToExport: converterToExport
		)
		viewController.interactor = interactor

		return viewController
	}
}
