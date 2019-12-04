//
//  DummyNews.swift
//  Almate
//
//  Created by Qiarra on 21/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import Foundation
import UIKit

class DummyNews: DummyNewsInput {
    var data = [LocalPost]()
    func getData(completion: @escaping ([LocalPost]) -> Void) {
        for n in 0...10 {
            data.append(LocalPost(postImageProfile: UIImage(named: "apel"), postNameProfile: "Apple Developer Academy @ BINUS", postText: postTextDummy[n], postLike: postLike[n], postDate: postDates[n], postBy: "Admin", postPhoto: postImage[n]))
        }
        completion(data)
    }
    
}

protocol DummyNewsInput {
    func getData(completion: @escaping ([LocalPost]) -> Void) -> Void
}

let postDates = [
    DateFormatter().date(from: "2019/10/08 22:31"),
    DateFormatter().date(from: "2019/10/11 22:31"),
    DateFormatter().date(from: "2019/10/29 22:31"),
    DateFormatter().date(from: "2019/11/01 22:31"),
    DateFormatter().date(from: "2019/11/01 22:31"),
    DateFormatter().date(from: "2019/11/04 22:31"),
    DateFormatter().date(from: "2019/11/05 22:31"),
    DateFormatter().date(from: "2019/11/07 22:31"),
    DateFormatter().date(from: "2019/11/07 22:31"),
    DateFormatter().date(from: "2019/11/08 22:31"),
    DateFormatter().date(from: "2019/11/11 22:31"),
    DateFormatter().date(from: "2019/11/11 22:31"),
]

let postLike = [
    12, 4, 2, 4, 5, 0, 9, 22, 1, 4, 3, 5
]

let postImage = [
    UIImage(named: "apel"),
    UIImage(named: "apel"),
    UIImage(named: "apel"),
    UIImage(named: "apel"),
    UIImage(named: "apel"),
    UIImage(named: "apel"),
    UIImage(named: "apel"),
    UIImage(named: "apel"),
    UIImage(named: "apel"),
    UIImage(named: "apel"),
    UIImage(named: "apel"),
    UIImage(named: "apel"),
    UIImage(named: "apel"),
    UIImage(named: "apel"),
    UIImage(named: "apel")
]

let postTextDummy = [
    "Artificial Intelligence merupakan kecerdasan buatan dengan simulasi dalam mesin yang diprogram untuk menyerupai proses kecerdasan manusia dan meniru tindakannya, sehingga system sekarang mampu berpikir serupa dengan manusia secara sistematis dan lebih cepat, sehingga output dapat dihasilkan seketika itu juga.",
    
    "Dalam era revolusi industri 4.0, melakukan pekerjaan akuntansi menjadi sangat mudah dengan penggunaan software akuntansi. Dari survei yang dilakukan oleh Bangladesh Association of Software and Information Services on accounting software, telah ditemukan bahwa 47% dari industri Information Technology (IT) merupakan penggunaan software akuntansi.",
    
    "Akuntansi adalah sistem informasi yang mengukur aktivitas bisnis, memproses data menjadi sebuah laporan, dan mengkomunikasikan hasilnya kepada para pengambil keputusan yang dilakukan oleh akuntan.",
    
    "Artificial Intelligence merupakan kecerdasan buatan dengan simulasi dalam mesin yang diprogram untuk menyerupai proses kecerdasan manusia dan meniru tindakannya, sehingga system sekarang mampu berpikir serupa dengan manusia secara sistematis dan lebih cepat, sehingga output dapat dihasilkan seketika itu juga.",
    
    "Dalam era revolusi industri 4.0, melakukan pekerjaan akuntansi menjadi sangat mudah dengan penggunaan software akuntansi. Dari survei yang dilakukan oleh Bangladesh Association of Software and Information Services on accounting software, telah ditemukan bahwa 47% dari industri Information Technology (IT) merupakan penggunaan software akuntansi.",
    
    "Akuntansi adalah sistem informasi yang mengukur aktivitas bisnis, memproses data menjadi sebuah laporan, dan mengkomunikasikan hasilnya kepada para pengambil keputusan yang dilakukan oleh akuntan.",
    
    "Artificial Intelligence merupakan kecerdasan buatan dengan simulasi dalam mesin yang diprogram untuk menyerupai proses kecerdasan manusia dan meniru tindakannya, sehingga system sekarang mampu berpikir serupa dengan manusia secara sistematis dan lebih cepat, sehingga output dapat dihasilkan seketika itu juga.",
    
    "Dalam era revolusi industri 4.0, melakukan pekerjaan akuntansi menjadi sangat mudah dengan penggunaan software akuntansi. Dari survei yang dilakukan oleh Bangladesh Association of Software and Information Services on accounting software, telah ditemukan bahwa 47% dari industri Information Technology (IT) merupakan penggunaan software akuntansi.",
    
    "Akuntansi adalah sistem informasi yang mengukur aktivitas bisnis, memproses data menjadi sebuah laporan, dan mengkomunikasikan hasilnya kepada para pengambil keputusan yang dilakukan oleh akuntan.",
    
    "Artificial Intelligence merupakan kecerdasan buatan dengan simulasi dalam mesin yang diprogram untuk menyerupai proses kecerdasan manusia dan meniru tindakannya, sehingga system sekarang mampu berpikir serupa dengan manusia secara sistematis dan lebih cepat, sehingga output dapat dihasilkan seketika itu juga.",
    
    "Dalam era revolusi industri 4.0, melakukan pekerjaan akuntansi menjadi sangat mudah dengan penggunaan software akuntansi. Dari survei yang dilakukan oleh Bangladesh Association of Software and Information Services on accounting software, telah ditemukan bahwa 47% dari industri Information Technology (IT) merupakan penggunaan software akuntansi.",
    
    "Akuntansi adalah sistem informasi yang mengukur aktivitas bisnis, memproses data menjadi sebuah laporan, dan mengkomunikasikan hasilnya kepada para pengambil keputusan yang dilakukan oleh akuntan."
]

