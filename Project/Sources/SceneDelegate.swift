//
//  SceneDelegate.swift
//  MdEditor
//
//  Created by Руслан Мингалиев on 23.12.2023.
//

import UIKit
import TaskManagerPackage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	private var appCoordinator: ICoordinator! // swiftlint:disable:this implicitly_unwrapped_optional

	private let taskManager = TaskManager()
	private var repository: ITaskRepository = TaskRepositoryStub()

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)

#if DEBUG
		if CommandLine.arguments.contains(LaunchArguments.enableTesting.rawValue) {
			repository = TaskRepositoryTestingStub()
		}
#endif

		appCoordinator = AppCoordinator(window: window, taskManager: taskManager, repository: repository)
		appCoordinator.start()

		self.window = window
	}
}
