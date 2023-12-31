//
//  Extensions.swift
//  Youtube
//
//  Created by chirag arora on 27/12/23.
//

import UIKit


extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIImageView {
    
    func loadImageUsingUrlString(urlString:String) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
            
            
            
        }.resume()
    }
    
}
