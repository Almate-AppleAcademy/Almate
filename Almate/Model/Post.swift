import Foundation
struct Post : Codable {
	let text : String?
	let like : Int?
	let date : String?
	let comment : [Comment]?

	enum CodingKeys: String, CodingKey {

		case text = "text"
		case like = "like"
		case date = "date"
		case comment = "comment"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		text = try values.decodeIfPresent(String.self, forKey: .text)
		like = try values.decodeIfPresent(Int.self, forKey: .like)
		date = try values.decodeIfPresent(String.self, forKey: .date)
		comment = try values.decodeIfPresent([Comment].self, forKey: .comment)
	}

}
