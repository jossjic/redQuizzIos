
import UIKit
import Firebase

class admProfileController: UIViewController {
//outlets
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var mail: UILabel!
    let userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImg.image = UIImage(named: "placeHombre")
        userViewModel.fetchData {
            self.mail.text = self.userViewModel.fetchedAdmin.email
        }
        
        print("Admin Home")

    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
        profileImg.round()
        }
    @IBAction func logOut(_ sender: Any) {
        
        do {
            let defaults = UserDefaults.standard
            if defaults.value(forKey: "uid") is String{
                UserDefaults.standard.removeObject(forKey: "uid")
                UserDefaults.standard.synchronize()
            }
            try Auth.auth().signOut()
            // Cierre de sesión exitoso
            performSegue(withIdentifier: "logOutSegueAdm", sender: self)
        } catch let signOutError as NSError {
            print("Error al cerrar sesión: \(signOutError)")
        }
        
        
    }
    
    
    
    }
    

