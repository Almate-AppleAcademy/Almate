import Foundation
struct Admin : Codable {
    
	let email : String?
	let password : String?

	enum CodingKeys: String, CodingKey {

		case email = "email"
		case password = "password"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		password = try values.decodeIfPresent(String.self, forKey: .password)
	}
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
