//
//  AboutAppAssembler.swift
//  MdEditor
//
//  Created by Руслан Мингалиев on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit

final class AboutAppAssembler {

	// MARK: - Public methods
	/// - Returns: view
	func assembly() -> AboutAppViewController {
		let viewController = AboutAppViewController()
		let presenter = AboutAppPresenter(viewController: viewController)
		let interactor = AboutAppInteractor(presenter: presenter)
		viewController.interactor = interactor

		return viewController
	}
}
