//
//  File.swift
//  MdEditor
//
//  Created by Александра Рязанова on 03.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation

class File {
	let name: String
	let creationDate: Date
	var modifiationData: Date

	init(name: String, creationDate: Date, modifiationData: Date) {
		self.name = name
		self.creationDate = creationDate
		self.modifiationData = modifiationData
	}
}
