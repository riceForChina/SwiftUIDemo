//
//  CustomTextFiledView.swift
//  swiftUIDemo
//
//  Created by fan.qile on 2023/4/28.
//

import SwiftUI

struct CustomTextFiledView: UIViewRepresentable {
    
    var onEditBlock: ((String) -> ())?
    var attributedPlaceholder: NSMutableAttributedString?
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<CustomTextFiledView>) {
    }

    func makeUIView(context: Context) -> UIView {
        let tempView = CustomTextFiledUIView(frame: .zero)
        tempView.onEditBlock = onEditBlock
        tempView.textFile.attributedPlaceholder = attributedPlaceholder
        return tempView
    }
}

class CustomTextFiledUIView: UIView {
    
    
    lazy var textFile: UITextField = {
        let temp = UITextField()
        temp.translatesAutoresizingMaskIntoConstraints = false
        let placeHolderColor = UIColor(hexString: "#c9c9c9")
        temp.attributedPlaceholder = NSMutableAttributedString()
            .append(string: "placeholder",
                    color: placeHolderColor,
                    font: UIFont.systemFont(ofSize: 16, weight: .medium))
        temp.borderStyle = .none
        temp.keyboardType = .default
        temp.textColor = UIColor.black
        
        temp.clearButtonMode = .never
        temp.returnKeyType = .done
        temp.textAlignment = .left
        temp.keyboardType = .numberPad
        temp.delegate = self
        temp.clearButtonMode = .never
        temp.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return temp
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.textFile)
        
        NSLayoutConstraint.activate([
            self.textFile.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.textFile.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.textFile.topAnchor.constraint(equalTo: self.topAnchor),
            self.textFile.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    var onEditBlock: ((String) -> ())?
}


extension CustomTextFiledUIView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var tempStr = (textField.text ?? "") as NSString
        tempStr = tempStr.replacingCharacters(in: range, with: string) as NSString
        
        if tempStr.length > 11 {
            textField.text = tempStr.substring(to: 11)
            self.onEditBlock?(textField.text ?? "")
            return false
        }
        self.onEditBlock?((tempStr) as String)
        return true
    }
}
