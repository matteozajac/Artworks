@testable import Artworks
import XCTest

final class AICEndpointTests: XCTestCase {
    func test_endpoints() throws {
        let sut = AICEndpoint(host: URL(string: "https://a-test.com")!)
        XCTAssertEqual(sut.artworks()?.absoluteString, "https://a-test.com/artworks?limit=100")
        XCTAssertEqual(AICEndpoint.image(imageID: "1234")?.absoluteString, "https://www.artic.edu/iiif/2/1234/full/843,/0/default.jpg")
    }
}
