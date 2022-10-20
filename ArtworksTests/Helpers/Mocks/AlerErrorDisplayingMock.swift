import Foundation
@testable import Artworks
import UIKit

// MARK: - AlerErrorDisplayingMock -

final class AlerErrorDisplayingMock: AlerErrorDisplaying {
    // MARK: - show

    var showCallsCount = 0
    var showCalled: Bool {
        showCallsCount > 0
    }

    var showReceivedAlertController: UIAlertController?
    var showReceivedInvocations: [UIAlertController] = []
    var showClosure: ((UIAlertController) -> Void)?

    func show(_ alertController: UIAlertController) {
        showCallsCount += 1
        showReceivedAlertController = alertController
        showReceivedInvocations.append(alertController)
        showClosure?(alertController)
    }
}
