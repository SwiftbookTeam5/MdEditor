//
//  SceneDelegate.swift
//  MdEditor
//
//  Created by Руслан Мингалиев on 23.12.2023.
//

import UIKit
import FileManagerPackage
import TaskManagerPackage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	private var appCoordinator: (ICoordinator & ITestCoordinator)! // swiftlint:disable:this implicitly_unwrapped_optional

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)

#if DEBUG
		let parameters = LaunchArguments.getParameters()
		let taskManager = TaskManagerBuilder().build(repository: TaskRepositoryStub())

		appCoordinator = AppCoordinator(
			window: window,
			taskManager: taskManager
		)

		if let enableTesting = parameters[LaunchArguments.enableTesting], enableTesting {
			UIView.setAnimationsEnabled(false)
		}

		appCoordinator.testStart(parameters: parameters)
#else
		let taskManager = TaskManagerBuilder().build(repository: TaskRepositoryStub())

		appCoordinator = AppCoordinator(
			window: window,
			taskManager: taskManager
		)

		appCoordinator.start()
#endif

		self.window = window
	}
}

func doInMainThread(_ work: @escaping () -> Void) {
	if Thread.isMainThread {
		work()
	} else {
		DispatchQueue.main.async(execute: work)
	}
}
