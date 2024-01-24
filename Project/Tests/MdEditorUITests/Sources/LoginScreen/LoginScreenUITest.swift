//
//  LoginScreenUITest.swift
//  MdEditor
//
//  Created by Татьяна Исаева on 23.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest

class LoginScreenUITest: XCTestCase {

	override func tearDown() {
		let screenshot = XCUIScreen.main.screenshot()
		let fullscreenchotAttachment = XCTAttachment(screenshot: screenshot)
		fullscreenchotAttachment.name = "Fail test"
		fullscreenchotAttachment.lifetime = .deleteOnSuccess
		add(fullscreenchotAttachment)
	}

	func test_login_withValidCred_mustBeSuccess() {
		let app = XCUIApplication()
		let loginScreen = LoginScreenObject(app: app)
		app.launch()

		loginScreen
			.isLoginScreen()
			.set(password: "pa$$32!")
			.set(login: "Admin")
			.login()
	}
}
