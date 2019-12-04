//
//  ExtensionModelFirestore.swift
//  Almate
//
//  Created by Adrian Suryo Abiyoga on 02/12/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import Foundation

protocol DocumentSerializable {
    init?(dictionary: [String: Any])
}
