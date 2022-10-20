protocol LoadArtworksUseCase {
    typealias Completion = (Result<[Artwork], Error>) -> Void

    func execute(completion: @escaping Completion)
}

final class LoadArtworkInteractor: LoadArtworksUseCase {
    private let remoteArtworkRepository: ArtworkRepository

    init(remoteArtworkRepository: ArtworkRepository) {
        self.remoteArtworkRepository = remoteArtworkRepository
    }

    func execute(completion: @escaping Completion) {
        remoteArtworkRepository.getList(completion: completion)
    }
}
