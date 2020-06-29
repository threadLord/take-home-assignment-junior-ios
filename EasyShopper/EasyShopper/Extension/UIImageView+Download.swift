//
//  UIImageView+Download.swift
//  EasyShopper
//
//  Created by Marko Mutavdzic on 29/06/2020.
//  Copyright © 2020 Marko Mutavdzic. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImage(url: String) {
        guard let url2 = URL(string: url) else { return}
           DispatchQueue.global().async {
               if let data = try? Data(contentsOf: url2) {
                   if let image = UIImage(data: data) {
                       DispatchQueue.main.async {
                        self.image = image
                       }
                   }
               }
           }
       }
    
    func downloadImage(url: String, completion: @escaping CompletionImage) {
     guard let url2 = URL(string: url) else { return}
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url2) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
    }
}



