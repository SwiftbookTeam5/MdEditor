//
//  LoginScreenObject.swift
//  TodoListUITests
//
//  Created by Татьяна Исаева on 23.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.

import XCTest

final class LoginScreenObject: BaseScreenObject {

	// MARK: - Private properties

	private lazy var textFieldLogin = app.textFields[AccessibilityIdentifier.Login.textFieldLogin.description]
	private lazy var textFieldPass = app.secureTextFields[AccessibilityIdentifier.Login.textFieldPass.description]
	private lazy var loginButton = app.buttons[AccessibilityIdentifier.Login.buttonLogin.description]

	// MARK: - ScreenObject Methods

	@discardableResult
	func isLoginScreen() -> Self {
		assert(textFieldPass, [.exists])
		assert(textFieldLogin, [.exists])
		assert(loginButton, [.exists])

		return self
	}

	@discardableResult
	func set(password: String) -> Self {
		assert(textFieldPass, [.exists])
		textFieldPass.tap()
		textFieldPass.typeText(password)

		return self
	}

	@discardableResult
	func set(login: String) -> Self {
		assert(textFieldLogin, [.exists])
		textFieldLogin.tap()
		textFieldLogin.typeText(login)

		return self
	}

	@discardableResult
	func login() -> Self {
		assert(loginButton, [.exists])
		loginButton.tap()

		return self
	}
}

