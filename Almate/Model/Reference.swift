import Foundation
struct Reference : Codable {
	let idUser : String?
	let textReference : String?

	enum CodingKeys: String, CodingKey {

		case idUser = "idUser"
		case textReference = "textReference"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		idUser = try values.decodeIfPresent(String.self, forKey: .idUser)
		textReference = try values.decodeIfPresent(String.self, forKey: .textReference)
	}

}
