import Foundation
struct Comment : Codable {
	let usersId : String?
	let text : String?

	enum CodingKeys: String, CodingKey {

		case usersId = "usersId"
		case text = "text"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		usersId = try values.decodeIfPresent(String.self, forKey: .usersId)
		text = try values.decodeIfPresent(String.self, forKey: .text)
	}

}
