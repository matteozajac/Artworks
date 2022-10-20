import Foundation
import UIKit

extension UIImageView {
    func load(at url: URL) {
        UIImageLoader.loader.load(url, for: self)
    }

    func cancelLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}
