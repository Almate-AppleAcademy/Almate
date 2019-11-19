//
//  ExtensionModelFirestore.swift
//  Almate
//
//  Created by Qiarra on 20/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import Foundation

// A type that can be initialized from a Firestore document.
protocol DocumentSerializable {
  init?(dictionary: [String: Any])
}
