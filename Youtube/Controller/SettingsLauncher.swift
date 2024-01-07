//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by chirag arora on 02/01/24.
//

import UIKit

class Setting: NSObject {
    let name: settingName
    let imageName: String
    
    init(name: settingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
}

enum settingName: String { // enum is a typesafe way we can change text anytime functionality remains
    case Cancel = "Cancel"
    case Setting = "Settings"
    case PrivacyPolicy = "Terms & Privacy Policy"
    case SendFeedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
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
    
    
    let settings: [Setting] = {
       
        return [Setting(name: .Setting, imageName: "gear") , Setting(name: .PrivacyPolicy, imageName: "lock.fill"), Setting(name: .SendFeedback, imageName: "message.fill"), Setting(name: .Help, imageName: "questionmark.circle.fill"), Setting(name: .SwitchAccount, imageName: "person.circle.fill"), Setting(name: .Cancel, imageName: "x.circle.fill")]
    }()
    
    var ViewController: ViewController?
    
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
    
    @objc func handleDismiss(setting: Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            
            self.blackView.alpha = 0
            
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            
        } completion: { Bool in
            
            if setting.name != .Cancel {
                self.ViewController?.showControllerForSettings(setting: setting)
            }
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let setting = self.settings[indexPath.item]

        handleDismiss(setting: setting)
       
        

        
        
    
    }
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
}
