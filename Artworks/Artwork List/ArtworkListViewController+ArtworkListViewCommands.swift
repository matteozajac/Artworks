import Foundation
import UIKit

extension ArtworkListViewController: ArtworkListViewCommands {
    func showData(_ sections: [SectionViewModel]) {
        data = sections
        tableView.reloadData()
    }

    func hideActivityIndicator() {
        tableView.refreshControl?.endRefreshing()
    }

    func showActivityIndicator() {
        tableView.refreshControl?.beginRefreshing()
    }

    func showError(_: Error) {
        let alert = UIAlertController(title: "Oops, something went wrong", message: "Please try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default) { _ in self.presenter.onAppear() })
        errorDisplayer.show(alert)
    }
}
