//
//  LoginScreenUITest.swift
//  MdEditor
//
//  Created by Татьяна Исаева on 23.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest

final class LoginSceneUITest: XCTestCase {

	// MARK: - Private properties

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

	override func tearDown() {
		let screenshot = XCUIScreen.main.screenshot()
		let fullScreenshotAttachment = XCTAttachment(screenshot: screenshot)
		fullScreenshotAttachment.name = "Fail LoginSceneUITest"
		fullScreenshotAttachment.lifetime = .deleteOnSuccess
		add(fullScreenshotAttachment)
	}

	// MARK: - Internal methods

	func test_login_withValidCredentials_mustBeSuccess() {

		app.launch()

		loginScreenObject
			.isLoginScreen()
			.set(login: "Admin")
			.set(password: "pa$$32!")
			.login()
			.isTodoListScreen()
	}

	func test_login_withInvalidCredentials_mustBeFailure() {

		app.launch()

		loginScreenObject
			.isLoginScreen()
			.set(login: "dmin")
			.set(password: "a$$")
			.login()
			.isAlert()
			.closeAlert()
			.isLoginScreen()
	}
}
