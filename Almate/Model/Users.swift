import Foundation
import UIKit

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
    let imageUser: UIImage?

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
    
    init(email: String, idUser: String, name: String, generation: String, occupation: String, local: Bool, skills: [String], image: UIImage) {
        self.email = email
        self.idUser = idUser
        self.name = name
        self.generation = generation
        self.occupation = occupation
        self.tagSkill = skills
        self.local = local
        self.imageUser = image
    }
}
