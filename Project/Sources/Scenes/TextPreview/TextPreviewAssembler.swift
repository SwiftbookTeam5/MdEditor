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
	/// - Parameter file: файл
	/// - Returns: контроллер с проставленными зависимостями VIP цикла.
	func assembly(file: File, converter: IMarkdownToAttributedTextConverter) -> TextPreviewViewController {
		let viewController = TextPreviewViewController()
		let presenter = TextPreviewPresenter(viewController: viewController, converter: converter)
		let interactor = TextPreviewInteractor(presenter: presenter, file: file)
		viewController.interactor = interactor

		return viewController
	}
}
