import Foundation
struct LocalAlumni {
	let institution : [LocalInstitution]?

	enum CodingKeys: String, CodingKey {
        case institution = "institution"
	}
}
