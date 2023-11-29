
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
        if Reachability.isConnectedToNetwork(){
            userViewModel.fetchData {
                let userI = self.userViewModel.fetchedUser
                self.name.text = userI.nombre + " " + userI.apellidos
                self.birth.text = userI.fechaNacimiento
                self.email.text = userI.email
                self.gender.text = userI.genero
                if userI.genero == "Masculino" {
                    self.profileImg.image = UIImage(named: "placeHombre")
                } else if userI.genero == "Femenino" {
                    self.profileImg.image = UIImage(named: "placeMujer")
                } else {
                    print("genero no identificado")
                }
            }
                     
                    
                } else {
                    let alertController = UIAlertController(title: "Conexión Perdida", message: "Reconectate y vuelve a intentar", preferredStyle: .alert)
                    
                    // Agregar acciones (botones) a la alerta
                    let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                        self.viewDidLoad()
                    }
                    alertController.addAction(okAction)
                    
                    // Mostrar la alerta
                    DispatchQueue.main.async {
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
        

        
        
        
        
       
   
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
        profileImg.round()
        }
    
    


}
