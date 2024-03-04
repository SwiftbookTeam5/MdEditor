//
//  OpenFileCoordinator.swift
//  MdEditor
//
//  Created by Александра Рязанова on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit
import FileManagerPackage

final class FileManagerCoordinator: NSObject, ICoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private var topViewController: UIViewController?

	// MARK: - Internal properties

	var finishFlow: (() -> Void)?

	// MARK: - Initialization

	init(navigationController: UINavigationController, topViewController: UIViewController?) {
		self.navigationController = navigationController
		self.topViewController = topViewController

		super.init()

		navigationController.delegate = self
	}

	// MARK: - Internal methods

	func start() {
		showFileManagerScene(file: nil)
	}
}

// MARK: - Private methods

private extension FileManagerCoordinator {

	func showFileManagerScene(file: File?) {
		let viewController = FileManagerAssembler().assembly(
			fileExplorer: FileExplorer(),
			delegate: self,
			file: file
		)

		navigationController.pushViewController(viewController, animated: true)
	}

	func showTextPreviewScene(file: File) {
		let viewController = TextPreviewAssembler().assembly(file: file)
		navigationController.pushViewController(viewController, animated: true)
	}
}

// MARK: - UINavigationControllerDelegate

extension FileManagerCoordinator: UINavigationControllerDelegate {

	func navigationController(
		_ navigationController: UINavigationController,
		didShow viewController: UIViewController,
		animated: Bool
	) {
		if viewController === topViewController {
			finishFlow?()
		}
	}
}

// MARK: - IFileManagerDelegate

extension FileManagerCoordinator: IFileManagerDelegate {

	func openFolder(file: File) {
		showFileManagerScene(file: file)
	}

	func openFile(file: File) {
		showTextPreviewScene(file: file)
	}
}
