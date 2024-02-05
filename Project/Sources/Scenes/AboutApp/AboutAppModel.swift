//
//  AboutAppModel.swift
//  MdEditor
//
//  Created by Руслан Мингалиев on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation

/// AboutApp является NameSpace для отделения ViewData различных экранов друг отдруга
enum AboutAppModel {

	struct Response {
		let result: String
	}

	struct ViewModel {
		let textAbout: String
	}
}
