import Foundation
struct Institution {
	let name : String?
	let address : String?
	let admin : [Admin]?
	let users : [Users]?
	let post : [Post]?
	let notif : [Notif]?

	enum CodingKeys: String, CodingKey {
		case name = "name"
		case address = "address"
		case admin = "admin"
		case post = "post"
		case notif = "notif"
	}
}
