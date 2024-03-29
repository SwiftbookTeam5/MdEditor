//
//  LoginCoordinator.swift
//  MdEditor
//
//  Created by Татьяна Исаева on 12.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit
import NetworkLayerPackage

protocol ILoginCoordinator: ICoordinator {

	/// Метод для завершении сценария
	var finishFlow: (() -> Void)? { get set }
}

final class LoginCoordinator: ILoginCoordinator {

	// MARK: - Dependencies

	private var navigationController: UINavigationController
	private var tokenPepository: ITokenPepository = TokenPepository()
	private var networkService: INetworkService
	private var authService: IAuthService

	// MARK: - Internal properties

	var finishFlow: (() -> Void)?

	// MARK: - Initialization

	init(navigationController: UINavigationController, networkService: INetworkService) {
		self.navigationController = navigationController
		self.networkService = networkService
		authService = AuthService(networkService: networkService, tokenPepository: tokenPepository)
	}

	// MARK: - Internal methods

	func start() {
		showLoginScene()
	}

	func showLoginScene() {
		let viewController = LoginAssembler().assembly(
			authService: authService,
			tokenPepository: tokenPepository
		) { [weak self] result in
			switch result {
			case .success:
				self?.finishFlow?()
			case .failure(let error):
				self?.showError(message: error.localizedDescription)
			}
		}
		navigationController.pushViewController(viewController, animated: true)
	}

	func showError(message: String) {
		let alert = UIAlertController(title: L10n.Error.text, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: L10n.Ok.text, style: .default)
		alert.addAction(action)
		navigationController.present(alert, animated: true, completion: nil)
	}
}
