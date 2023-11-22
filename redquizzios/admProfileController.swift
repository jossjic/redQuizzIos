
import UIKit
import Firebase

class admProfileController: UIViewController {
//outlets
    
    @IBOutlet weak var profileImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImg.round()
    }
    
//actions
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            // Cierre de sesión exitoso
            performSegue(withIdentifier: "logOutSegueAdm", sender: self)
        } catch let signOutError as NSError {
            print("Error al cerrar sesión: \(signOutError)")
        }
    }
    
    
    
    }
    

