@testable import Artworks
import XCTest

final class LoadArtworkInteractorTests: XCTestCase {
    private var sut: LoadArtworkInteractor!

    private var artworkRepositoryMock: ArtworkRepositoryMock!

    override func setUp() {
        artworkRepositoryMock = ArtworkRepositoryMock()
        sut = LoadArtworkInteractor(remoteArtworkRepository: artworkRepositoryMock)
    }

    override func tearDown() {
        sut = nil
        artworkRepositoryMock = nil
    }

    func test_init_shouldNotCallArtworkRepository() {
        XCTAssertEqual(artworkRepositoryMock.getListCompletionCalled, false)
    }

    func test_execute_shouldCallArtworkRepositoryOnce() {
        let exp = expectation(description: "expectation")
        artworkRepositoryMock.getListCompletionClosure = { completion in completion(.success([])) }

        sut.execute { _ in exp.fulfill() }

        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(artworkRepositoryMock.getListCompletionCallsCount, 1)
    }

    func test_execute_repositoryFinishesWithSuccess_shouldCompleteWithSuccess() {
        let returnedArtworks = [Artwork.fake(id: 1), Artwork.fake(id: 2)]
        let exp = expectation(description: "expectation")
        artworkRepositoryMock.getListCompletionClosure = { completion in completion(.success(returnedArtworks)) }

        var capturedArtworks: [Artwork]?
        sut.execute { result in
            switch result {
            case .failure: ()
            case let .success(artowrks): capturedArtworks = artowrks
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(capturedArtworks, returnedArtworks)
    }

    func test_execute_repositoryFinishesWithError_shouldCompleteWithError() {
        let exp = expectation(description: "expectation")
        artworkRepositoryMock.getListCompletionClosure = { completion in completion(.failure(AnyError())) }

        var capturedError: AnyError?
        sut.execute { result in
            switch result {
            case let .failure(error): capturedError = error as? AnyError
            case .success: ()
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(capturedError, AnyError())
    }

    private struct AnyError: Error, Equatable {}
}
