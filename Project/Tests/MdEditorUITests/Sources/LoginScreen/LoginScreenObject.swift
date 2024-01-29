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
	private lazy var navigationBar = app.navigationBars.firstMatch
	private lazy var alert = app.alerts[L10n.AlertAuth.title]

	// MARK: - ScreenObject Methods

	@discardableResult
	func isLoginScreen() -> Self {
		let navigationBarTitle = navigationBar.staticTexts[L10n.Auth.title]
		
		assert(navigationBarTitle, [.exists])
		assert(textFieldPass, [.exists])
		assert(textFieldLogin, [.exists])
		assert(loginButton, [.exists])

		return self
	}

	// MARK: - ScreenObject methods

	/// Проверяет является ли текущий экран TodoList
	/// - Returns: сам объект self
	@discardableResult
	func isTodoListScreen() -> Self {
		let navigationBarTitle = navigationBar.staticTexts[L10n.TodoList.title]
		assert(navigationBarTitle, [.exists])

		return self
	}

	/// Проверяет появляется ли alert в ответ на ввод невалидных данных
	/// - Returns: сам объект self
	@discardableResult
	func isAlert() -> Self {
		assert(alert, [.exists])

		return self
	}

	/// Проверяет работает ли кнопка закрытия алерта
	/// - Returns: сам объект self
	@discardableResult
	func closeAlert() -> Self {
		let okAction = alert.buttons[L10n.AlertAuth.okActionTitle]
		
		assert(alert, [.exists])
		assert(okAction, [.exists])
		
		okAction.tap()

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

