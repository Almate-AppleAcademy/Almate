import UIKit
import Firebase


class SettingsViewController: UIViewController {

    @IBOutlet var settingView: SettingsView!
    override func viewDidLoad() {
        
        settingView.settingViewDelegate =  self
        
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

extension SettingsViewController : SettingViewDelegate{
    func didTappedSignOut() {
        print("dah kepencet")
        
        let alert = UIAlertController(title: "Sign Out", message: "This woud sign you out from the app. Are you sure want to sign out?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
       
        alert.addAction(UIAlertAction(title: "Sign Out", style: UIAlertAction.Style.destructive, handler: {(action: UIAlertAction!) in
            do {
                try Auth.auth().signOut()
                self.navigationController?.pushViewController(LoginViewController(), animated: true)
            } catch let err {
                print("Failed to sign out", err)
            }
            
        }))
            self.present(alert, animated: true)
    }
    
    func didTappedChangePassword() {
        self.navigationController?.pushViewController(UpdatepassViewController(), animated: true)
    }
}

