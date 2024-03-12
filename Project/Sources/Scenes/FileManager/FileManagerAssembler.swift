//
//  FileManagerAssembler.swift
//  MdEditor
//
//  Created by Александра Рязанова on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit
import FileManagerPackage

final class FileManagerAssembler {

	/// Сборка модуля стартового экрана.
	/// - Parameters:
	///   - fileExplorer: загрузчик файлов
	///   - delegate: делегат нафигации
	///   - file: Текущий файл
	/// - Returns: контроллер с проставленными зависимостями VIP цикла.
	func assembly(fileExplorer: IFileExplorer, delegate: IFileManagerDelegate, file: File?) -> FileManagerViewController {
		let viewController = FileManagerViewController()
		let presenter = FileManagerPresenter(viewController: viewController)
		let interactor = FileManagerInteractor(
			presenter: presenter,
			fileExplorer: fileExplorer,
			delegate: delegate,
			file: file
		)
		viewController.interactor = interactor

		return viewController
	}
}
