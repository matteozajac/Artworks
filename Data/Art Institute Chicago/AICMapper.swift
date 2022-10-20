import Foundation
import UIKit

final class AICMapper {
    static func toArtwork(from object: AICObjectResponse) -> Artwork {
        Artwork(objectID: object.id,
                title: object.title,
                artistDisplayName: object.artistDisplay ?? "Unknown",
                primaryImageSmall: AICEndpoint.image(imageID: object.imageID),
                styleTitle: object.styleTitle,
                hexColor: Self.mapColor(color: object.color))
    }

    private static func mapColor(color: AICObjectResponse.Color?) -> String {
        guard let color else { return "#000000" }
        let h = CGFloat(color.h) / 360.0
        let l = CGFloat(color.l) / 100.0
        let s = CGFloat(color.s) / 100.0
        let hls = HLSColor(hue: h, saturation: l, lightness: s, alpha: 1)
        let uicolor = UIColor(hls: hls)

        return uicolor.hex
    }
}
