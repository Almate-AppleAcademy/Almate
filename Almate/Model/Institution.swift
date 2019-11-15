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
//		case users = "users"
		case post = "post"
		case notif = "notif"
	}

//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		name = try values.decodeIfPresent(String.self, forKey: .name)
//		address = try values.decodeIfPresent(String.self, forKey: .address)
//		admin = try values.decodeIfPresent([Admin].self, forKey: .admin)
//		users = try values.decodeIfPresent([Users].self, forKey: .users)
//		post = try values.decodeIfPresent([Post].self, forKey: .post)
//		notif = try values.decodeIfPresent([Notif].self, forKey: .notif)
//	}

}
