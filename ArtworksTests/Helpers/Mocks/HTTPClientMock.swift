import Foundation
@testable import Artworks

// MARK: - HTTPClientMock -

final class HTTPClientMock: HTTPClient {
    // MARK: - get

    var getCompletionCallsCount = 0
    var getCompletionCalled: Bool {
        getCompletionCallsCount > 0
    }

    var getCompletionReceivedArguments: (url: URL?, completion: Completion)?
    var getCompletionReceivedInvocations: [(url: URL?, completion: Completion)] = []
    var getCompletionClosure: ((URL?, @escaping Completion) -> Void)?

    func get(_ url: URL?, completion: @escaping Completion) {
        getCompletionCallsCount += 1
        getCompletionReceivedArguments = (url: url, completion: completion)
        getCompletionReceivedInvocations.append((url: url, completion: completion))
        getCompletionClosure?(url, completion)
    }
}
