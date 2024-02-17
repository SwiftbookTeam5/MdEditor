//
//  ITestCoordinator.swift
//  MdEditor
//
//  Created by Дмитрий Лубов on 15.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

/// Протокол Координатора для работы в режиме дебага
protocol ITestCoordinator {

	/// Запускает флоу в зависимости от переданных параметров
	/// - Parameter parameters: параметры запуска приложения
	func testStart(parameters: [LaunchArguments: Bool])
}
