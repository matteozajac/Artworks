protocol ArtworkRepository {
    typealias ListCompletion = (Result<[Artwork], Error>) -> Void

    func getList(completion: @escaping ListCompletion)
}
