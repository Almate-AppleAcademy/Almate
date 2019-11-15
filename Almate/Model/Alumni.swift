import Foundation
struct Alumni {
	let institution : [Institution]?

	enum CodingKeys: String, CodingKey {

		case institution = "institution"
	}

//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		institution = try values.decodeIfPresent([Institution].self, forKey: .institution)
//	}

}
