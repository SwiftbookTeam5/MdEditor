//
//  MainCoordinator.swift
//  MdEditor
//
//  Created by Александра Рязанова on 01.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit

final class MainCoordinator: ICoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private let fileRepository: IFileRepository

	// MARK: - Initialization

	init(navigationController: UINavigationController, fileRepository: IFileRepository) {
		self.navigationController = navigationController
		self.fileRepository = fileRepository
	}

	// MARK: - Internal methods

	func start() {
		showMainScene()
	}

	private func showMainScene() {
		let assembler = MainAssembler(fileRepository: fileRepository)
		let viewController = assembler.assembly()

		navigationController.pushViewController(viewController, animated: true)
	}
}
