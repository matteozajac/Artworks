import UIKit

final class ArtworkListViewController: UITableViewController {
    var presenter: ArtworkListPresenter!
    lazy var errorDisplayer: AlerErrorDisplaying = AlerErrorDisplayer(self)
    private let artworkCellReuseIdentifier = "ArtworkCell"

    var data: [SectionViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
        setUp(tableView: tableView)
        presenter.onAppear()
    }

    @objc func onPullToRefresh() {
        presenter.onAppear()
    }

    private func setUpNavigationBar() {
        navigationItem.title = "Artworks"
    }

    private func setUp(tableView: UITableView) {
        tableView.register(ArtworkTableViewCell.self, forCellReuseIdentifier: artworkCellReuseIdentifier)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(onPullToRefresh), for: .valueChanged)
    }

    // MARK: UITableViewDataSource

    override func numberOfSections(in _: UITableView) -> Int {
        data.count
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        data[section].items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: artworkCellReuseIdentifier, for: indexPath) as! ArtworkTableViewCell
        let itemViewModel = data[0].items[indexPath.item]
        cell.updateView(itemViewModel)

        return cell
    }
}
