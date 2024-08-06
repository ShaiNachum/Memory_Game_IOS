import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var login_LBL_title: UILabel!
    @IBOutlet weak var login_TF_name: UITextField!
    
    var playerName: String = ""
    var isNameEntered: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func login_BTN_start(_ sender: Any) {
        if(login_TF_name.text?.isEmpty == false) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GameController") as! GameController
            vc.playerName = login_TF_name.text!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @IBAction func login_BTN_records(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecordsController") as! RecordsController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
