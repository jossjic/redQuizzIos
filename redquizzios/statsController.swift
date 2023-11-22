
import UIKit
import Firebase

class statsController: UIViewController {

    
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var birth: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    let userViewModel = UserViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImg.round()
        userViewModel.fetchData {
            let userI = self.userViewModel.fetchedUser
            self.name.text = userI.nombre + " " + userI.apellidos
            self.birth.text = userI.fechaNacimiento
            self.email.text = userI.email
            self.gender.text = userI.genero
        }
        
        
        
        
       
   
    }
    
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            // Cierre de sesión exitoso
            performSegue(withIdentifier: "logOutSegue2", sender: self)
        } catch let signOutError as NSError {
            print("Error al cerrar sesión: \(signOutError)")
        }
    }
    


}
