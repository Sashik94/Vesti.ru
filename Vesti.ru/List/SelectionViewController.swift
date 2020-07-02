//
//  SelectionViewController.swift
//  Vesti.ru
//
//  Created by Александр Осипов on 02.07.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var heightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    
    var categories: [String] = []
    var currentCategory: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableHeight: CGFloat
        
        tableHeight = CGFloat((categories.count * 44) + 88)
        heightLayoutConstraint.constant = tableHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Selection", for: indexPath) as! SelectionTableViewCell
        let track = categories[indexPath.row]
        cell.nameLabel.text = track
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCategory?(categories[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}
