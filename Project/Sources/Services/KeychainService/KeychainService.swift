//
//  KeychainService.swift
//  MdEditor
//
//  Created by Александра Рязанова on 27.03.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation

/// Ключи хранения в Keychain
enum KeychainKeys: String {
	case token
}

/// Сервис для хранения данных в Keychain
struct KeychainService {

	// MARK: - Private properties

	private let service: String
	private let account: String
	private var prefix: String

	private var accountWithPrefix: String {
		prefix + account
	}

	// MARK: - Init

	/// Инициализация Keychain сервиса
	/// - Parameters:
	///   - service: строка, которая определяет службу или приложение
	///   - account: строка, идентифицирующая сущность для хранения
	///   - prefix: префикс для account, может использоваться в тестах
	init(service: String, account: String, prefix: String = "") {
		self.service = service
		self.account = account
		self.prefix = prefix
	}

	/// Инициализация Keychain сервиса с bundleIdentifier
	/// - Parameters:
	///   - key: ключ идентифицирующий сущность для хранения
	///   - prefix: рефикс для account, может использоваться в тестах
	init(key: KeychainKeys, prefix: String = "") {
		self.service = Bundle.main.bundleIdentifier ?? ""
		self.account = key.rawValue
		self.prefix = prefix
	}

	// MARK: - Internal methods

	/// Получение данных из Keychain
	/// - Returns: строка
	func fetch() -> String? {
		let query: [CFString: Any] = [
			kSecAttrService: service,
			kSecAttrAccount: accountWithPrefix,
			kSecReturnData: true,
			kSecClass: kSecClassGenericPassword,
			kSecMatchLimit: kSecMatchLimitOne
		]

		var dataTypeRef: AnyObject?
		let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

		if status == errSecSuccess, let data = dataTypeRef as? Data {
			return String(data: data, encoding: .utf8)
		} else {
			return nil
		}
	}

	/// Добавление данные в Keychain
	/// - Parameter value: значение
	/// - Returns: результат выполнения операции
	@discardableResult
	func save(value: String) -> Bool {
		guard let data = value.data(using: .utf8) else { return false }

		let keychainItems: [CFString: Any] = [
			kSecAttrService: service,
			kSecAttrAccount: accountWithPrefix,
			kSecValueData: data,
			kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
			kSecClass: kSecClassGenericPassword
		]

		let status = SecItemAdd(keychainItems as CFDictionary, nil)

		return status == errSecSuccess
	}

	/// Обновление данных в Keychain
	/// - Parameter value: значение
	/// - Returns: результат выполнения операции
	@discardableResult
	func update(value: String) -> Bool {
		guard let data = value.data(using: .utf8) else { return false }

		let query: [CFString: Any] = [
			kSecAttrService: service,
			kSecAttrAccount: accountWithPrefix,
			kSecClass: kSecClassGenericPassword
		]

		let field: [CFString: Any] = [
			kSecValueData: data
		]

		let status = SecItemUpdate(query as CFDictionary, field as CFDictionary)

		return status == errSecSuccess
	}

	/// Удаление данных из Keychain
	/// - Returns: результат выполнения операции
	@discardableResult
	func delete() -> Bool {
		let query: [CFString: Any] = [
			kSecAttrService: service,
			kSecAttrAccount: accountWithPrefix,
			kSecClass: kSecClassGenericPassword
		]

		let status = SecItemDelete(query as CFDictionary)

		return status == errSecSuccess
	}
}
