//
//  ButtonTableViewCell.swift
//  MyFirstProject
//
//  Created by Methos on 8/20/20.
//  Copyright © 2020 Todd. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    var views:[UIView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        views = Array()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
//        self.addSubview(self.button1)
//        self.addSubview(self.button2)
//        self.addSubview(self.button3)
//        self.addSubview(self.button4)
        
    }
    
    let buttons: UIButton = {
        let sss = UIButton.init()
        
        return sss
    }()
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
    }
    
    public func add(_ pView: UIView){
        self.addSubview(pView)
    }
}
