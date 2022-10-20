import Foundation

struct AICEndpoint {
    private let host: URL
    private let LIST_LIMIT = 100

    init(host: URL) {
        self.host = host
    }

    func artworks() -> URL? {
        host.appending(path: "artworks").appending(queryItems: [URLQueryItem(name: "limit", value: String(LIST_LIMIT))])
    }

    static func image(imageID: String?) -> URL? {
        guard let imageID else { return nil }
        return URL(string: "https://www.artic.edu/iiif/2/\(imageID)/full/843,/0/default.jpg")
    }
}
