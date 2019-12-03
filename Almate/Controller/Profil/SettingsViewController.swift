import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        self.navigationItem.title = "Settings"
        self.navigationItem.rightBarButtonItem = doneBtn
        // Do any additional setup after loading the view.
    }

    @objc func donePressed(){
        self.dismiss(animated: true, completion: nil)
    }

}
