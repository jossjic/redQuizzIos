//
//  ViewController.swift
//  redquizzios
//
//  Created by Administrador on 19/10/23.
//

import UIKit

class profileController: UIViewController {
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var avatarBtn: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var scoreBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()


        

    }
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
        profileImg.round()
        }

}



