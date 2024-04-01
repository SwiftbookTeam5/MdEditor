//
//  NetworkService.swift
//  NetworkLayer
//
//  Created by Kirill Leonov 
//

import Foundation

/// Протокол сервиса, выполняющего сетевые запросы
public protocol INetworkService {

	/// Выполнение сетевого запроса с декодированием в модель
	/// - Parameters:
	///   - request: данные запроса
	///   - token: токен авторизации
	///   - completion: результат выполнения запроса
	func perform<T: Codable>(
		_ request: INetworkRequest,
		token: Token?,
		completion: @escaping (Result<T, HTTPNetworkServiceError>) -> Void
	)

	/// Выполнение сетевого запроса с декодированием в модель
	/// - Parameters:
	///   - request: данные запроса
	///   - token: токен авторизации
	///   - completion: результат выполнения запроса
	func perform(
		_ request: INetworkRequest,
		token: Token?,
		completion: @escaping (Result<Data?, HTTPNetworkServiceError>) -> Void
	)

	/// Выполнение сетевого запроса с декодированием в Data
	/// - Parameters:
	///   - urlRequest: запрос
	///   - completion: результат выполнения запроса
	func perform(
		urlRequest: URLRequest,
		completion: @escaping (Result<Data?, HTTPNetworkServiceError>) -> Void
	)

	/// Выполнение сетевого запроса загрузки файла
	/// - Parameters:
	///   - request: данные запроса
	///   - token: токен авторизации
	///   - completion: результат выполнения запроса
	func download(
		_ request: INetworkRequest,
		token: Token?,
		completion: @escaping (Result<URL?, HTTPNetworkServiceError>) -> Void
	)
	
	/// Выполнение сетевого запроса загрузки файла
	/// - Parameters:
	///   - urlRequest: запрос
	///   - completion: результат выполнения запроса
	func download(
		urlRequest: URLRequest,
		completion: @escaping (Result<URL?, HTTPNetworkServiceError>) -> Void
	)
}

/// Сервис, выполняющий сетевые запросы
public final class NetworkService: INetworkService {

	// MARK: - Private properties

	private let session: URLSession
	private let requestBuilder: URLRequestBuilder

	// MARK: - Init

	/// Инициализация сетевого сервиса
	/// - Parameters:
	///   - session: URL сессия
	///   - baseUrl: Базовый URL сервиса для которого будут создаваться запросы.
	public init(session: URLSession, baseUrl: URL) {
		self.session = session
		requestBuilder = URLRequestBuilder(baseUrl: baseUrl)
	}

	// MARK: - Public methods

	/// Выполнение сетевого запроса с декодированием в модель
	/// - Parameters:
	///   - request: данные запроса
	///   - token: токен авторизации
	///   - completion: результат выполнения запроса
	public func perform<T: Codable>(
		_ request: INetworkRequest,
		token: Token?,
		completion: @escaping (Result<T, HTTPNetworkServiceError>) -> Void
	) {
		let urlRequest = requestBuilder.build(forRequest: request, token: token)
		perform(urlRequest: urlRequest) { result in
			switch result {
			case let .success(data):
				guard let data = data else {
					completion(.failure(.noData))
					return
				}
				do {
					let object = try JSONDecoder().decode(T.self, from: data)
					completion(.success(object))
				} catch {
					completion(.failure(.failedToDecodeResponse(error)))
				}
			case let .failure(error):
				completion(.failure(error))
			}
		}
	}
	
	/// Выполнение сетевого запроса с декодированием в модель
	/// - Parameters:
	///   - request: данные запроса
	///   - token: токен авторизации
	///   - completion: результат выполнения запроса
	public func perform(
		_ request: INetworkRequest,
		token: Token?,
		completion: @escaping (Result<Data?, HTTPNetworkServiceError>) -> Void
	) {
		let urlRequest = requestBuilder.build(forRequest: request, token: token)
		perform(urlRequest: urlRequest, completion: completion)
	}
	
	/// Выполнение сетевого запроса с декодированием в Data
	/// - Parameters:
	///   - urlRequest: запрос
	///   - completion: результат выполнения запроса
	public func perform(
		urlRequest: URLRequest,
		completion: @escaping (Result<Data?, HTTPNetworkServiceError>) -> Void
	) {
		let task = session.dataTask(with: urlRequest) { data, urlResponse, error in
			let networkResponse = NetworkResponse(data: data, urlResponse: urlResponse, error: error)
			completion(networkResponse.result)
		}
		task.resume()
	}
	
	/// Выполнение сетевого запроса загрузки файла
	/// - Parameters:
	///   - request: данные запроса
	///   - token: токен авторизации
	///   - completion: результат выполнения запроса
	public func download(
		_ request: INetworkRequest,
		token: Token?,
		completion: @escaping (Result<URL?, HTTPNetworkServiceError>) -> Void
	) {
		let urlRequest = requestBuilder.build(forRequest: request, token: token)
		download(urlRequest: urlRequest, completion: completion)
	}
	
	/// Выполнение сетевого запроса загрузки файла
	/// - Parameters:
	///   - urlRequest: запрос
	///   - completion: результат выполнения запроса
	public func download(
		urlRequest: URLRequest,
		completion: @escaping (Result<URL?, HTTPNetworkServiceError>) -> Void
	) {
		let task = session.downloadTask(with: urlRequest) { tempURL, urlResponse, error in
			guard let urlResponse = urlResponse as? HTTPURLResponse else {
				completion(.failure(.invalidResponse(urlResponse)))
				return
			}
			guard let status = ResponseStatus(rawValue: urlResponse.statusCode), status.isSuccess else {
				completion( .failure(.invalidStatusCode(urlResponse.statusCode, nil)))
				return
			}
			if let error = error {
				completion(.failure(.networkError(error)))
			} else {
				completion(.success(tempURL))
			}
		}
		task.resume()
	}
}
