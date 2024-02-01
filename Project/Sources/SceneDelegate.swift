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

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)

		var taskManager = buildTaskManager(repository: TaskRepositoryStub())

#if DEBUG
		if CommandLine.arguments.contains(LaunchArguments.enableTesting.rawValue) {
			taskManager = buildTaskManager(repository: TaskRepositoryTestingStub())
		}
#endif

		appCoordinator = AppCoordinator(window: window, taskManager: taskManager)
		appCoordinator.start()

		self.window = window
	}

	func buildTaskManager(repository: ITaskRepository) -> ITaskManager {
		let taskManager = TaskManager()
		let orderedTaskManager = OrderedTaskManager(taskManager: taskManager)
		orderedTaskManager.addTasks(tasks: repository.getTasks())

		return orderedTaskManager
	}
}
