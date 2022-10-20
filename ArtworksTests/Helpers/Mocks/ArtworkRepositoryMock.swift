@testable import Artworks

// MARK: - ArtworkRepositoryMock -

final class ArtworkRepositoryMock: ArtworkRepository {
    // MARK: - getList

    var getListCompletionCallsCount = 0
    var getListCompletionCalled: Bool {
        getListCompletionCallsCount > 0
    }

    var getListCompletionReceivedCompletion: ListCompletion?
    var getListCompletionReceivedInvocations: [ListCompletion] = []
    var getListCompletionClosure: ((@escaping ListCompletion) -> Void)?

    func getList(completion: @escaping ListCompletion) {
        getListCompletionCallsCount += 1
        getListCompletionReceivedCompletion = completion
        getListCompletionReceivedInvocations.append(completion)
        getListCompletionClosure?(completion)
    }
}
