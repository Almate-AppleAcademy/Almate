import Foundation
struct LocalInstitution {
	let name : String?
	let address : String?
	let admin : [LocalAdmin]?
	let users : [LocalUsers]?
	let post : [LocalPost]?
	let notif : [LocalNotif]?

	enum CodingKeys: String, CodingKey {
		case name = "name"
		case address = "address"
		case admin = "admin"
		case post = "post"
		case notif = "notif"
	}
}
