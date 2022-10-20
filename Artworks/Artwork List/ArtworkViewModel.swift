import Foundation
import UIKit

struct SectionViewModel {
    var items: [ArtworkViewModel]
}

struct ArtworkViewModel: Hashable {
    let id: Int
    let title: String
    let subtitle: String?
    let description: String?
    let overline: String?
    let imageURL: URL?
    let backgroundColor: UIColor
}
