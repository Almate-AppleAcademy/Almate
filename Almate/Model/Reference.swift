import Foundation
struct Reference : Codable {
	let idUser : String?
	let textReference : String?

	enum CodingKeys: String, CodingKey {

		case idUser = "idUser"
		case textReference = "textReference"
	}
}
