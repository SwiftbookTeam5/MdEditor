//
//  LaunchArguments.swift
//  MdEditor
//
//  Created by Александра Рязанова on 30.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation

enum LaunchArguments: String {
	case enableTesting = "-enableTesting"
	case appleLanguages = "-AppleLanguages"
	case startTodoList = "-startTodoList"

	static func getParameters() -> [LaunchArguments: Bool] {
		var parameters: [LaunchArguments: Bool] = [:]

		for argument in CommandLine.arguments {
			if let parameter = LaunchArguments(rawValue: argument) {
				parameters[parameter] = true
			}
		}

		return parameters
	}
}
