@testable import Artworks
import XCTest

final class AICArtworkRemoteDataSourceTests: XCTestCase {
    private var sut: AICArtworkRemoteDataSource!
    private var httpClientMock: HTTPClientMock!

    override func setUp() {
        httpClientMock = HTTPClientMock()
        sut = AICArtworkRemoteDataSource(httpClient: httpClientMock, host: URL(string: "https://a-test.com")!)
    }

    override func tearDown() {
        httpClientMock = nil
        sut = nil
    }

    func test_init_shouldNotMakeHTTPRequests() throws {
        XCTAssertEqual(httpClientMock.getCompletionCalled, false)
    }

    func test_getList_shouldMakeHTTPGetRequestOnce() throws {
        httpClientMock.getCompletionClosure = { _, completion in completion(.success(anyHttpResult(""))) }
        let exp = expectation(description: "expectation")

        sut.getList { _ in
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(httpClientMock.getCompletionCallsCount, 1)
    }

    func test_getList_whenReceives500StatusCode_shouldCompleteWithError() throws {
        httpClientMock.getCompletionClosure = { _, completion in completion(.success((anyData(), anyResponse(500)))) }
        let exp = expectation(description: "expectation")

        var capturedError: HTTPClientError?
        sut.getList { result in
            switch result {
            case let .failure(error): capturedError = error as? HTTPClientError
            case .success: ()
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(capturedError, HTTPClientError.serverError)
    }

    func test_getList_whenReceives200StatusCode_shouldCompleteWithArtworks() throws {
        let data = try getData(fromJSON: "aic_artwork_list")
        httpClientMock.getCompletionClosure = { _, completion in completion(.success((data, anyResponse(200)))) }
        let exp = expectation(description: "expectation")

        var capturedArtworks: [Artwork]?
        sut.getList { result in
            switch result {
            case .failure: ()
            case let .success(artworks): capturedArtworks = artworks
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(capturedArtworks?.count, 3)
        XCTAssertEqual(capturedArtworks?.first?.objectID, 26779)
        XCTAssertEqual(capturedArtworks?.first?.title, "Woman")
        XCTAssertEqual(capturedArtworks?.first?.artistDisplayName, "Allen Jones\nEnglish, born 1937")
        XCTAssertEqual(capturedArtworks?.first?.primaryImageSmall?.absoluteString, "https://www.artic.edu/iiif/2/55ac04d1-1fd0-f618-9ad1-e7a8662e3448/full/843,/0/default.jpg")
        XCTAssertEqual(capturedArtworks?.first?.styleTitle, nil)
        XCTAssertEqual(capturedArtworks?.first?.hexColor, "#FEFCFB")
    }

    func test_getList_whenReceivesError_shouldCompleteWithError() throws {
        httpClientMock.getCompletionClosure = { _, completion in completion(.failure(HTTPClientError.invalidData)) }
        let exp = expectation(description: "expectation")

        var capturedError: HTTPClientError?
        sut.getList { result in
            switch result {
            case let .failure(error): capturedError = error as? HTTPClientError
            case .success: ()
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(capturedError, HTTPClientError.invalidData)
    }
}
