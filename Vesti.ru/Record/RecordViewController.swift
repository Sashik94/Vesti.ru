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
    @IBOutlet weak var imageOnLayoutConstraint: NSLayoutConstraint!
    
    var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load()
    }
    
    func load() {
        if let urlImage = item.urlImage {
            if let url = URL(string: urlImage) {
                
                if let imageData = try? Data(contentsOf: url) {
                    imageOnLayoutConstraint.isActive = true
                    mainImageView.image = UIImage(data: imageData)
                    
                    titleLabel.text = item.title!
                    fullTextLabel.text = item.fullText
                } else {
                    errorAlert(with: "Ошибка соединения с интернетом")
                }
            }
        }
    }
    
    func errorAlert(with title: String) {
        let alertController = UIAlertController(title: title, message: "Повторите попытку.", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            self.navigationController?.popViewController(animated: true)
        })
        let tryAgainAction = UIAlertAction(title: "Повторить", style: .default) { [weak self] (_) in
            self?.load()
        }
        
        alertController.addAction(tryAgainAction)
        alertController.addAction(closeAction)
        
        present(alertController, animated: true)
    }
}
