import Foundation

final class ArtworkListComposer {
    static func compose(
        loadArtworkUseCase: LoadArtworksUseCase
    ) -> ArtworkListViewController {
        let artworkListViewController = ArtworkListViewController()

        artworkListViewController.presenter = ArtworkListPresenter(
            view: artworkListViewController,
            loadArtworkUseCase: MainQueueDispatchDecoratorLoadArtworks(loadArtworkUseCase)
        )
        return artworkListViewController
    }
}

private class MainQueueDispatchDecoratorLoadArtworks: LoadArtworksUseCase {
    private let decoratee: LoadArtworksUseCase

    init(_ decoratee: LoadArtworksUseCase) {
        self.decoratee = decoratee
    }

    func execute(completion: @escaping Completion) {
        decoratee.execute { result in
            guaranteeMainThread {
                completion(result)
            }
        }
    }
}
