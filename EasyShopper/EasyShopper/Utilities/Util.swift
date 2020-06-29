//
//  Util.swift
//  EasyShopper
//
//  Created by Marko Mutavdzic on 29/06/2020.
//  Copyright © 2020 Marko Mutavdzic. All rights reserved.
//

import UIKit

class Util {
    
    static func displayYesNoDialog(_ controller: UIViewController, title: String, message: String, yes: @escaping () -> (), no: (() -> ())? = nil)
       {
           let alertController = UIAlertController(title: title,
                                                   message: message,
                                                   preferredStyle: .alert)
           
           let yesAction = UIAlertAction(title: "Yes", style: .destructive) { action in
               alertController.dismiss(animated: true, completion: nil)
               yes()
           }
           
           let noAction = UIAlertAction(title: "No", style: .cancel) { action in
               alertController.dismiss(animated: true, completion: nil)
               no?()
           }
           
           alertController.addAction(yesAction)
           alertController.addAction(noAction)
           
           controller.present(alertController, animated: true, completion: nil)
       }
}
