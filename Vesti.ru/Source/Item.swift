//
//  Item.swift
//  Vesti.ru
//
//  Created by Александр Осипов on 02.07.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import Foundation

public struct Item {
    
    public var title: String?
    public var link: String?
    public var pubDate: Date?
    public var description: String?
    public var urlImage: String?
    public var fullText: String?
    public var categories: String?
    
    init(title: String?, link: String?, pubDate: Date?, description: String?, urlImage: String?, fullText: String?, categories: String?){
        
        self.title = title
        self.link = link
        self.pubDate = pubDate
        self.description = description
        self.urlImage = urlImage
        self.fullText = fullText
        self.categories = categories
    }
}
