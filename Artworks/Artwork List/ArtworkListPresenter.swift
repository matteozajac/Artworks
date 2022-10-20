import Foundation
import UIKit

protocol ArtworkListViewCommands: AnyObject {
    func showActivityIndicator()
    func hideActivityIndicator()
    func showError(_ error: Error)
    func showData(_ sections: [SectionViewModel])
}

final class ArtworkListPresenter {
    private weak var view: ArtworkListViewCommands?

    private let loadArtworksUseCase: LoadArtworksUseCase

    init(view: ArtworkListViewCommands,
         loadArtworkUseCase: LoadArtworksUseCase)
    {
        self.view = view
        loadArtworksUseCase = loadArtworkUseCase
    }

    func onAppear() {
        view?.showActivityIndicator()
        loadArtworksUseCase.execute { [weak self] result in
            switch result {
            case let .success(artworks):
                self?.view?.showData([.init(items: artworks.map {
                    ArtworkViewModel(
                        id: $0.objectID,
                        title: $0.title,
                        subtitle: $0.artistDisplayName,
                        description: nil,
                        overline: $0.styleTitle,
                        imageURL: $0.primaryImageSmall,
                        backgroundColor: UIColor(hex: $0.hexColor)
                    )
                })])
            case let .failure(error):
                self?.view?.showError(error)
            }
            self?.view?.hideActivityIndicator()
        }
    }
}
