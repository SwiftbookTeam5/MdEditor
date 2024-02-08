//
//  LoginScreenUITest.swift
//  MdEditor
//
//  Created by Татьяна Исаева on 23.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest

final class LoginSceneUITest: XCTestCase {

	// MARK: - Internal methods

	func test_login_withValidCredentials_shouldBeNextScreenAppeared() {
		let sut = makeSut()

		sut
			.isLoginScreen()
			.set(login: ConfigureTestEnvironment.ValidCredentials.login)
			.set(password: ConfigureTestEnvironment.ValidCredentials.password)
			.login()
			.checkScreen(contains: L10n.Main.title)
	}

	func test_login_withInvalidCredentials_shouldBeAlertAppeared() {
		let sut = makeSut()

		sut
			.isLoginScreen()
			.set(login: ConfigureTestEnvironment.InvalidCredentials.login)
			.set(password: ConfigureTestEnvironment.InvalidCredentials.password)
			.login()
			.closeAlert()
			.isLoginScreen()
	}
}

// MARK: - TestData

private extension LoginSceneUITest {

	func makeSut() -> LoginScreenObject {
		let app = XCUIApplication()
		let screen = LoginScreenObject(app: app)

		app.launch()

		return screen
	}
}
