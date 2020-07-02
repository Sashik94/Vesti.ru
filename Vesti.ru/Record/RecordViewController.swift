//
//  RecordViewController.swift
//  Vesti.ru
//
//  Created by Александр Осипов on 02.07.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var mainScrllView: UIScrollView!
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fullTextLabel: UILabel!
    
    var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urlImage = item.urlImage {
            if let url = URL(string: urlImage) {
                mainImageView.image = UIImage(data: try! Data(contentsOf: url))
            }
        }
        titleLabel.text = "   " + item.title!
        fullTextLabel.text = item.fullText
    }
}
