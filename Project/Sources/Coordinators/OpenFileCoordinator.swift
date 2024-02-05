//
//  OpenFileCoordinator.swift
//  MdEditor
//
//  Created by Александра Рязанова on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit

final class OpenFileCoordinator: ICoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private let fileExplorer: IFileExplorer
	private var path: String

	// MARK: - Initialization

	init(navigationController: UINavigationController, fileExplorer: IFileExplorer, path: String) {
		self.navigationController = navigationController
		self.fileExplorer = fileExplorer
		self.path = path
	}

	// MARK: - Internal methods

	func start() {
		showOpenFileScene()
	}

	private func showOpenFileScene() {
		let assembler = OpenFileAssembler(fileExplorer: fileExplorer)
		let viewController = assembler.assembly(path: path) { result in
			if case .success(let path) = result {
				self.path = path
				self.showOpenFileScene()
			}
		}

		navigationController.pushViewController(viewController, animated: true)
	}
}
