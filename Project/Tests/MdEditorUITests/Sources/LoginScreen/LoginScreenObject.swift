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

	/// Проверяет является ли текущий экран авторизацией
	/// - Returns: сам объект self
	@discardableResult
	func isLoginScreen() -> Self {
		checkScreen(contains: L10n.Auth.title)
		assert(textFieldPass, [.exists])
		assert(textFieldLogin, [.exists])
		assert(loginButton, [.exists])

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

	/// Устанавливает пароль
	/// - Parameter password: пароль
	/// - Returns: сам объект self
	@discardableResult
	func set(password: String) -> Self {
		assert(textFieldPass, [.exists])
		textFieldPass.tap()
		textFieldPass.typeText(password)

		return self
	}

	/// Устанавливает логин
	/// - Parameter login: логин
	/// - Returns: сам объект self
	@discardableResult
	func set(login: String) -> Self {
		assert(textFieldLogin, [.exists])
		textFieldLogin.tap()
		textFieldLogin.typeText(login)

		return self
	}

	/// Выполняет авторизацию
	/// - Returns: сам объект self
	@discardableResult
	func login() -> Self {
		assert(loginButton, [.exists])
		loginButton.tap()

		return self
	}

	/// Проверяет заголовок экрана
	/// - Parameter title: заголовок проверяемого экрана
	/// - Returns: сам объект self
	@discardableResult
	func checkScreen(contains title: String) -> Self {
		let screenTitle = navigationBar.staticTexts[title]
		assert(screenTitle, [.exists])

		return self
	}
}
