@testable import Artworks
import XCTest

final class ArtworkListViewControllerTests: XCTestCase {
    private var sut: ArtworkListViewController!
    private var loadArtworksUseCaseMock: LoadArtworksUseCaseMock!
    private var alerErrorDisplayingMock: AlerErrorDisplayingMock!

    override func setUp() {
        loadArtworksUseCaseMock = LoadArtworksUseCaseMock()
        alerErrorDisplayingMock = AlerErrorDisplayingMock()
        sut = ArtworkListComposer.compose(loadArtworkUseCase: loadArtworksUseCaseMock)
        sut.errorDisplayer = alerErrorDisplayingMock
    }

    override func tearDown() {
        sut = nil
        loadArtworksUseCaseMock = nil
        alerErrorDisplayingMock = nil
    }

    func test_presenter_shouldBeInitialized() throws {
        XCTAssertNotNil(sut.presenter)
    }

    func test_presenter_shouldNotLoadArtworkBeforeViewDidLoad() throws {
        XCTAssertEqual(loadArtworksUseCaseMock.executeCompletionCalled, false)
    }

    func test_viewDidLoad_shouldShowTheRefreshIndicator() {
        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.refreshControl?.isRefreshing, true, "Refresh Control is refreshing")
    }

    func test_viewDidLoad_shouldLoadArtworksOnce() {
        sut.loadViewIfNeeded()

        XCTAssertEqual(loadArtworksUseCaseMock.executeCompletionCallsCount, 1)
    }

    func test_loadData_completesWithError_shouldShowErrorAlert() {
        sut.loadViewIfNeeded()

        loadArtworksUseCaseMock.complete(with: NSError())
        XCTAssertEqual(alerErrorDisplayingMock.showCallsCount, 1)
    }

    func test_loadData_completesWithError_shouldHaveListWithNoSections() {
        sut.loadViewIfNeeded()

        loadArtworksUseCaseMock.complete(with: NSError())
        XCTAssertEqual(sut.tableView.numberOfSections, 0)
    }

    func test_loadData_completesWithSuccess_shouldNotShowErrorAlert() {
        sut.loadViewIfNeeded()

        loadArtworksUseCaseMock.complete(with: [Artwork.fake()])
        XCTAssertEqual(alerErrorDisplayingMock.showCallsCount, 0)
    }

    func test_loadData_completesWithSuccess_shouldHaveListWithOneSection() {
        sut.loadViewIfNeeded()

        loadArtworksUseCaseMock.complete(with: [])

        let expectedSectionsCount = 1
        let actualSectionsCount = sut.tableView.numberOfSections

        XCTAssertEqual(expectedSectionsCount, actualSectionsCount)
    }

    func test_loadData_completesWithThreeArtworks_shouldHaveListWithThreeItemsInOnlySection() {
        sut.loadViewIfNeeded()

        loadArtworksUseCaseMock.complete(with: [
            Artwork.fake(id: 1),
            Artwork.fake(id: 2),
            Artwork.fake(id: 3),
        ]
        )
        let expectedItemsCount = 3
        let actualItemsCount = sut.tableView.numberOfRows(inSection: 0)

        XCTAssertEqual(expectedItemsCount, actualItemsCount)
    }

    func test_refreshControl_pullToRefresh_shouldLoadArtworksOnceMore() {
        sut.loadViewIfNeeded()

        XCTAssertEqual(loadArtworksUseCaseMock.executeCompletionCallsCount, 1)

        sut.refreshControl?.simulatePullToRefresh()

        XCTAssertEqual(loadArtworksUseCaseMock.executeCompletionCallsCount, 2)
    }

    func test_tableView_shouldHaveValidConfig() {
        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.tableView.separatorStyle, .none)
        XCTAssertEqual(sut.tableView.allowsSelection, false)
    }

    func test_errorDisplayer_shouldShowValidError() {
        sut.loadViewIfNeeded()

        loadArtworksUseCaseMock.complete(with: NSError())

        XCTAssertEqual(alerErrorDisplayingMock.showReceivedAlertController?.title, "Oops, something went wrong")
        XCTAssertEqual(alerErrorDisplayingMock.showReceivedAlertController?.message, "Please try again later")
        XCTAssertEqual(alerErrorDisplayingMock.showReceivedAlertController?.actions.count, 1)
        XCTAssertEqual(alerErrorDisplayingMock.showReceivedAlertController?.actions.first?.title, "Retry")
    }

    func test_cellForRowAt_withRow0_shouldSetCellTitleToMonaLisa() {
        assertArtCollectionViewCell(at: 0, expectedTitle: "Mona Lisa", expectedSubtitle: "Leonardo da Vinci")
    }

    func test_cellForRowAt_withRow1_shouldSetCellTitleToTheStarryNight() {
        assertArtCollectionViewCell(at: 1, expectedTitle: "The Starry Night", expectedSubtitle: "Vincent van Gogh")
    }

    private func assertArtCollectionViewCell(at row: Int, expectedTitle: String, expectedSubtitle: String, file: StaticString = #filePath, line: UInt = #line) {
        sut.loadViewIfNeeded()

        loadArtworksUseCaseMock.complete(with: [
            Artwork.fake(id: 1, title: "Mona Lisa", artistDisplayName: "Leonardo da Vinci"),
            Artwork.fake(id: 2, title: "The Starry Night", artistDisplayName: "Vincent van Gogh"),
            Artwork.fake(id: 3, title: "Guernica", artistDisplayName: "Pablo Picasso"),
        ]
        )
        sut.tableView.reloadData()
        let actualCell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: row, section: 0)) as? ArtworkTableViewCell

        XCTAssertEqual(actualCell?.titleLabel.text, expectedTitle, file: file, line: line)
        XCTAssertEqual(actualCell?.subtitleLabel.text, expectedSubtitle, file: file, line: line)
    }
}
