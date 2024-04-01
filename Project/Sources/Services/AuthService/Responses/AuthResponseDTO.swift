//
//  AuthResponseDTO.swift
//  MdEditor
//
//  Created by Александра Рязанова on 27.03.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation

/// Модель ответа по аторизации
struct AuthResponseDTO: Codable {
	let token: String

	enum CodingKeys: String, CodingKey {
		case token = "access_token"
	}
}
