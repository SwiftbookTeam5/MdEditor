//
//  TextPreviewInteractor.swift
//  MdEditor
//
//  Created by Kirill Leonov on 16.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import Foundation
import FileManagerPackage

protocol ITextPreviewInteractor {

	/// Событие на предоставление информации
	func fetchData()
}

final class TextPreviewInteractor: ITextPreviewInteractor {

	// MARK: - Dependencies

	private var presenter: ITextPreviewPresenter

	// MARK: - Private properties

	private let file: File

	// MARK: - Initialization

	init(presenter: ITextPreviewPresenter, file: File) {
		self.presenter = presenter
		self.file = file
	}

	// MARK: - Public methods

	/// Событие на предоставление информации
	func fetchData() {
		let data = (try? Data(contentsOf: file.url)) ?? Data()
		let fileContent = String(data: data, encoding: .utf8) ?? ""
		let response = TextPreviewModel.Response(fileUrl: file.url, fileContent: fileContent)
		presenter.present(response: response)
	}
}
