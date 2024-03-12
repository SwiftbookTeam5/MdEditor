//
//  TextPreviewInteractor.swift
//  MdEditor
//
//  Created by Kirill Leonov on 16.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import Foundation
import FileManagerPackage

/// Делегат по управлению открытием папки и файла. Реализован должен быть в координаторе.
protocol ITextPreviewDelegate: AnyObject {

	/// Открытие окна выбора пути для экспорта файла.
	/// - Parameter url: url файла источника.
	func saveFile(sourceURL: URL)

	/// Отображение ошибки
	/// - Parameter message: сообщение
	func showError(message: String)
}

protocol ITextPreviewInteractor {

	/// Событие на предоставление информации
	func fetchData()

	/// Событие выбора экспорта в PDF
	func exportToPDF()
}

final class TextPreviewInteractor: ITextPreviewInteractor {

	// MARK: - Dependencies

	private var presenter: ITextPreviewPresenter
	private var delegate: ITextPreviewDelegate
	private let converterToExport: IMarkdownConverterAdapter

	// MARK: - Private properties

	private let fileManager = FileManager.default
	private let file: File

	// MARK: - Initialization

	init(
		presenter: ITextPreviewPresenter,
		file: File,
		delegate: ITextPreviewDelegate,
		converterToExport: IMarkdownConverterAdapter
	) {
		self.presenter = presenter
		self.file = file
		self.delegate = delegate
		self.converterToExport = converterToExport
	}

	// MARK: - Public methods

	/// Событие на предоставление информации
	func fetchData() {
		let fileContent = String(data: file.contentOfFile() ?? Data(), encoding: .utf8) ?? ""
		let response = TextPreviewModel.Response(fileUrl: file.url, fileContent: fileContent)
		presenter.present(response: response)
	}

	/// Событие выбора экспорта в PDF
	func exportToPDF() {
		guard let data = converterToExport.convertToPDF(file: file) else {
			delegate.showError(message: L10n.Error.exportPDF)
			return
		}

		let fileURL = fileManager.temporaryDirectory.appendingPathComponent(file.name)

		do {
			try data.write(to: fileURL)
			delegate.saveFile(sourceURL: fileURL)
		} catch {
			delegate.showError(message: L10n.Error.exportPDF)
		}
	}
}
