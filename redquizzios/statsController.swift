
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
 
        userViewModel.fetchData {
            let userI = self.userViewModel.fetchedUser
            self.name.text = userI.nombre + " " + userI.apellidos
            self.birth.text = userI.fechaNacimiento
            self.email.text = userI.email
            self.gender.text = userI.genero
            if userI.genero == "masculino" {
                self.profileImg.image = UIImage(named: "placeHombre")
            } else if userI.genero == "femenino" {
                self.profileImg.image = UIImage(named: "placeMujer")
            } else {
                print("genero no identificado")
            }
        }

        
        
        
        
       
   
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
        profileImg.round()
        }
    
    @IBAction func logOut(_ sender: Any) {
        
        do {
            let defaults = UserDefaults.standard
            if let uid = defaults.value(forKey: "uid") as? String{
                UserDefaults.standard.removeObject(forKey: "uid")
                UserDefaults.standard.synchronize()
            }
            try Auth.auth().signOut()
            // Cierre de sesión exitoso
            performSegue(withIdentifier: "logOutSegue2", sender: self)
        } catch let signOutError as NSError {
            print("Error al cerrar sesión: \(signOutError)")
        }
        
        
    }
    


}
