import Foundation
struct Alumni {
	let institution : [Institution]?

	enum CodingKeys: String, CodingKey {
        case institution = "institution"
	}
}
