import Foundation
struct Users {
	let name : String?
//	let status : String?
	let email : String?
//	let phoneNumber : Int?
//	let linkedinSite : String?
	let occupation : String?
//	let about : String?
	let generation : String?
//	let work : [String]?
	let tagSkill : [String]?
//	let reference : [Reference]?
    let idUser: String?
    let local: Bool?

	enum CodingKeys: String, CodingKey {
		case name = "name"
		case status = "status"
		case email = "email"
		case phoneNumber = "phoneNumber"
		case linkedinSite = "linkedinSite"
		case occupation = "occupation"
		case about = "about"
		case generation = "generation"
		case work = "work"
		case tagSkill = "tagSkill"
		case reference = "reference"
        case idUser = "idUser"
        case local = "local"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
//		status = try values.decodeIfPresent(String.self, forKey: .status)
		email = try values.decodeIfPresent(String.self, forKey: .email)
//		phoneNumber = try values.decodeIfPresent(Int.self, forKey: .phoneNumber)
//		linkedinSite = try values.decodeIfPresent(String.self, forKey: .linkedinSite)
		occupation = try values.decodeIfPresent(String.self, forKey: .occupation)
//		about = try values.decodeIfPresent(String.self, forKey: .about)
		generation = try values.decodeIfPresent(String.self, forKey: .generation)
//		work = try values.decodeIfPresent([String].self, forKey: .work)
		tagSkill = try values.decodeIfPresent([String].self, forKey: .tagSkill)
//		reference = try values.decodeIfPresent([Reference].self, forKey: .reference)
        idUser = try values.decodeIfPresent(String.self, forKey: .idUser)
        local = try values.decodeIfPresent(Bool.self, forKey: .local)
	}
    
    init(email: String, idUser: String, name: String, generation: String, occupation: String, local: Bool, skills: [String]) {
        self.email = email
        self.idUser = idUser
        self.name = name
        self.generation = generation
        self.occupation = occupation
        self.tagSkill = skills
        self.local = local
    }
}
