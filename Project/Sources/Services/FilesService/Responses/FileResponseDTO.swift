//
//  FileResponseDTO.swift
//  MdEditor
//
//  Created by Александра Рязанова on 26.03.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation

struct FileResponseDTO: Codable {
	let id: String
	let hash: String
	let originalName: String
	let contentType: String
	let size: Int
	let createdAt: String
	let updatedAt: String
	let version: Int
	let url: String

	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case hash
		case originalName
		case contentType
		case size
		case createdAt
		case updatedAt
		case version = "__v"
		case url
	}
}
