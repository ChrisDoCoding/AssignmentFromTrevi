//
//  LayoutCollectionViewCell.swift
//  assignment
//
//  Created by Chris Chen on 2019/3/13.
//  Copyright © 2019 Dev4App. All rights reserved.
//

import UIKit
import SnapKit

class LayoutViewCollectionViewCell: UICollectionViewCell {
    
    var contentSubview = UIView()
    
    let upView = UIView()
    let downView = UIView()
    let randomLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        // ContentSubview
        contentSubview.backgroundColor = .white
        contentView.addSubview(contentSubview)
        
        backgroundColor = .white
        randomLabel.isHidden = true
        addContentViewConstraints()
        addContentSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - helper functions
    
    func addContentViewConstraints(isFirstRow bool: Bool = false) {
        // default is false
        contentSubview.snp.remakeConstraints { (make) in
            if bool {
                make.top.equalTo(contentView.snp.top).offset(1)
            } else {
                make.top.equalTo(contentView.snp.top)
            }
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.equalTo(contentView.snp.leading).offset(1)
            make.trailing.equalTo(contentView.snp.trailing).offset(-1)
        }
    }
    
    func initialCell() {
        backgroundColor = .white
        randomLabel.isHidden = true
        addContentViewConstraints()
    }
    
    func addContentSubviews() {
        // upView
        contentSubview.addSubview(upView)
        
        // downView
        contentSubview.addSubview(downView)
        
        // randamLabel
        randomLabel.text = "random"
        randomLabel.isHidden = true
        randomLabel.textAlignment = .center
        randomLabel.adjustsFontSizeToFitWidth = true
        contentSubview.addSubview(randomLabel)
        
        addContentSubviewConstraints()
    }
    
    func addContentSubviewConstraints() {
        
        upView.snp.makeConstraints { (make) in
            make.height.equalTo(downView.snp.height).multipliedBy(7)
            make.top.equalTo(contentSubview.snp.top).offset(5)
            make.leading.equalTo(contentSubview.snp.leading)
            make.trailing.equalTo(contentSubview.snp.trailing)
        }
        
        downView.snp.makeConstraints { (make) in
            make.top.equalTo(upView.snp.bottom)
            make.bottom.equalTo(contentSubview.snp.bottom).offset(-3)
            make.leading.equalTo(contentSubview.snp.leading)
            make.trailing.equalTo(contentSubview.snp.trailing)
        }
        
        randomLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(upView.snp.centerY)
            make.leading.equalTo(upView.snp.leading)
            make.trailing.equalTo(upView.snp.trailing)
        }
    }
}
