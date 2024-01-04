//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by chirag arora on 02/01/24.
//

import UIKit

class setting: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
}

class SettingsLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var window: UIWindow?
    
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
        
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 55
    
    let settings: [setting] = {
        return [setting(name: "Settings", imageName: "gear"), setting(name: "terms & Privacy Policy", imageName: "lock.fill"), setting(name: "send Feedback", imageName: "message.fill"), setting(name: "Help", imageName: "questionmark.circle.fill"), setting(name: "Switch Account", imageName: "person.circle.fill"), setting(name: "Cancel", imageName: "x.circle.fill")]
    }()
    
    @objc func showSettings() {
        
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {return}
        self.window = window
        
        
        
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        
        window.addSubview(blackView)
        window.addSubview(collectionView)
        
        let height: CGFloat = CGFloat(settings.count) * cellHeight
        let y = window.frame.height - height
        
        collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
        
        
        
        blackView.frame = window.frame
        blackView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.blackView.alpha = 1
            
            self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)        
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
}
