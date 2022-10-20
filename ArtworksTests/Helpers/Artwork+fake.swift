import Foundation
@testable import Artworks

extension Artwork {
    static func fake(id: Int = 123, title: String = "Artwork Title", artistDisplayName: String = "Artist Display Name") -> Artwork {
        Artwork(objectID: id, title: title, artistDisplayName: artistDisplayName, primaryImageSmall: nil, styleTitle: nil, hexColor: "#123abc")
    }
}
