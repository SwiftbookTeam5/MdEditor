//
//  SceneDelegate.swift
//  MdEditor
//
//  Created by Руслан Мингалиев on 23.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	private var appCoordinator: ICoordinator! // swiftlint:disable:this implicitly_unwrapped_optional

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)

		let taskBuilder = TaskManagerBuilder()
		var taskManager = taskBuilder.build(repository: TaskRepositoryStub())

#if DEBUG
		if CommandLine.arguments.contains(LaunchArguments.enableTesting.rawValue) {
			taskManager = taskBuilder.build(repository: TaskRepositoryTestingStub())
		}
#endif

		appCoordinator = AppCoordinator(window: window, taskManager: taskManager)
		appCoordinator.start()

		self.window = window
	}
}
