//
//  ScrollViewObservertView.swift
//  swiftUIDemo
//
//  Created by fan.qile on 2023/5/8.
//

import SwiftUI

struct ScrollViewObservertView: UIViewRepresentable {

    var offset: Binding<CGFloat>
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ScrollViewObservertView>) {
        if let temp = uiView as? ScrollViewObservertUIView {
            temp.scroll(to: offset.wrappedValue, animated: true)
        }
    }

    func makeUIView(context: Context) -> UIView {
        return ScrollViewObservertUIView(offset: offset, isOffsetX: false)
    }
}

class ScrollViewObservertUIView: UIView {
    
    var offset: Binding<CGFloat>
    let isOffsetX: Bool
    var showed = false
    var sv: UIScrollView?
    

    init(offset: Binding<CGFloat>, isOffsetX: Bool) {
        self.offset = offset
        self.isOffsetX = isOffsetX
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            
        /// 保证设置一次监听
        if showed {
            return
        }
        showed = true
        
        /// 查找UIScrollView
        ///
        sv = findScrollView(in: self.currentViewControler()?.view)
        print("ScrollViewObservertUIView - layoutSubviews sv = \(sv)")
        /// 设置监听
        sv?.addObserver(self,
                        forKeyPath: #keyPath(UIScrollView.contentOffset),
                        options: [.old, .new],
                        context: nil)
        
        /// 滚动到指定位置
        scroll(to: offset.wrappedValue, animated: false)
        
        
    }
    
    deinit {
        sv?.removeObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset))
    }
    
    func scroll(to position: CGFloat, animated: Bool = true) {
        print("position = \(position)")
        if let s = sv {
            if position != (self.isOffsetX ? s.contentOffset.x : s.contentOffset.y) {
                let offset = self.isOffsetX ? CGPoint(x: position, y: 0) : CGPoint(x: 0, y: position)
                sv?.setContentOffset(offset, animated: animated)
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey: Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(UIScrollView.contentOffset) {
            if let s = self.sv {
                DispatchQueue.main.async {
                    self.offset.wrappedValue = self.isOffsetX ? s.contentOffset.x : s.contentOffset.y
                }
            }
        }
    }
    
    func findScrollView(in view: UIView?) -> UIScrollView? {
        if view?.isKind(of: UIScrollView.self) ?? false {
            return view as? UIScrollView
        }
        
        for subview in view?.subviews ?? [] {
            if let sv = findScrollView(in: subview) {
                return sv
            }
        }
        
        return nil
    }
}

extension UIView {
    func currentViewControler() -> UIViewController? {
        guard let nextView = self.next else {
            return nil
        }
        
        if let temp = nextView as? UIViewController {
            return temp
        }
        
        if let temp = nextView as? UIView {
            return temp.currentViewControler()
        }
        
        return nil
        
    }
}
