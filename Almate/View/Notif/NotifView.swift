//
//  NotifView.swift
//  Almate
//
//  Created by Gabriella Gracia MT on 07/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

//struct cellData
//{
//    let cell: Int!
//    let news: String!
//    let date: String!
//    let image: UIImage!
//}
//
//class NotifView: UIView, UITableViewDataSource, UITableViewDelegate {
//
//    let sections:  [String] = ["Today Notification", "Older Notification"]
//
//    let tableCellId = "Notif1TableViewCell"
//    let reuseNya = "tableViewCell1"
//    var arrayOfCellData = [cellData]()
//
//    @IBOutlet weak var todayNotifOutlet: UITableView!
//    @IBOutlet weak var olderNotifOutlet: UITableView!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        todayNotifOutlet.register(UINib(nibName: tableCellId, bundle: nil), forCellReuseIdentifier: reuseNya)
//
//        todayNotifOutlet.headerView(forSection: 60)
//
//
//
//
////        olderNotifOutlet.register(UINib(nibName: "Notif2TableView", bundle: nil), forCellReuseIdentifier: "tableViewCell2")
//
//        todayNotifOutlet.dataSource = self
//        todayNotifOutlet.delegate = self
////        olderNotifOutlet.dataSource =  self
////        olderNotifOutlet.delegate = self
//
//        arrayOfCellData = [cellData(cell: 1, news: "Gabriella Gracia added you", date: "2 hr", image: #imageLiteral(resourceName: "p1")), cellData(cell: 2, news: "Gabriella Gracia added you", date: "2hr", image: #imageLiteral(resourceName: "p3"))]
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return arrayOfCellData.count
//        }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return sections.count
//    }
//
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//            let view = UIView()
//            view.backgroundColor = #colorLiteral(red: 0.9646214843, green: 0.9647600055, blue: 0.9645912051, alpha: 1)
//
//            return view
//        }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//        return 160
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell1", for: indexPath as IndexPath) as! Notif1TableViewCell
//            cell.coPhotoOutlet.image = arrayOfCellData[indexPath.row].image
//            cell.notif1Outlet.text = arrayOfCellData[indexPath.row].news
//            cell.date1Outlet.text = arrayOfCellData[indexPath.row].date
//            return cell
//    }
//
//
//
//
//    /*
//     Only override draw() if you perform custom drawing.
//     An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//         Drawing code
//    }
//    */
//
//}
