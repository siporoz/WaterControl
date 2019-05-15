//
//  ViewController.swift
//  WaterControl
//
//  Created by Владимир on 10.05.2019.
//  Copyright © 2019 Siporoz. All rights reserved.
//

import UIKit
import UICircularProgressRing
import SPStorkController



class ViewController: UIViewController {

    @IBOutlet weak var progressWater: UILabel!
    
    
    var myValue:String = "НИуя"

    
    var count = 3
    
    
    let button = UIButton.init(type: .system)
    @IBOutlet weak var some: UICircularProgressRing!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRing()
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(viewTapGesture)
        let singleton = Singletonn.shared
        progressWater.text = String(singleton.number)
    }
    
    func upDatet(){
        let singleton = Singletonn.shared

    }
    
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }   
    
    func addRing(){
        some.value = 30
    }

    @IBAction func showViewControllerTapped(_ sender: UIButton) {
        guard let popupmain = storyboard?.instantiateViewController(withIdentifier: "main") as? PopUpViewController else { return }
        popupmain.height = screenHeight / 1.75
        popupmain.topCornerRadius = 20
        popupmain.presentDuration = 1.4
        popupmain.dismissDuration = 1.5
        
        present(popupmain, animated: true, completion: nil)
    }
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    
}

