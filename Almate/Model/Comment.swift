import Foundation
struct Comment : Codable {
	let usersId : String?
	let text : String?

	enum CodingKeys: String, CodingKey {

		case usersId = "usersId"
		case text = "text"
	}
}
