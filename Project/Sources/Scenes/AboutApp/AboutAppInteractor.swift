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
	func getAboutApp(request: AboutAppModel.Request)
}

final class AboutAppInteractor: IAboutAppInteractor {

	// MARK: - Dependencies

	private var presenter: IAboutAppPresenter?

	// MARK: - Initialization

	init(presenter: IAboutAppPresenter) {
		self.presenter = presenter
	}

	// MARK: - Public methods
	func getAboutApp(request: AboutAppModel.Request) {
	// FIXME: Как будет понимание по модели, надо скорректировать
		let responce = AboutAppModel.Response(result: "")
		presenter?.present(responce: responce)
	}
}
