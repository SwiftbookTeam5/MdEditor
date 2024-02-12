//
//  ConfigureTestEnvironment.swift
//  MdEditorUITests
//
//  Created by Дмитрий Лубов on 08.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

enum ConfigureTestEnvironment {

	enum ValidCredentials {
		static let login = "Admin"
		static let password = "pa$$32!"
	}

	enum InvalidCredentials {
		static let login = "pa$$32!"
		static let password = "Admin"
	}
}
