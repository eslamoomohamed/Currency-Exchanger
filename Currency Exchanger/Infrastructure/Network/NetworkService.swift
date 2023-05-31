//
//  NetworkService.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

class NetworkService: NetworkServiceInterface {
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func execute(request: Request, completion: @escaping (Result<Data?, Error>) -> Void) {
        guard let urlRequest = prepareURLRequest(for: request) else {
            let error = NetworkError.badRequest
            completion(.failure(error))
            return
        }
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NetworkError.invalidResponse
                completion(.failure(error))
                return
            }
            
            let statusCode = httpResponse.statusCode
            if !(200...299).contains(statusCode) {
                let error = NetworkError.statusCodeError(statusCode)
                completion(.failure(error))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
    
    private func prepareURLRequest(for request: Request) -> URLRequest? {
        let fullUrl = "\(FixerIoApiConstants.baseUrl)/\(request.path)"
        guard let url = URL(string: fullUrl) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        
        switch request.parameters {
        case .body(let params):
            if let params {
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            }
        case .url(let params):
            if let params {
                guard var components = URLComponents(string: fullUrl) else {
                    return nil
                }
                
                let queryParams = params.map { param in
                    URLQueryItem(name: param.key, value: String(describing: param.value))
                }
                
                components.queryItems = queryParams
                urlRequest.url = components.url
            }
        }
        request.headers?.forEach { header in
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key.rawValue)
        }
        
        urlRequest.httpMethod = request.method.rawValue
        logCURLRequest(request: urlRequest, urlSession: session)
        return urlRequest
    }
    
    func logCURLRequest(request urlRequest: URLRequest, urlSession: URLSession) {
        guard let url = urlRequest.url,
              let host = url.host,
              let method = urlRequest.httpMethod else { return }
        
        var components = ["$ curl -v"]
        components.append("-X \(method)")
        if let credentialStorage = urlSession.configuration.urlCredentialStorage {
            let protectionSpace = URLProtectionSpace(host: host,
                                                     port: url.port ?? 0,
                                                     protocol: url.scheme,
                                                     realm: host,
                                                     authenticationMethod: NSURLAuthenticationMethodHTTPBasic)
            
            if let credentials = credentialStorage.credentials(for: protectionSpace)?.values {
                for credential in credentials {
                    guard let user = credential.user, let password = credential.password else { continue }
                    components.append("-u \(user):\(password)")
                }
            }
        }
        
        let configuration = urlSession.configuration
        if let cookieStorage = configuration.httpCookieStorage,
           let cookies = cookieStorage.cookies(for: url), !cookies.isEmpty {
            let allCookies = cookies.map { "\($0.name)=\($0.value)" }.joined(separator: ";")
            
            components.append("-b \"\(allCookies)\"")
        }
        
        var headers = [String: String]()
        
        if let sessionHeaders = urlRequest.allHTTPHeaderFields {
            for (key, value) in sessionHeaders {
                if key != "Cookie"{
                    headers[key] = value
                }
            }
            
        }
        
        for header in headers {
            let escapedValue = header.value.replacingOccurrences(of: "\"", with: "\\\"")
            components.append("-H \"\(header.key): \(escapedValue)\"")
        }
        
        if let httpBodyData = urlRequest.httpBody {
            let httpBody = String(decoding: httpBodyData, as: UTF8.self)
            var escapedBody = httpBody.replacingOccurrences(of: "\\\"", with: "\\\\\"")
            escapedBody = escapedBody.replacingOccurrences(of: "\"", with: "\\\"")
            
            components.append("-d \"\(escapedBody)\"")
        }
        components.append("\"\(url.absoluteString)\"")
        print(components.joined(separator: " \\\n\t"))
    }
    
    
}

enum NetworkError: Error {
    case badRequest
    case badInput
    case noData
    case wrongUrl
    case unAuthorized
    case invalidResponse
    case statusCodeError(Int)
}
