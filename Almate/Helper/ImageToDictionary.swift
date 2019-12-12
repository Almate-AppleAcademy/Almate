//
//  ImageToDictionary.swift
//  Almate
//
//  Created by Qiarra on 10/12/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
