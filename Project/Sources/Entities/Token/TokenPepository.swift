//
//  TokenPepository.swift
//  MdEditor
//
//  Created by Александра Рязанова on 27.03.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation
import NetworkLayerPackage

/// Протокол для работы с токеном
protocol ITokenPepository {
	/// Получение токена аторизации
	/// - Returns: токен
	func getToken() -> Token?
	/// Установка токена аторизации
	/// - Parameter token: токен
	func setToken(_ token: Token)
}

/// Класс для работы с токеном
final class TokenPepository: ITokenPepository {

	// MARK: - Private methods

	private let keychainService = KeychainService(key: .token)

	// MARK: - Internal methods

	/// Получение токена аторизации
	/// - Returns: токен
	func getToken() -> Token? {
		guard let value = keychainService.fetch() else { return nil }
		return Token(rawValue: value)
	}

	/// Установка токена аторизации
	/// - Parameter token: токен
	func setToken(_ token: Token) {
		if keychainService.fetch() == nil {
			keychainService.save(value: token.rawValue)
		} else {
			keychainService.update(value: token.rawValue)
		}
	}
}
