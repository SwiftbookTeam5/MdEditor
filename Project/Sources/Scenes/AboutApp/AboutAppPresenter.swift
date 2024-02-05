//
//  AboutAppPresenter.swift
//  MdEditor
//
//  Created by Руслан Мингалиев on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation

protocol IAboutAppPresenter {

	/// Отображение экрана со авторизации.
	/// - Parameter response: Подготовленные к отображению данные.
	func present(responce: AboutAppModel.Response)
}

final class AboutAppPresenter: IAboutAppPresenter {

	// MARK: - Dependencies

	private weak var viewController: IAboutAppViewController?

	// MARK: - Initialization

	init(viewController: IAboutAppViewController?) {
		self.viewController = viewController
	}

	// MARK: - Public methods

	/// Отображение экрана "О Приложении".
	/// - Parameter response: Подготовленные к отображению данные.
	func present(responce: AboutAppModel.Response) {
		let section = AboutAppModel.ViewModel(
	//FIXME: Заплатка т.к не известна модель данных. Поправить как будет известны данные
			textAbout: "Team5"
		)

		viewController?.render(viewModel: section)
	}
}
