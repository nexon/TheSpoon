//
//  SPNRestaurantDetailItemView.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 19-11-22.
//

import UIKit

final class SPNRestaurantDetailItemView: UIView {
    
    // MARK: - Private Properties
    
    private let imageView = UIImageView()
    private let informationLabel = UILabel(frame: .zero)
    
    // MARK: - Public Properties
    
    /// The text that will be along the icon.
    var text: String? {
        get { informationLabel.text }
        set { informationLabel.text = newValue }
    }
    
    /// Initializer
    ///
    /// - Parameter type: The type of Item that this View will represent. Can be `PriceRange`, `TypeCousine` and `Location`
    init(type: SPNRestaurantDetailItemType) {
        super.init(frame: .zero)
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 3
        stackView.axis = .horizontal
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = type.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        informationLabel.text = text
        informationLabel.font = .preferredFont(forTextStyle: .subheadline)
        informationLabel.numberOfLines = 0
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(informationLabel)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
