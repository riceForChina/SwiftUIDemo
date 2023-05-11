//
//  AttributedString+Tool.swift
//  Avatar
//
//  Created by fan.qile on 2023/3/15.
//

import Foundation
import UIKit
// MARK: - 对NSAttributedString的扩展
public extension NSAttributedString{
    
    /// 初始化属性字符串
    ///
    /// - Parameters:
    ///   - string: 字符串
    ///   - color: 颜色值。默认是黑色
    ///   - font: 字体。默认是系统字体14
    convenience init(string:String,color:UIColor = UIColor.black,font:UIFont = UIFont.systemFont(ofSize: 14)){
        self.init(string: string, attributes: [NSAttributedString.Key.foregroundColor:color,NSAttributedString.Key.font:font])
    }
    
    /// 初始化属性字符串
    ///
    /// - Parameters:
    ///   - string: 字符串
    ///   - colorHex: 十六进制颜色UInt值。默认是黑色
    ///   - fontSize: 系统字体大小。默认是14
    convenience init(string:String,colorHex:UInt = 0x000000,fontSize:CGFloat = 14){
        self.init(string: string, color: UIColor.init(hex: Int(colorHex)), font: UIFont.systemFont(ofSize: fontSize))
    }
    
    func calculateSize(maxSize: CGSize) -> CGSize{
        
        let option = UInt8(NSStringDrawingOptions.usesLineFragmentOrigin.rawValue)|UInt8(NSStringDrawingOptions.usesFontLeading.rawValue)
        
        let size = self.boundingRect(with: maxSize, options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.RawValue(option)), context: nil).size
        
        return CGSize(width: size.width, height: ceil(size.height))
    }
}

// MARK: - 对NSMutableAttributedString的扩展
public extension NSMutableAttributedString{

    /// 追加属性字符串
    ///
    /// - Parameters:
    ///   - string: 字符串文本
    ///   - colorHex: 16进制颜色
    ///   - fontSize: 字体大小
    /// - Returns: 自身
    @discardableResult
    func append(string:String,colorHex:UInt,fontSize:CGFloat) -> Self{
        append(NSAttributedString(string: string, color: UIColor.init(hex: Int(colorHex)), font: UIFont.systemFont(ofSize: fontSize)))
        return self
    }
    
    /// 追加属性字符串
    ///
    /// - Parameters:
    ///   - string: 字符串文本
    ///   - color: 颜色值
    ///   - fontSize: 字体大小
    /// - Returns: 自身
    func append(string:String,color:UIColor,fontSize:CGFloat) -> Self{
        append(NSAttributedString(string: string, color: color, font: UIFont.systemFont(ofSize: fontSize)))
        return self
    }

    /// 追加属性字符串
    ///
    /// - Parameters:
    ///   - string: 字符串文本
    ///   - color: 颜色值
    ///   - font: 字体
    /// - Returns: 自身
    func append(string: String, color: UIColor, font: UIFont) -> Self {
        append(NSAttributedString(string: string, color: color, font: font))
        return self
    }
    
    /// 设置行间距
    ///
    /// - Parameters:
    ///   - space: 间距值
    ///   - paragraphSpacing: 段落间距值。默认为0。
    ///   - textAlignment: 文本对齐方式。默认左对齐
    ///   - lineBreakMode: 换行方式。默认按照单词折行。
    /// - Returns: 自身
    @discardableResult
    func setLineSpace(_ space:CGFloat, paragraphSpacing: CGFloat = 0, textAlignment:NSTextAlignment = .left,lineBreakMode:NSLineBreakMode = .byWordWrapping) -> Self{

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.lineSpacing = space
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineBreakMode = lineBreakMode
        paragraphStyle.paragraphSpacing = paragraphSpacing
        
        addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, string.utf16.count))
        return self
    }

    
    /// 设置删除线
    ///
    /// - Parameter color: 线颜色
    /// - Returns: self
    func setUnderLine(color: UIColor = UIColor(hex: 0xA8A8A8))->Self{
        
        let underLineNum = NSNumber(value:NSUnderlineStyle.thick.rawValue)
        
        let dic: [NSAttributedString.Key : Any] = [
            .strikethroughStyle : underLineNum,
            .baselineOffset: 0,
            .underlineColor : color]
        
        addAttributes(dic,range: NSMakeRange(0, string.utf16.count))
        
        return self
    }
}
