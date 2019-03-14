//
//  LayoutButtonCollectionViewCell.swift
//  assignment
//
//  Created by Chris Chen on 2019/3/13.
//  Copyright © 2019 Dev4App. All rights reserved.
//

import UIKit

class LayoutButtonCollectionViewCell: UICollectionViewCell {
    
    var contentBackgroundView = UIView()
    var contentSubview = UIView()
    
    let aButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // contentBackgroundView
        contentBackgroundView.backgroundColor = .white
        contentView.addSubview(contentBackgroundView)
        
        // contentSubview
        contentSubview.backgroundColor = UIColor(displayP3Red: 0.188, green: 0.188, blue: 0.188, alpha: 1.0)
        contentView.addSubview(contentSubview)
        
        contentBackgroundView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom).offset(-1)
            make.leading.equalTo(contentView.snp.leading).offset(1)
            make.trailing.equalTo(contentView.snp.trailing).offset(-1)
        }
        
        contentSubview.snp.makeConstraints { (make) in
            make.top.equalTo(contentBackgroundView.snp.top).offset(5)
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
        }
        
        addContentSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - helper functions

    func initialCell() {
        backgroundColor = .white
        aButton.backgroundColor = UIColor(displayP3Red: 0.188, green: 0.188, blue: 0.188, alpha: 1.0)
        aButton.removeTarget(nil, action: nil, for: .allEvents)
    }
    
    func addContentSubviews() {
        // aButton
        aButton.backgroundColor = UIColor(displayP3Red: 0.188, green: 0.188, blue: 0.188, alpha: 1.0)
        aButton.layer.cornerRadius = 5
        aButton.layer.borderColor = UIColor.white.cgColor
        aButton.layer.borderWidth = 2
        aButton.titleLabel?.adjustsFontSizeToFitWidth = true
        contentSubview.addSubview(aButton)
        
        addContentSubviewConstraints()
    }
    
    func addContentSubviewConstraints() {
        
        aButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentSubview.snp.top).offset(5)
            make.bottom.equalTo(contentSubview.snp.bottom).offset(-5)
            make.leading.equalTo(contentSubview.snp.leading).offset(5)
            make.trailing.equalTo(contentSubview.snp.trailing).offset(-5)
        }
    }
}
