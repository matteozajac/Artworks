import UIKit

protocol AlerErrorDisplaying {
    func show(_ alertController: UIAlertController)
}

final class AlerErrorDisplayer: AlerErrorDisplaying {
    private weak var viewController: UIViewController?

    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }

    func show(_ alertController: UIAlertController) {
        viewController?.present(alertController, animated: true)
    }
}
