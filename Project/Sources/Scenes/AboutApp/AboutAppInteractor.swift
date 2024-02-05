//
//  AboutAppInteractor.swift
//  MdEditor
//
//  Created by Руслан Мингалиев on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation

protocol IAboutAppInteractor {

	/// Событие на предоставление информации 
	func fetchData()
}

final class AboutAppInteractor: IAboutAppInteractor {

	// MARK: - Dependencies

	private var presenter: IAboutAppPresenter?

	// MARK: - Initialization

	init(presenter: IAboutAppPresenter) {
		self.presenter = presenter
	}

	// MARK: - Public methods

	func fetchData() {
		let responce = AboutAppModel.Response(result: createAboutStub())
		presenter?.present(responce: responce)
	}
}

// MARK: - Private methods

private extension AboutAppInteractor {

	func createAboutStub() -> String {
		"""
		Данное приложение представляет собой функциональный Markdown
		редактор с возможностью экспорта и сохранения данных.
		Имеет возможность экспорта текста в форматы HTML и PDF.
		"""
	}
}
