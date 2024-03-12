//
//  MainAssembler.swift
//  MdEditor
//
//  Created by Александра Рязанова on 01.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit

final class MainAssembler {

	/// Сборка модуля стартового экрана.
	/// - Returns: контроллер с проставленными зависимостями VIP цикла.
	func assembly(recentFileManager: IRecentFileManager, delegate: IMainDelegate) -> MainViewController {
		let viewController = MainViewController(collectionViewLayout: UICollectionViewLayout())
		let presenter = MainPresenter(viewController: viewController)

		let interactor = MainInteractor(
			presenter: presenter,
			recentFileManager: recentFileManager,
			delegate: delegate
		)
		viewController.interactor = interactor

		return viewController
	}
}
