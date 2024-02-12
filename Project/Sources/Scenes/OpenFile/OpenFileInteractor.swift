//
//  OpenFileInteractor.swift
//  MdEditor
//
//  Created by Александра Рязанова on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit
import FileManagerPackage

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
	private let url: URL?

	private var files: [OpenFileModel.Response.File] = []

	// MARK: - Initialization

	init(presenter: IOpenFilePresenter, fileExplorer: IFileExplorer, url: URL?) {
		self.presenter = presenter
		self.fileExplorer = fileExplorer
		self.url = url
	}

	// MARK: - Internal methods

	/// Событие на предоставление информации о файлах и действиях
	func fetchData() {
		if let url {
			try? fileExplorer.scan(url: url)
		} else {
			fileExplorer.scan(sources: [.documentDirectory, .bundle("Docs")])
		}

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
			isFolder: file.isDirectory,
			url: file.url
		)

		return response
	}
}
