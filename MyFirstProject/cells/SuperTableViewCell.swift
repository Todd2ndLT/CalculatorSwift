//
//  SuperTableViewCell.swift
//  MyFirstProject
//
//  Created by Methos on 8/21/20.
//  Copyright © 2020 Todd. All rights reserved.
//

import UIKit

class SuperTableViewCell: UITableViewCell {
    
    var onClickInterface: OnCellClickInterface?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        for n in 0...18 {
            let vButton:UIButton = UIButton.init()
            vButton.addTarget(self, action: #selector(OnClickListener), for: .touchDown)
            vButton.layer.borderWidth = 1
            vButton.layer.borderColor = UIColor.init(red: 53, green: 56, blue: 58).cgColor
            vButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 31.25)
            
            switch n {
                case 0:
                    vButton.setTitle("AC", for: .normal)
                    vButton.backgroundColor = UIColor.init(red: 75, green: 77, blue: 80) //DARK GRAY
                    break
                case 1:
                    vButton.setTitle("+/-", for: .normal)
                    vButton.backgroundColor = UIColor.init(red: 75, green: 77, blue: 80) //DARK GRAY
                    break
                case 2:
                    vButton.setTitle("%", for: .normal)
                    vButton.backgroundColor = UIColor.init(red: 75, green: 77, blue: 80) //DARK GRAY
                    break
                case 3:
                    vButton.setTitle("/", for: .normal)
                    vButton.backgroundColor = UIColor.init(red: 248, green: 159, blue: 11) //ORANGE
                    break
                case 4:
                    vButton.setTitle("7", for: .normal)
                    vButton.backgroundColor = UIColor.init(red: 108, green: 110, blue: 111) //GRAY
                    break
                case 5:
                    vButton.setTitle("8", for: .normal)
                    vButton.backgroundColor = UIColor.init(red: 108, green: 110, blue: 111) //GRAY
                    break
                case 6:
                    vButton.setTitle("9", for: .normal)
                    vButton.backgroundColor = UIColor.init(red: 108, green: 110, blue: 111) //GRAY
                    break
                case 7:
                    vButton.setTitle("x", for: .normal)
                    vButton.backgroundColor = UIColor.init(red: 248, green: 159, blue: 11) //ORANGE
                    break
                case 8:
                    vButton.setTitle("4", for: .normal)
                    vButton.backgroundColor = UIColor.init(red: 108, green: 110, blue: 111) //GRAY
                    break
                case 9:
                    vButton.setTitle("5", for: .normal)
                    vButton.backgroundColor = UIColor.init(red: 108, green: 110, blue: 111) //GRAY
                    break
                case 10:
                    vButton.setTitle("6", for: .normal)
                    vButton.backgroundColor = UIColor.init(red: 108, green: 110, blue: 111) //GRAY
                    break
                case 11:
                    vButton.setTitle("-", for: .normal)
                    vButton.backgroundColor = UIColor.init(red: 248, green: 159, blue: 11) //ORANGE
                    break
                case 12:
                    vButton.setTitle("1", for: .normal)
                    vButton.backgroundColor = UIColor.init(red: 108, green: 110, blue: 111) //GRAY
                    break
                case 13:
                    vButton.setTitle("2", for: .normal)
                    vButton.backgroundColor = UIColor.init(red: 108, green: 110, blue: 111) //GRAY
                    break
                case 14:
                    vButton.setTitle("3", for: .normal)
                    vButton.backgroundColor = UIColor.init(red: 108, green: 110, blue: 111) //GRAY
                    break
                case 15:
                    vButton.setTitle("+", for: .normal)
                    vButton.backgroundColor = UIColor.init(red: 248, green: 159, blue: 11) //ORANGE
                    break
                case 16:
                    vButton.setTitle("0", for: .normal)
                    vButton.backgroundColor = UIColor.init(red: 108, green: 110, blue: 111) //GRAY
                    break
                case 17:
                    vButton.setTitle(".", for: .normal)
                    vButton.backgroundColor = UIColor.init(red: 108, green: 110, blue: 111) //GRAY
                    break
                case 18:
                    vButton.setTitle("=", for: .normal)
                    vButton.backgroundColor = UIColor.init(red: 248, green: 159, blue: 11) //ORANGE
                    break
                default:
                    break
            }
            self.addSubview(vButton)
        }
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
    }
    
    @objc func OnClickListener(_ sender: UIButton) {
        self.onClickInterface?.Clicked(sender.currentTitle!)
    }
}

protocol OnCellClickInterface: class {
    func Clicked(_ char: String)
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }

    static func random() -> UIColor {
        return UIColor(rgb: Int(CGFloat(arc4random()) / CGFloat(UINT32_MAX) * 0xFFFFFF))
    }
}
