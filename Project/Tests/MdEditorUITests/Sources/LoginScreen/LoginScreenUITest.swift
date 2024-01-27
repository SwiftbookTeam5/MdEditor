//
//  LoginScreenUITest.swift
//  MdEditor
//
//  Created by Татьяна Исаева on 23.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//


import XCTest

final class LoginSceneUITest: XCTestCase {

	// swiftlint:disable implicitly_unwrapped_optional
	private var app: XCUIApplication!
	private var loginScreenObject: LoginScreenObject!
	// swiftlint:enable implicitly_unwrapped_optional

	// MARK: - Lifecycle

	override func setUp() {
		app = XCUIApplication()
		loginScreenObject = LoginScreenObject(app: app)
		super.setUp()
	}

	// MARK: - Public Methods

	func test_login_withValidCredentials_mustBeSuccess() {

		app.launch()

		loginScreenObject
			.isLoginScreen()
			.set(login: "Admin")
			.set(password: "pa$$32!")
			.login()

		XCTAssertFalse(
			app.tables[AccessibilityIdentifier.TodoList.tableView.description].exists,
			"Ошибка, после ввода корректного логина и пароля не произошел переход на следующий экран"
		)
	}

	func test_login_withInvalidCredentials_mustBeFailure() {

		app.launch()

		loginScreenObject
			.isLoginScreen()
			.set(login: "dmin")
			.set(password: "pass")
			.login()
			.isLoginScreen()

		XCTAssertFalse(
			app.tables[AccessibilityIdentifier.TodoList.tableView.description].exists,
			"Ошибка, после ввода некорректного логина и пароля произошел переход на другой экран"
		)
	}
}
