import Foundation

struct AICObjectResponse: Decodable {
    let id: Int
    let title: String
    let artistTitle: String?
    let artistDisplay: String?
    let imageID: String?
    let styleTitle: String?
    let color: Color?

    struct Color: Decodable {
        let h: Int
        let l: Int
        let s: Int
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case artistTitle = "artist_title"
        case artistDisplay = "artist_display"
        case imageID = "image_id"
        case styleTitle = "style_title"
        case color
    }
}
