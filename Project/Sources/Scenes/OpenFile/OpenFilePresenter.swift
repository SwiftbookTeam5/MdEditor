//
//  OpenFilePresenter.swift
//  MdEditor
//
//  Created by Александра Рязанова on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit

protocol IOpenFilePresenter {

	/// Отображение экрана со списком файлов и действий.
	/// - Parameter response: Подготовленные к отображению данные.
	func present(response: OpenFileModel.Response)

	/// Открывает выбранный файл
	/// - Parameter response: Данные файла
	func presentFolder(response: OpenFileModel.Response)
}

typealias OpenFileResultClosure = (Result<String, Error>) -> Void

final class OpenFilePresenter: IOpenFilePresenter {

	// MARK: - Dependencies

	private weak var viewController: IOpenFileViewController! // swiftlint:disable:this implicitly_unwrapped_optional
	private var openFileResultClosure: OpenFileResultClosure?

	// MARK: - Initialization

	init(viewController: IOpenFileViewController, openFileResultClosure: OpenFileResultClosure?) {
		self.viewController = viewController
		self.openFileResultClosure = openFileResultClosure
	}

	// MARK: - Internal methods

	/// Отображение экрана со списком файлов..
	/// - Parameter response: Подготовленные к отображению данные.
	func present(response: OpenFileModel.Response) {
		let viewModel = OpenFileModel.ViewModel(files: mapFilesData(files: response.files))
		viewController.render(viewModel: viewModel)
	}

	/// Отображение экрана со списком файлов указанной папки.
	/// - Parameter response: Данные папки
	func presentFolder(response: OpenFileModel.Response) {
		guard let file = response.files.first else { return }
		openFileResultClosure?(.success(file.path))
	}
}

// MARK: - Private methods

private extension OpenFilePresenter {

	/// Мапинг файлов из бизнес-модели в файлы для отображения
	/// - Parameter files: Файлы для преобразования.
	/// - Returns: Преобразованный результат.
	func mapFilesData(files: [OpenFileModel.Response.File]) -> [OpenFileModel.ViewModel.File] {
		files.map { mapFileData(file: $0) }
	}

	/// Мапинг одного файла из бизнес-модели в файл для отображения
	/// - Parameter file: Файл для преобразования.
	/// - Returns: Преобразованный результат.
	func mapFileData(file: OpenFileModel.Response.File) -> OpenFileModel.ViewModel.File {
		let response = OpenFileModel.ViewModel.File(
			title: file.title,
			subTitle: file.subTitle,
			image: file.isFolder ? Asset.Icons.folder.image : Asset.Icons.textFile.image
		)

		return response
	}
}
