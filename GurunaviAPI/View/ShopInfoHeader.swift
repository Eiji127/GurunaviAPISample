//
//  ShopInfoHeader.swift
//  GurunaviAPI
//
//  Created by 白数叡司 on 2020/12/24.
//

import UIKit

protocol ShopInfoCellDelegate: class {
    func showActionSheet()
}

class ShopInfoHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    var shopInfo: ShopInfo? {
        didSet {
            configure()
        }
    }

    weak var delegate: ShopInfoCellDelegate?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Shop Name"
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Category"
        return label
    }()
    
    private let opentimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Opentime: 10:00 ~ 21:00"
        return label
    }()
    
    
    private lazy var optionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .lightGray
        button.setImage(UIImage(named: "down_arrow_24pt"), for: .normal)
        button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let infoStack = UIStackView(arrangedSubviews: [categoryLabel, opentimeLabel])
        infoStack.axis = .horizontal
        infoStack.distribution = .fillProportionally
        infoStack.spacing = 6
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, infoStack])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 10)
        
        addSubview(optionButton)
        optionButton.centerY(inView: stack)
        optionButton.anchor(right: rightAnchor, paddingRight: 10)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        GurunaviService.shared.fetchData { shopInfo in
            print(shopInfo)
        }
        
    }
    
    @objc func showActionSheet() {
        delegate?.showActionSheet()
    }
    
}
