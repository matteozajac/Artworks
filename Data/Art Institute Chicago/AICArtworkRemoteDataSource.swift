import Foundation

/// Art Inistitute of Chicago
/// https://api.artic.edu/docs/
final class AICArtworkRemoteDataSource: ArtworkRepository {
    private let httpClient: HTTPClient
    private let endpoint: AICEndpoint

    init(httpClient: HTTPClient, host: URL) {
        self.httpClient = httpClient
        endpoint = AICEndpoint(host: host)
    }

    func getList(completion: @escaping ListCompletion) {
        httpClient.get(endpoint.artworks()) { result in
            do {
                switch result {
                case let .success((data, urlResponse)):
                    if let httpUrlResponse = urlResponse as? HTTPURLResponse, (500 ... 599).contains(httpUrlResponse.statusCode) {
                        completion(.failure(HTTPClientError.serverError))
                        return
                    }
                    let aicResponse = try JSONDecoder().decode(AICResponse.self, from: data)
                    let artworks = aicResponse.data.map(AICMapper.toArtwork)
                    completion(.success(artworks))
                case let .failure(error):
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(HTTPClientError.invalidData))
            }
        }
    }
}
