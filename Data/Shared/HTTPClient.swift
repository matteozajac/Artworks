import Foundation

protocol HTTPClient {
    typealias Completion = (Result<(Data, URLResponse), Error>) -> Void

    func get(_ url: URL?, completion: @escaping Completion)
}
