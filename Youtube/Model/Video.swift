//
//  Video.swift
//  Youtube
//
//  Created by chirag arora on 28/12/23.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
    
}


class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}
