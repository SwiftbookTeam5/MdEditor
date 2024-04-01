//
//  LoginAssembler.swift
//  TodoList
//
//  Created by Kirill Leonov on 04.12.2023.
//

import UIKit

final class LoginAssembler {

	/// Сборка модуля авторизации
	/// - Parameter loginResultClosure: замыкание оповещающие о результате авторизации
	/// - Returns: view
	func assembly(
		authService: IAuthService,
		tokenPepository: ITokenPepository,
		loginResultClosure: LoginResultClosure?
	) -> LoginViewController {
		let viewController = LoginViewController()
		let presenter = LoginPresenter(viewController: viewController, loginResultClosure: loginResultClosure)
		let worker = LoginWorker(authService: authService, tokenPepository: tokenPepository)
		let interactor = LoginInteractor(presenter: presenter, worker: worker)
		viewController.interactor = interactor

		return viewController
	}
}
