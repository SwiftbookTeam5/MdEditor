//
//  OpenFileInteractor.swift
//  MdEditor
//
//  Created by Александра Рязанова on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit

protocol IOpenFileInteractor {

	/// Событие на предоставление информации о файлах и действиях
	func fetchData()

	/// Событие, что файл был выбран.
	/// - Parameter request: Запрос, содержащий информацию о выбранном файле.
	func didFileSelected(request: OpenFileModel.Request.ItemSelected)
}

final class OpenFileInteractor: IOpenFileInteractor {

	// MARK: - Dependencies

	private var presenter: IOpenFilePresenter
	private let fileExplorer: IFileExplorer
	private let path: String

	private var files: [OpenFileModel.Response.File] = []

	// MARK: - Initialization

	init(presenter: IOpenFilePresenter, fileExplorer: IFileExplorer, path: String) {
		self.presenter = presenter
		self.fileExplorer = fileExplorer
		self.path = path
	}

	// MARK: - Internal methods

	/// Событие на предоставление информации о файлах и действиях
	func fetchData() {
		try? fileExplorer.scan(path: path)
		files = mapFilesData(files: fileExplorer.files)

		let responce = OpenFileModel.Response(files: files)
		presenter.present(response: responce)
	}

	/// Событие, что файл был выбран.
	/// - Parameter request: Запрос, содержащий информацию о выбранном файле.
	func didFileSelected(request: OpenFileModel.Request.ItemSelected) {
		let file = files[request.indexPath.row]

		if file.isFolder {
			let responce = OpenFileModel.Response(files: [file])
			presenter.presentFolder(response: responce)
		}
	}
}

// MARK: - Private methods

private extension OpenFileInteractor {

	/// Мапинг файлов для бизнес-модели
	/// - Parameter files: Файлы для преобразования.
	/// - Returns: Преобразованный результат.
	func mapFilesData(files: [File]) -> [OpenFileModel.Response.File] {
		files.map { mapFileData(file: $0) }
	}

	/// Мапинг файлов для бизнес-модели
	/// - Parameter file: Файл для преобразования.
	/// - Returns: Преобразованный результат.
	func mapFileData(file: File) -> OpenFileModel.Response.File {
		let response = OpenFileModel.Response.File(
			title: file.name,
			subTitle: file.description,
			path: file.fullname,
			isFolder: file.isDirectory
		)

		return response
	}
}
