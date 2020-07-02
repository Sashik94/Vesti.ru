//
//  Parser.swift
//  Vesti.ru
//
//  Created by Александр Осипов on 02.07.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import Foundation
import AEXML
import SwiftDate

public class Parser {
    
    public static func parse(xmlURL: URL, onSuccess: @escaping (Channel) -> (), onNotFound: @escaping () -> (), onFailure: @escaping (Error?) -> ()) {
        DispatchQueue.global(qos: .default).async {
//            let xmlData = try? Data(contentsOf: xmlURL)
            do {
                let xmlDoc = try AEXMLDocument(xml: try Data(contentsOf: xmlURL))
                var existChannel = false
                
                for child in xmlDoc.root.children {
                    if (child.name == "channel") {
                        existChannel = true
                    }
                }
                
                if (existChannel) {
                    let channel = parseRSS(xmlDoc: xmlDoc)
                    DispatchQueue.main.async {
                        onSuccess(channel)
                    }
                } else {
                    DispatchQueue.main.async {
                        onNotFound()
                    }
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    onFailure(error)
                }
            }
        }
    }
    
    private static func parseRSS(xmlDoc: AEXMLDocument) -> Channel {
        var items: [Item] = []

        if let all = xmlDoc.root["channel"]["item"].all {
            for itemObject in all {

                let title = itemObject["title"].value
                let link = itemObject["link"].value

                var pubDate: Date? = nil

                if let pubDateString = itemObject["pubDate"].value {
                    pubDate = pubDateString.toDate(style: StringToDateStyles.rss)?.date
                }

                let description = itemObject["description"].value

                let categories = itemObject["category"].value
                
                let fullText = itemObject["yandex:full-text"].value
                
                var urlImage: String?
                
                if let enclosure = itemObject["enclosure"].all {
                    if (enclosure.count > 0) {
                        urlImage = enclosure[0].attributes["url"]
                    }
                }
                let item = Item(title: title, link: link, pubDate: pubDate, description: description, urlImage: urlImage, fullText: fullText, categories: categories)

                items.append(item)
            }
        }
        
        let title = xmlDoc.root["channel"]["title"].value
        let link = xmlDoc.root["channel"]["link"].value
        let description = xmlDoc.root["channel"]["description"].value
        
        let channel = Channel(title: title, link: link, description: description, items: items)
        
        return channel
    }
}
