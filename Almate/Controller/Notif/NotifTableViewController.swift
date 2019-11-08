//
//  NotifViewController.swift
//  Almate
//
//  Created by Qiarra on 31/10/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

struct cellData {
    let cell: Int!
    let news: String!
    let date: String!
    let image: UIImage!
}

class NotifTableViewController: UITableViewController{


    let sectionTitle: [String] = ["Today", "Older"]

    var arrayOfCellData = [cellData]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Notification"
        
        arrayOfCellData = [cellData(cell: 1, news: "Gabriella Gracia added you", date: "2 hr", image: #imageLiteral(resourceName: "Photo 28-10-19 02.23.51")), cellData(cell: 1, news: "Chealse view your profile", date: "5 hr", image: #imageLiteral(resourceName: "Photo 27-10-19 23.36.17")), cellData(cell: 1, news: "Angle added you", date: "12 hro", image: #imageLiteral(resourceName: "Photo 27-10-19 23.36.41"))]
        
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayOfCellData.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9646214843, green: 0.9647600055, blue: 0.9645912051, alpha: 1)
        
        let judul = UILabel()
        judul.frame = CGRect(x: 15, y: 15, width: 300, height: 35)
        judul.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        judul.text = sectionTitle[section]
        judul.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(judul)
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if arrayOfCellData[indexPath.row].cell == 1
        {
            let cell = Bundle.main.loadNibNamed("Notif1TableViewCell", owner: self, options: nil)?.first as! Notif1TableViewCell
            
            cell.coPhotoOutlet.image = arrayOfCellData[indexPath.row].image
            cell.notif1Outlet.text = arrayOfCellData[indexPath.row].news
            cell.date1Outlet.text = arrayOfCellData[indexPath.row].date
            return cell
        }
        else if arrayOfCellData[indexPath.row].cell == 2
        {
            let cell = Bundle.main.loadNibNamed("Notif2TableViewCell", owner: self, options: nil)?.first as! Notif2TableViewCell

            cell.profilePictOutlet.image = arrayOfCellData[indexPath.row].image
            cell.notificationOutlet.text = arrayOfCellData[indexPath.row].news
            cell.dateOutlet.text = arrayOfCellData[indexPath.row].date
            return cell
        }
        else
        {
            let cell = Bundle.main.loadNibNamed("Notif1TableViewCell", owner: self, options: nil)?.first as! Notif1TableViewCell
            
            cell.coPhotoOutlet.image = arrayOfCellData[indexPath.row].image
            cell.notif1Outlet.text = arrayOfCellData[indexPath.row].news
            cell.date1Outlet.text = arrayOfCellData[indexPath.row].date
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arrayOfCellData[indexPath.row].cell == 1
        {
                    return 80
        }
        else if arrayOfCellData[indexPath.row].cell == 2
        {
                    return 80
        }
        else
        {
            return 80
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
