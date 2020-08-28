//
//  ViewController.swift
//  MyFirstProject
//
//  Created by Methos on 8/14/20.
//  Copyright © 2020 Todd. All rights reserved.
//

import UIKit

var screen_width = UIScreen.main.bounds.width
var screen_height = UIScreen.main.bounds.height

let window = UIWindow.self

class ViewController: UIViewController {
    
    var label: SuperLabel!
    var table: SuperTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 52/255, green: 55/255, blue: 57/255, alpha: 1)
        
        label = SuperLabel.init(frame: CGRect(x: 0, y: 20, width: screen_width, height: screen_height * 20 / 100))
        label.text = "0"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: label.bounds.height * 46.25 / 100)
        label.superAlignment = .bottomRight
        label.paddingTop = 0.0
        label.paddingRight = 5.0
        label.paddingBottom = 0.0
        label.paddingLeft = 5.0
        //label.wrapContent()
        self.view.addSubview(label)
        
        table = SuperTableView.init(frame: CGRect(x: 0, y: screen_height / 100 * 20 + 20, width: screen_width, height: screen_height - (screen_height * 20 / 100 + 20)))
        table.id = "TableForButtons"
        table.register(SuperTableViewCell.self, forCellReuseIdentifier: table.id)
        table.delegate = table.self
        table.dataSource = table.self
        table.label = label
        self.view.addSubview(table)
    }
    
    //======================================
    //  Todd MatrixNeo's super UITableView
    //======================================
    public class SuperTableView: UITableView, UITableViewDelegate, UITableViewDataSource, OnCellClickInterface {
        
        var vOperand1:String = ""
        var vOperand2:String = ""
        var vOperator:String = ""
        var vResult:Double = 0
        var vIsSecondOperand:Bool = false
        
        var columns: Int = 4
        var rows: Int = 5
        var id: String!
        var label:SuperLabel!

        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return self.frame.height / CGFloat(1)
        }
        
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let vCell = self.dequeueReusableCell(withIdentifier: self.id, for: indexPath ) as! SuperTableViewCell
            vCell.selectionStyle = .none
            vCell.onClickInterface = self
            var colIndex:Int = 0
            var rowIndex:Int = 0
            for i in 0..<vCell.subviews.count {
                if(vCell.subviews[i].isKind(of: UIButton.self)){
                    let vButton = vCell.subviews[i] as! UIButton
                    
                    var vW:CGFloat = vCell.bounds.size.width / CGFloat(columns)
                    let vH:CGFloat = vCell.bounds.size.height / CGFloat(rows)
                    if(i==17){
                        vW = vCell.bounds.size.width / CGFloat(columns) * 2
                    }
                    
                    let vX:CGFloat = CGFloat(colIndex) * vW
                    let vY:CGFloat = CGFloat(rowIndex) * vH
                    
                    vButton.frame = CGRect(x: vX, y: vY, width: vW, height: vH)
                    if(colIndex < columns - 1){
                        if(i==17){
                            colIndex+=2
                        }
                        else {
                            colIndex+=1
                        }
                    }
                    else {
                        rowIndex += 1
                        colIndex = 0
                    }
                }
            }
            
            return vCell
        }
        
        func Clicked(_ char: String) {
            switch char {
                case "AC":
                    vOperand1 = "";
                    vOperand2 = "";
                    vOperator = "";
                    vIsSecondOperand = false
                    label.text = "0"
                    break
                case "+/-":
                    if(!vIsSecondOperand){
                        vOperand1 = String(Double(vOperand1)! * -1)
                        label.text = vOperand1
                    }
                    else {
                        vOperand2 = String(Double(vOperand2)! * -1)
                        label.text = vOperand2
                    }
                    break
                case "%":
                    //Do something
                    break
                case "/":
                    if(vOperand1.count > 0 && vOperand2.count > 0){
                        calc()
                    }
                    else {
                        vOperator = "/"
                        vIsSecondOperand = true
                    }
                    break
                case "x":
                    if(vOperand1.count > 0 && vOperand2.count > 0){
                        calc()
                    }
                    else {
                        vOperator = "x"
                        vIsSecondOperand = true
                    }
                    break
                case "-":
                    if(vOperand1.count > 0 && vOperand2.count > 0){
                        calc()
                    }
                    else {
                        vOperator = "-"
                        vIsSecondOperand = true
                    }
                    break
                case "+":
                    if(vOperand1.count > 0 && vOperand2.count > 0){
                        calc()
                    }
                    else {
                        vOperator = "+"
                        vIsSecondOperand = true
                    }
                    break
                case ".":
                    if(!vIsSecondOperand){
                        if(!vOperand1.contains(".") && vOperand1.count > 0){
                            vOperand1.append(".")
                        }
                        else if(!vOperand1.contains(".")) {
                            vOperand1.append("0.")
                        }
                        label.text = vOperand1
                    }
                    else {
                        if(!vOperand2.contains(".") && vOperand2.count > 0){
                            vOperand2.append(".")
                        }
                        else if(!vOperand2.contains(".")) {
                            vOperand2.append("0.")
                        }
                        label.text = vOperand2
                    }
                    break
                case "=":
                    calc()
                    vOperator = ""
                    break
                case "0":
                    if(!vIsSecondOperand && vOperand1.count > 0){
                        vOperand1.append("0")
                        label.text = vOperand1
                    }
                    else if(vIsSecondOperand && vOperand2.count > 0){
                        vOperand2.append("0")
                        label.text = vOperand2
                    }
                    break
                default:
                    if(!vIsSecondOperand){
                        vOperand1.append(char)
                        label.text = vOperand1
                    }
                    else {
                        vOperand2.append(char)
                        label.text = vOperand2
                    }
                    break
            }
        }
        
        func calc(){
            switch(vOperator){
                case "/":
                    vOperand1 = String((Double(vOperand1)! / Double(vOperand2)!).removeZerosFromEnd())
                    break
                case "x":
                    vOperand1 = String((Double(vOperand1)! * Double(vOperand2)!).removeZerosFromEnd())
                    break
                case "-":
                    vOperand1 = String((Double(vOperand1)! - Double(vOperand2)!).removeZerosFromEnd())
                    break
                case "+":
                    vOperand1 = String((Double(vOperand1)! + Double(vOperand2)!).removeZerosFromEnd())
                    break
                default:
                    break
            }
            vIsSecondOperand = false
            vOperand2 = ""
            label.text = vOperand1
        }
    }
    
    //==================================
    //  Todd MatrixNeo's super UILabel
    //==================================
    public class SuperLabel: UILabel {
        
        private var isWrappable = false
        
        var paddingLeft:CGFloat = 0.0
        var paddingRight:CGFloat = 0.0
        var paddingTop:CGFloat = 0.0
        var paddingBottom:CGFloat = 0.0
        
        var vSuitableSize:CGSize = CGSize()
        var superAlignment : SuperAlignment = .middleCenter {
            didSet {
                setNeedsDisplay()
            }
        }

        override public func drawText(in rect: CGRect) {
            let r = self.textRect(forBounds: rect, limitedToNumberOfLines: self.numberOfLines)
            let insets = UIEdgeInsets(top: paddingTop, left: paddingLeft, bottom: paddingBottom, right: paddingRight)
            super.drawText(in: r.inset(by: insets))
        }
        
        public func wrapContent(){
            vSuitableSize = self.sizeThatFits(CGSize(width: self.bounds.size.width, height: CGFloat.greatestFiniteMagnitude))
            isWrappable = true
        }
        
        override public func textRect(forBounds bounds: CGRect, limitedToNumberOfLines: Int) -> CGRect {
            
            let rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: limitedToNumberOfLines)
            var vRect:CGRect!
            
            switch superAlignment {
                case .topLeft:
                    if(isWrappable){
                        vRect = CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y + paddingTop, width: vSuitableSize.width + (paddingLeft + paddingRight), height: vSuitableSize.height + (paddingTop + paddingBottom))
                    }
                    else {
                        vRect = CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y + paddingTop, width: rect.size.width + (paddingLeft + paddingRight), height: rect.size.height + (paddingTop + paddingBottom))
                    }
                    break
                case .topCenter:
                    if(isWrappable){
                        vRect = CGRect(x: (self.bounds.size.width - rect.size.width) / 2, y: bounds.origin.y + paddingTop, width: vSuitableSize.width + (paddingLeft + paddingRight), height: vSuitableSize.height + (paddingTop + paddingBottom))
                    }
                    else {
                        vRect = CGRect(x: (self.bounds.size.width - rect.size.width) / 2, y: bounds.origin.y + paddingTop, width: rect.size.width + (paddingLeft + paddingRight), height: rect.size.height + (paddingTop + paddingBottom))
                    }
                    break
                case .topRight:
                    if(isWrappable){
                        vRect = CGRect(x: self.bounds.size.width - rect.size.width - paddingRight - paddingLeft, y: bounds.origin.y + paddingTop, width: vSuitableSize.width + (paddingLeft + paddingRight), height: vSuitableSize.height + (paddingTop + paddingBottom))
                    }
                    else {
                        vRect = CGRect(x: self.bounds.size.width - rect.size.width - paddingRight - paddingLeft, y: bounds.origin.y + paddingTop, width: rect.size.width + (paddingLeft + paddingRight), height: rect.size.height + (paddingTop + paddingBottom))
                    }
                    break
                case .middleLeft:
                    if(isWrappable){
                        vRect = CGRect(x: self.bounds.origin.x + paddingLeft, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: vSuitableSize.width + (paddingLeft + paddingRight), height: vSuitableSize.height + (paddingTop + paddingBottom))
                    }
                    else {
                        vRect = CGRect(x: self.bounds.origin.x + paddingLeft, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: rect.size.width + (paddingLeft + paddingRight), height: rect.size.height + (paddingTop + paddingBottom))
                    }
                    break
                case .middleCenter:
                    if(isWrappable){
                        vRect = CGRect(x: (self.bounds.size.width - rect.size.width) / 2, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: vSuitableSize.width  + (paddingLeft + paddingRight), height: vSuitableSize.height  + (paddingTop + paddingBottom))
                    }
                    else {
                        vRect = CGRect(x: (self.bounds.size.width - rect.size.width) / 2, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: rect.size.width + (paddingLeft + paddingRight), height: rect.size.height + (paddingTop + paddingBottom))
                    }
                    break
                case .middleRight:
                    if(isWrappable){
                        vRect = CGRect(x: self.bounds.size.width - rect.size.width - paddingRight - paddingLeft, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: vSuitableSize.width + (paddingLeft + paddingRight), height: vSuitableSize.height + (paddingTop + paddingBottom))
                    }
                    else {
                        vRect = CGRect(x: self.bounds.size.width - rect.size.width - paddingRight - paddingLeft, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: rect.size.width + (paddingLeft + paddingRight), height: rect.size.height + (paddingTop + paddingBottom))
                    }
                    break
                case .bottomLeft:
                    if(isWrappable){
                        vRect = CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y + (bounds.size.height - rect.size.height) - paddingBottom - paddingTop, width: vSuitableSize.width + (paddingLeft + paddingRight), height: vSuitableSize.height + (paddingTop + paddingBottom))
                    }
                    else {
                        vRect = CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y + (bounds.size.height - rect.size.height) - paddingBottom - paddingTop, width: rect.size.width + (paddingLeft + paddingRight), height: rect.size.height + (paddingTop + paddingBottom))
                    }
                    break
                case .bottomCenter:
                    if(isWrappable){
                        vRect = CGRect(x: (self.bounds.size.width - rect.size.width) / 2, y: bounds.origin.y + (bounds.size.height - rect.size.height) - paddingBottom, width: vSuitableSize.width + (paddingLeft + paddingRight), height: vSuitableSize.height + (paddingTop + paddingBottom))
                    }
                    else {
                        vRect = CGRect(x: (self.bounds.size.width - rect.size.width) / 2, y: bounds.origin.y + (bounds.size.height - rect.size.height) - paddingBottom, width: rect.size.width + (paddingLeft + paddingRight), height: rect.size.height + (paddingTop + paddingBottom))
                    }
                    break
                case .bottomRight:
                    if(isWrappable){
                        vRect = CGRect(x: self.bounds.size.width - rect.size.width - paddingRight - paddingLeft, y: bounds.origin.y + (bounds.size.height - rect.size.height) - paddingBottom, width: vSuitableSize.width + (paddingLeft + paddingRight), height: vSuitableSize.height + (paddingTop + paddingBottom))
                    }
                    else {
                        vRect = CGRect(x: self.bounds.size.width - rect.size.width - paddingRight - paddingLeft, y: bounds.origin.y + (bounds.size.height - rect.size.height) - paddingBottom, width: rect.size.width + paddingLeft + paddingRight, height: rect.size.height + (paddingTop + paddingBottom))
                    }
                    break
            }
            
            return vRect
        }
        
        enum SuperAlignment {
            case topLeft
            case topCenter
            case topRight
            case middleLeft
            case middleCenter
            case middleRight
            case bottomLeft
            case bottomCenter
            case bottomRight
        }
    }
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
