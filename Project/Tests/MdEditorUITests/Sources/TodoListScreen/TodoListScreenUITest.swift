//
//  TodoListScreenUITest.swift
//  MdEditorUITests
//
//  Created by Руслан Мингалиев on 28.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest

final class TodoListScreenUITest: XCTestCase {

	// MARK: - Private properties

	private let app = XCUIApplication()

	// MARK: - Lifecycle

	override func setUp() {
		let loginScreenObject = LoginScreenObject(app: app)

		app.launchArguments = [LaunchArguments.enableTesting.rawValue]
		app.launch()

		loginScreenObject
			.isLoginScreen()
			.set(login: "Admin")
			.set(password: "pa$$32!")
			.login()
	}
	
	override func tearDown() {
		let screenshot = XCUIScreen.main.screenshot()
		let fullScreenshotAttachment = XCTAttachment(screenshot: screenshot)
		fullScreenshotAttachment.name = "Fail TodoListScreenUITest"
		fullScreenshotAttachment.lifetime = .deleteOnSuccess
		add(fullScreenshotAttachment)
	}

	// MARK: - Internal methods

	func test_valid_change_status_Task_() {
		let todoListScreenObject = TodoListScreenObject(app: app)

		todoListScreenObject
			.isTodoList()
			.changeTaskStatusIn(section: 0, row: 1)
			.changeTaskStatusIn(section: 0, row: 1)
			.changeTaskStatusIn(section: 0, row: 1)
			.changeTaskStatusIn(section: 1, row: 0)
	}

	func test_valid_numberOfSections_and_nameSections() {
		let todoListScreenObject = TodoListScreenObject(app: app)

		todoListScreenObject
			.isTodoList()
			.getTitleForHeaderIn(section: 0)
			.getTitleForHeaderIn(section: 1)
	}

	func test_valid_data_task_in_section() {
		let todoListScreenObject = TodoListScreenObject(app: app)

		todoListScreenObject
			.isTodoList()
			.getTitleForTaskIn(section: 0, row: 0)
	}
}
