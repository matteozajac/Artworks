import Foundation

class URLSessionHTTPClient: HTTPClient {
    private let urlSession = URLSession.shared

    func get(_ url: URL?, completion: @escaping Completion) {
        guard let url else { completion(.failure(HTTPClientError.invalidURL)); return }
        urlSession.dataTask(with: url) { data, urlResponse, error in
            if let error {
                completion(.failure(error))
            } else if let data, let urlResponse {
                completion(.success((data, urlResponse)))
            }
        }.resume()
    }
}
