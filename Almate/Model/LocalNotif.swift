import Foundation
struct LocalNotif : Codable {
	let text : String?
	let postID : String?
	let date : String?

	enum CodingKeys: String, CodingKey {

		case text = "text"
		case postID = "postID"
		case date = "date"
	}
}
