//
//  LoginWorker.swift
//  TodoList
//
//  Created by Kirill Leonov on 04.12.2023.
//

import Foundation
import NetworkLayerPackage

protocol ILoginWorker {

	/// Авторизация пользователя.
	/// - Parameters:
	///   - login: Логин пользователя.
	///   - password: Пароль пользователя.
	/// - Returns: Результат прохождения авторизации.
	func login(login: String, password: String) -> Result<Void, LoginError>

	/// Авторизация пользователя.
	/// - Parameters:
	///   - login: Логин пользователя.
	///   - password: Пароль пользователя.
	///   - completion: Результат прохождения авторизации.
	func login(login: String, password: String, completion: @escaping (Result<Void, LoginError>) -> Void)
}

enum LoginError: Error {
	case wrongPassword
	case wrongLogin
	case errorAuth
	case emptyFields
}

final class LoginWorker: ILoginWorker {

	// MARK: - Dependencies

	private var authService: IAuthService
	private var tokenPepository: ITokenPepository

	// MARK: - Private properties

	private let validLogin = "Admin"
	private let validPassword = "pa$$32!"

	/// Инициализация
	/// - Parameters:
	///   - authService: сервис аторизации
	///   - tokenPepository: репозиторий хранения токена
	init(authService: IAuthService, tokenPepository: ITokenPepository) {
		self.authService = authService
		self.tokenPepository = tokenPepository
	}

	// MARK: - Public methods

	/// Авторизация пользователя.
	/// - Parameters:
	///   - login: Логин пользователя.
	///   - password: Пароль пользователя.
	/// - Returns: Результат прохождения авторизации.
	func login(login: String, password: String) -> Result<Void, LoginError> {
		guard !login.isEmpty, !password.isEmpty else { return .failure(.emptyFields) }

		switch (login == validLogin, password == validPassword) {
		case (true, true):
			return .success(())
		case (false, true):
			return .failure(.wrongLogin)
		case (true, false):
			return .failure(.wrongPassword)
		case (false, false):
			return .failure(.errorAuth)
		}
	}

	/// Авторизация пользователя.
	/// - Parameters:
	///   - login: Логин пользователя.
	///   - password: Пароль пользователя.
	///   - completion: Результат прохождения авторизации.
	func login(login: String, password: String, completion: @escaping (Result<Void, LoginError>) -> Void) {
		guard !login.isEmpty, !password.isEmpty else {
			completion(.failure(.emptyFields))
			return
		}

		authService.login(login: login, password: Password(rawValue: password)) { [weak self] result in
			switch result {
			case .success(let response):
				self?.tokenPepository.setToken(Token(rawValue: response.token))
				completion(.success(()))
			case .failure:
				if login == self?.validLogin, password == self?.validPassword {
					completion(.success(()))
				} else {
					completion(.failure(.errorAuth))
				}
			}
		}
	}
}
