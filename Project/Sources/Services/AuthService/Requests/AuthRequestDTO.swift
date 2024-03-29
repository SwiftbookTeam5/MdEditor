//
//  AuthRequestDTO.swift
//  MdEditor
//
//  Created by Александра Рязанова on 27.03.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation
import NetworkLayerPackage

/// Модель запроса авторизации
struct AuthRequestDTO: INetworkRequest {
	var path = "api/auth/login"
	var method = HTTPMethod.post
	var parameters: Parameters

	init(login: String, password: Password) {
		self.parameters = .json(
			[
				"login": login,
				"password": password.rawValue
			]
		)
	}
}
