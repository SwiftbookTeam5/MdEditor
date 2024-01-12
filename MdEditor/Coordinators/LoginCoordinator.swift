//
//  LoginCoordinator.swift
//  MdEditor
//
//  Created by Татьяна Аникина on 12.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//


import UIKit

protocol ILoginCoordinator: ICoordinator {

	/// Метод для завершении сценария
	var finishFlow: (() -> Void)? { get set }
}

final class LoginCoordinator: ILoginCoordinator {

	// MARK: - Dependencies

	var navigationController: UINavigationController

	// MARK: - Internal properties

	var finishFlow: (() -> Void)?

	// MARK: - Initialization

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Internal methods

	func start() {
		showLoginScene()
	}

	func showLoginScene() {
		let viewController = LoginAssembler().assembly { [weak self] result in
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
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "Ок", style: .default)
		alert.addAction(action)
		navigationController.present(alert, animated: true, completion: nil)
	}
}
