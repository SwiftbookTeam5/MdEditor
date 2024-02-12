//
//  AboutAppInteractor.swift
//  MdEditor
//
//  Created by Руслан Мингалиев on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation
import FileManagerPackage

protocol IAboutAppInteractor {

	/// Событие на предоставление информации 
	func fetchData()
}

final class AboutAppInteractor: IAboutAppInteractor {

	// MARK: - Dependencies

	private var presenter: IAboutAppPresenter
	private var fileExplorer: IFileExplorer

	// MARK: - Initialization

	init(presenter: IAboutAppPresenter, fileExplorer: IFileExplorer) {
		self.presenter = presenter
		self.fileExplorer = fileExplorer
	}

	// MARK: - Public methods

	func fetchData() {
		fileExplorer.scan(sources: [.bundle("about.md")])
		if let file = fileExplorer.files.first {
			let aboutText = try? fileExplorer.loadFileBody(url: file.url)
			let responce = AboutAppModel.Response(result: aboutText ?? "")
			presenter.present(responce: responce)
		}
	}
}
