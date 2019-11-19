import Foundation
import UIKit

struct Post {
	let postText : String?
	let postLike : Int?
	let postDate : String?
	let postComment : [Comment]?
    let postBy: String?
    let postPhoto: UIImage?

	enum CodingKeys: String {

		case postText = "text"
		case postLike = "like"
		case postDate = "date"
		case postComment = "comment"
        case postBy = "postBy"
        case postPhoto = "postPhoto"
    }
}
