import Foundation
@testable import Artworks

// MARK: - LoadArtworksUseCaseMock -

final class LoadArtworksUseCaseMock: LoadArtworksUseCase {
    // MARK: - execute

    var executeCompletionCallsCount: Int {
        completions.count
    }

    var executeCompletionCalled: Bool {
        executeCompletionCallsCount > 0
    }

    private(set) var completions: [Completion] = []

    func execute(completion: @escaping Completion) {
        completions.append(completion)
    }

    func complete(with artworks: [Artwork], at index: Int = 0) {
        completions[index](.success(artworks))
    }

    func complete(with error: Error, at index: Int = 0) {
        completions[index](.failure(error))
    }
}
