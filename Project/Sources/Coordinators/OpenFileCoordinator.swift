//
//  OpenFileCoordinator.swift
//  MdEditor
//
//  Created by Александра Рязанова on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit
import FileManagerPackage

final class OpenFileCoordinator: ICoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private let fileExplorer: IFileExplorer
	private var url: URL?

	// MARK: - Initialization

	init(navigationController: UINavigationController, fileExplorer: IFileExplorer, url: URL?) {
		self.navigationController = navigationController
		self.fileExplorer = fileExplorer
		self.url = url
	}

	// MARK: - Internal methods

	func start() {
		showOpenFileScene()
	}

	private func showOpenFileScene() {
		let assembler = OpenFileAssembler(fileExplorer: fileExplorer)
		let viewController = assembler.assembly(url: url) { result in
			if case .success(let url) = result {
				self.url = url
				self.showOpenFileScene()
			}
		}

		navigationController.pushViewController(viewController, animated: true)
	}
}
