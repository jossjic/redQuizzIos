//
//  ViewController.swift
//  redquizzios
//
//  Created by Administrador on 19/10/23.
//

import UIKit

class profileController: UIViewController {
    @IBOutlet weak var profileImg: UIImageView!
    
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var vidas: UILabel!
    
    @IBOutlet weak var time: UILabel!
   let userViewModel = UserViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userViewModel.fetchData {
            let userI = self.userViewModel.fetchedUser
            self.name.text = userI.nombre + " " + userI.apellidos
            self.vidas.text = String(userI.vidas) + " Vidas"
            print(userI)
        }
       


        

    }
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
        profileImg.round()
        }

}



