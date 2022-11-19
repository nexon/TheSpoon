//
//  SPNRestaurantHeaderTitleView.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 15-11-22.
//

import UIKit

class SPNRestaurantHeaderTitleView: UIView {
    // MARK: - Private Properties
    
    private let emptyImage = UIImage(named: "empty-heart")?.withRenderingMode(.alwaysOriginal)
    private let filledImage = UIImage(named: "filled-heart")?.withRenderingMode(.alwaysOriginal)
    private var titleLabel = UILabel()
    private var streetLabel = UILabel()
    private var stackView = UIStackView()
    private var informationStackView = UIStackView()
    private var favoriteButton = UIButton()
    
    // MARK: - Public Properties
    
    var onButtonPressed: (() -> Void)?
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var street: String? {
        get { streetLabel.text }
        set { streetLabel.text = newValue }
    }
    
    var isFavorite: Bool {
        didSet { favoriteButton.setImage(isFavorite ? filledImage : emptyImage, for: .normal) }
    }
    
    init(isFavorite: Bool = false) {
        self.isFavorite = false
        super.init(frame: .zero)
        backgroundColor = .clear

        // Main StackView that contains other views
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.backgroundColor = .clear
        
        // Restaurant Name Label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        
        // Address Label
        streetLabel.translatesAutoresizingMaskIntoConstraints = false
        streetLabel.font = .preferredFont(forTextStyle: .subheadline)
        streetLabel.numberOfLines = 0
        streetLabel.textColor = .white
        
        let stackViewStreet = UIStackView()
        stackViewStreet.translatesAutoresizingMaskIntoConstraints = false
        stackViewStreet.axis = .horizontal
        stackViewStreet.backgroundColor = .clear
        stackViewStreet.spacing = 5
        
        let addressIconView = UIImageView(image: UIImage(named: "location"))
        addressIconView.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewStreet.addArrangedSubview(addressIconView)
        stackViewStreet.addArrangedSubview(streetLabel)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
        
        // Information StackView that contains Title and Street
        informationStackView.axis = .vertical
        informationStackView.addArrangedSubview(titleLabel)
        informationStackView.addArrangedSubview(stackViewStreet)
        stackView.addArrangedSubview(informationStackView)

        // We add the favorite icon.
        
        let favoriteContainerView = UIView(frame: .zero)
        favoriteContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.setImage(emptyImage, for: .normal)
    
        favoriteButton.addTarget(self, action: #selector(didPressFavoriteButton(_:)), for: .touchUpInside)
        favoriteContainerView.addSubview(favoriteButton)
        
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: favoriteContainerView.topAnchor, constant: 10),
            favoriteButton.trailingAnchor.constraint(equalTo: favoriteContainerView.trailingAnchor, constant: -10),
            favoriteButton.heightAnchor.constraint(equalToConstant: 28),
            favoriteButton.widthAnchor.constraint(equalToConstant: 28)
        ])
        
        stackView.addArrangedSubview(favoriteContainerView)        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Function(s)
    
    @objc
    private func didPressFavoriteButton(_ sender: UIButton) {
        onButtonPressed?()
    }
}
