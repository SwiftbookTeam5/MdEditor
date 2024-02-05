//
//  AboutAppModel.swift
//  MdEditor
//
//  Created by Руслан Мингалиев on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit

/// AboutApp является NameSpace для отделения ViewData различных экранов друг отдруга
enum AboutAppModel {
	struct Request {
		var aboutApp: String
	}

	struct Response {
		let result: String
	}
	//TODO: Обновить модель, как будет известны данные в файле
	struct ViewModel {
			let textAbout: String
		}
	}
