import UIKit

class ImageLoader {
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()

    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }

        let uuid = UUID()

        let task = URLSession.shared.dataTask(with: url) { data, _, error in

            defer { self.runningRequests.removeValue(forKey: uuid) }

            if let data, let image = UIImage(data: data) {
                self.loadedImages[url] = image
                completion(.success(image))
            }

            guard let error else { return }

            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
        }
        task.resume()
        runningRequests[uuid] = task

        return UUID()
    }

    func cancel(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}
