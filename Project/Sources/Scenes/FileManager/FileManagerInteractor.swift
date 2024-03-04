//
//  FileManagerInteractor.swift
//  MdEditor
//
//  Created by Александра Рязанова on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit
import FileManagerPackage

/// Делегат по управлению открытием папки и файла. Реализован должен быть в координаторе.
protocol IFileManagerDelegate: AnyObject {

	/// Открыть выбранную папке.
	/// - Parameter file: Ссылка на папку.
	func openFolder(file: File)

	/// Открыть выбранный файл.
	/// - Parameter file: Ссылка на файл.
	func openFile(file: File)
}

protocol IFileManagerInteractor {

	/// Событие на предоставление информации о файлах и действиях
	func fetchData()

	/// Событие, что файл или папка была выбрана.
	/// - Parameter request: Запрос, содержащий информацию о выбранном элементе.
	func performAction(request: FileManagerModel.Request)
}

final class FileManagerInteractor: IFileManagerInteractor {

	// MARK: - Dependencies

	private let presenter: IFileManagerPresenter
	private let fileExplorer: IFileExplorer
	private weak var delegate: IFileManagerDelegate?

	// MARK: - Private properties

	private var files: [File] = []
	private let currentFile: File?

	// MARK: - Initialization

	init(
		presenter: IFileManagerPresenter,
		fileExplorer: IFileExplorer,
		delegate: IFileManagerDelegate,
		file: File?
	) {
		self.presenter = presenter
		self.fileExplorer = fileExplorer
		self.delegate = delegate
		self.currentFile = file
	}

	// MARK: - Internal methods

	/// Событие на предоставление информации о файлах и действиях
	func fetchData() {
		files = [File]()

		if let currentFile = currentFile {
			switch fileExplorer.contentsOfFolder(at: currentFile.url) {
			case .success(let files):
				self.files = files
			case .failure:
				break
			}
		} else {
			if case .success(let file) = File.parse(url: Endpoints.docs) {
				files.append(file)
			}

			if case .success(let file) = File.parse(url: Endpoints.documents) {
				files.append(file)
			}
		}

		files.sort { $0.isFolder && !$1.isFolder }

		let responce = FileManagerModel.Response(currentFile: currentFile, files: files)
		presenter.present(response: responce)
	}

	/// Событие, что файл или папка была выбрана.
	/// - Parameter request: Запрос, содержащий информацию о выбранном элементе.
	func performAction(request: FileManagerModel.Request) {
		switch request {
		case .fileSelected(let indexPath):
			let selectedFile = files[min(indexPath.row, files.count - 1)]
			if selectedFile.isFolder {
				delegate?.openFolder(file: selectedFile)
			} else {
				delegate?.openFile(file: selectedFile)
			}
		}
	}
}
