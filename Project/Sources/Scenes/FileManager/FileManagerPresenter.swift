//
//  FileManagerPresenter.swift
//  MdEditor
//
//  Created by Александра Рязанова on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation
import FileManagerPackage

protocol IFileManagerPresenter {

	/// Отображение экрана со списком файлов и действий.
	/// - Parameter response: Подготовленные к отображению данные.
	func present(response: FileManagerModel.Response)
}

final class FileManagerPresenter: IFileManagerPresenter {

	// MARK: - Dependencies

	private weak var viewController: IFileManagerViewController! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - Initialization

	init(viewController: IFileManagerViewController) {
		self.viewController = viewController
	}

	// MARK: - Internal methods

	/// Отображение экрана со списком файлов..
	/// - Parameter response: Подготовленные к отображению данные.
	func present(response: FileManagerModel.Response) {
		let viewModel = FileManagerModel.ViewModel(
			currentFolderName: response.currentFile?.name ?? L10n.File.title,
			files: mapFilesData(files: response.files)
		)
		viewController.render(viewModel: viewModel)
	}
}

// MARK: - Private methods

private extension FileManagerPresenter {

	/// Мапинг файлов из бизнес-модели в файлы для отображения
	/// - Parameter files: Файлы для преобразования.
	/// - Returns: Преобразованный результат.
	func mapFilesData(files: [File]) -> [FileManagerModel.ViewModel.File] {
		files.map { mapFileData(file: $0) }
	}

	/// Мапинг одного файла из бизнес-модели в файл для отображения
	/// - Parameter file: Файл для преобразования.
	/// - Returns: Преобразованный результат.
	func mapFileData(file: File) -> FileManagerModel.ViewModel.File {
		let response = FileManagerModel.ViewModel.File(
			name: file.name,
			info: file.description,
			isFolder: file.isDirectory
		)

		return response
	}
}
