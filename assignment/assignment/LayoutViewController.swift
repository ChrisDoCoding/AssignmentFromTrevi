//
//  LayoutViewController.swift
//  assignment
//
//  Created by Chris Chen on 2019/3/13.
//  Copyright © 2019 Dev4App. All rights reserved.
//

import UIKit
import SnapKit

class LayoutViewController: UIViewController {
    
    var columnsCount: Int?
    var rowsCount: Int?
    var selectedIndex: IndexPath?
    
    var timer: Timer?

    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    private let layoutViewCell = "LayoutViewCell"
    private let layoutButtonCell = "LayoutButtonCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard
            let columnsCount = columnsCount,
            let rowsCount = rowsCount else {
                return
        }
        
        // Layout for CollectionView
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionViewWidth = Int(view.frame.width) - 2
        var collectionViewHeight = Int(view.frame.height) - ( Int(navigationController?.navigationBar.frame.height ?? 0) + 2)
        
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let topPadding = window?.safeAreaInsets.top
            let bottomPadding = window?.safeAreaInsets.bottom
            collectionViewHeight = collectionViewHeight - Int(topPadding ?? 0) - Int(bottomPadding ?? 0)
        }
        
        layout.itemSize = CGSize(width: Int(collectionViewWidth) / Int(columnsCount), height: Int(collectionViewHeight) / Int(rowsCount+1))
            
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LayoutViewCollectionViewCell.self, forCellWithReuseIdentifier: layoutViewCell)
        collectionView.register(LayoutButtonCollectionViewCell.self, forCellWithReuseIdentifier: layoutButtonCell)
        
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
                make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            } else {
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
        }
        
        // Setup Timer
        timer = Timer.scheduledTimer(timeInterval: 10,
                                     target: self,
                                     selector: #selector(getRandom),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    // MARK: - helper functions

    @objc func getRandom() {
        guard
            let columnsCount = columnsCount,
            let rowsCount = rowsCount else {
            return
        }
        let selectedColumnNumber = Int.random(in: 1...columnsCount) - 1
        let selectedRowNumber = Int.random(in: 1...rowsCount) - 1
        
        selectedIndex = IndexPath(item: selectedColumnNumber, section: selectedRowNumber)
        collectionView.reloadData()
    }
    
    @objc func reloadView() {
        // initial view
        selectedIndex = nil
        collectionView.reloadData()
    }
}

extension LayoutViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let rowsCount = rowsCount else {
            return 0
        }
        return rowsCount + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columnsCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section != rowsCount {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: layoutViewCell, for: indexPath) as? LayoutViewCollectionViewCell {
                
                cell.initialCell()
                
                if indexPath.section == 0 {
                    cell.addContentViewConstraints(isFirstRow: true)
                }
                
                let x = indexPath.section % 2
                if x == 0 {
                    cell.upView.backgroundColor = UIColor.theme.lightPink
                    cell.downView.backgroundColor = UIColor.theme.pink
                } else if x == 1 {
                    cell.upView.backgroundColor = UIColor.theme.lightGreen
                    cell.downView.backgroundColor = UIColor.theme.green
                }
                
                if let selectedIndex = selectedIndex {
                    if indexPath == selectedIndex {
                        cell.randomLabel.isHidden = false
                    }

                    if indexPath.row == selectedIndex.row {
                        cell.backgroundColor = UIColor.theme.highlightGreen
                    }
                }
                
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: layoutButtonCell, for: indexPath) as? LayoutButtonCollectionViewCell {
                
                cell.initialCell()
                cell.aButton.setTitle("確認", for: .normal)
                
                if let selectedIndex = selectedIndex {
                    if indexPath.row == selectedIndex.row {
                        cell.aButton.backgroundColor = UIColor.theme.highlightGreen
                        cell.backgroundColor = UIColor.theme.highlightGreen
                        cell.aButton.addTarget(self, action: #selector(reloadView), for: .touchUpInside)
                    }
                }
                return cell
            }
        }
        return UICollectionViewCell()
    }
}


