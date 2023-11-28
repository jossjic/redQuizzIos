
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
        let alertController = UIAlertController(title: "Cerrar Sesión", message: "¿Desea cerrar sesión?", preferredStyle: .alert)

           // Agregar acciones (botones) a la alerta
           let cancelAction = UIAlertAction(title: "No", style: .cancel) { _ in
               // Handle the cancel action if needed
           }
           alertController.addAction(cancelAction)

           let deleteAction = UIAlertAction(title: "Sí", style: .destructive) { [weak self] _ in
               let defaults = UserDefaults.standard
               if defaults.value(forKey: "uid") is String {
                   UserDefaults.standard.removeObject(forKey: "uid")
                   UserDefaults.standard.synchronize()
               }

               do {
                   try Auth.auth().signOut()
                   // Cierre de sesión exitoso
                   self?.performSegue(withIdentifier: "logOutSegueAdm", sender: self)
               } catch let signOutError as NSError {
                   print("Error al cerrar sesión: \(signOutError)")
                   // Handle the sign-out error if needed
               }
           }
           alertController.addAction(deleteAction)

           present(alertController, animated: true, completion: nil)
    }
    
    
    
    }
    

