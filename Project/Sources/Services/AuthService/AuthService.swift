//
//  AuthService.swift
//  MdEditor
//
//  Created by Александра Рязанова on 27.03.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation
import NetworkLayerPackage

protocol IAuthService {

	/// Авторизация
	/// - Parameters:
	///   - login: логин
	///   - password: пароль
	///   - completion: результат
	func login(
		login: String,
		password: Password,
		completion: @escaping (Result<AuthResponseDTO, HTTPNetworkServiceError>) -> Void
	)
}

final class AuthService: IAuthService {

	// MARK: - Private properties

	private let networkService: INetworkService
	private let tokenPepository: ITokenPepository

	// MARK: - Init

	/// Инициализация сервиса авторизации
	/// - Parameters:
	///   - networkService: сетевой сервис
	///   - tokenPepository: репозиторий хранения токена
	init(networkService: INetworkService, tokenPepository: ITokenPepository) {
		self.networkService = networkService
		self.tokenPepository = tokenPepository
	}

	// MARK: - Internal methods

	/// Авторизация
	/// - Parameters:
	///   - login: логин
	///   - password: пароль
	///   - completion: результат
	func login(
		login: String,
		password: Password,
		completion: @escaping (Result<AuthResponseDTO, HTTPNetworkServiceError>) -> Void
	) {
		let request = AuthRequestDTO(login: login, password: password)
		networkService.perform(request, token: nil, completion: completion)
	}
}
