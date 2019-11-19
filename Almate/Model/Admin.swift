import Foundation
struct Admin : Codable {
    
	let email : String?
	let password : String?

	enum CodingKeys: String, CodingKey {

		case email = "email"
		case password = "password"
	}
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
