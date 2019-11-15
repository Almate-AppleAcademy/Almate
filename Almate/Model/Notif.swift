import Foundation
struct Notif : Codable {
	let text : String?
	let postID : String?
	let date : String?

	enum CodingKeys: String, CodingKey {

		case text = "text"
		case postID = "postID"
		case date = "date"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		text = try values.decodeIfPresent(String.self, forKey: .text)
		postID = try values.decodeIfPresent(String.self, forKey: .postID)
		date = try values.decodeIfPresent(String.self, forKey: .date)
	}

}
