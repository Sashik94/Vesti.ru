//
//  Channel.swift
//  Vesti.ru
//
//  Created by Александр Осипов on 02.07.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import Foundation

public struct Channel {
    
    public var title: String?
    public var link: String?
    public var description: String?
    public var items: [Item]  = []
    
    init() {}
    
    init(title: String?, link: String?, description: String?, items: [Item]){
        
        self.title = title
        self.link = link
        self.description = description
        self.items = items
    }
}
