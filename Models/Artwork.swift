import Foundation

struct Artwork: Equatable {
    let objectID: Int
    let title: String
    let artistDisplayName: String
    let primaryImageSmall: URL?
    let styleTitle: String?
    let hexColor: String
}
