//
//  SPNRestaurantListTableViewCell.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 14-11-22.
//

import UIKit

final class SPNRestaurantListTableViewCell: UITableViewCell {

    // MARK: - Private Properties
    
    private static let emptyImage = UIImage(named: "empty-heart")?.withRenderingMode(.alwaysOriginal)
    private static let filledImage = UIImage(named: "filled-heart")?.withRenderingMode(.alwaysOriginal)
    private let locationView = SPNRestaurantDetailItemView(type: .location)
    private let priceRangeView = SPNRestaurantDetailItemView(type: .priceRange)
    private let cousineTypeView = SPNRestaurantDetailItemView(type: .typeCousine)
    private var favoriteButtonContainer = UIView(frame: .zero)
    private var favoriteButton = UIButton()
    private var stackView = UIStackView()
    private var restaurantImageView = UIImageView()
    private var restaurantTitleLabel = UILabel(frame: .zero)
    private var restaurantRatingLabel = UILabel(frame: .zero)
    private var restaurantBestOffer = UILabel(frame: .zero)
    private var informationStack = UIStackView()
    private var viewModel: SPNRestaurantListTableViewModel?
    private var onFavorite: ((_ identifier: String) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        isUserInteractionEnabled = true
        selectionStyle = .none
        
        configureStackView()
        configureRestaurantImageView()
        configureInformationViews()
        configureFavoriteButton()
        configureOfferView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configure the cell with the given text
    /// - Parameters:
    ///   - viewModel: The `viewModel` where the business logic and text for the specific row is located.
    ///   - onFavorite: A block that will be triggering the taps for favoriting the restaurant.
    func configure(with viewModel: SPNRestaurantListTableViewModel, onFavorite: @escaping (_ identifier: String) -> Void) {
        self.viewModel = viewModel
        self.onFavorite = onFavorite
        locationView.text = viewModel.location
        priceRangeView.text = viewModel.priceRange
        cousineTypeView.text = viewModel.type
        
        restaurantTitleLabel.text = viewModel.name
        restaurantRatingLabel.text = "\(viewModel.overallRating)"
        restaurantBestOffer.text = viewModel.bestOffer
        
        favoriteButton.addTarget(self, action: #selector(didPressFavoriteButton(_:)), for: .touchUpInside)
        
        favoriteButton.setImage(viewModel.isFavorite ? Self.filledImage : Self.emptyImage, for: .normal)
        viewModel.downloadImage { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case let .success(image):
                strongSelf.restaurantImageView.image = image
            case .failure(_):
                strongSelf.restaurantImageView.image = UIImage(named: "tf-logo")
                break
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel?.cancelDownload()
        restaurantImageView.image = nil
        favoriteButton.removeTarget(self, action: #selector(didPressFavoriteButton(_:)), for: .touchUpInside)
    }

    // MARK: - Private Properties
    
    private func configureStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func configureRestaurantImageView() {
        restaurantImageView.contentMode = .scaleAspectFit
        restaurantImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(restaurantImageView)
        
        NSLayoutConstraint.activate([
            restaurantImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureInformationViews() {
        stackView.addArrangedSubview(UIView())
        informationStack.axis = .vertical
        informationStack.spacing = 3
        
        // Restaurant Name
        
        let restaurantTitleContainerView = UIView(frame: .zero)
        restaurantTitleContainerView.translatesAutoresizingMaskIntoConstraints = false
        restaurantTitleContainerView.addSubview(restaurantTitleLabel)
        
        NSLayoutConstraint.activate([
            restaurantTitleLabel.topAnchor.constraint(equalTo: restaurantTitleContainerView.topAnchor),
            restaurantTitleLabel.trailingAnchor.constraint(equalTo: restaurantTitleContainerView.trailingAnchor),
            restaurantTitleLabel.bottomAnchor.constraint(equalTo: restaurantTitleContainerView.bottomAnchor),
            restaurantTitleLabel.leadingAnchor.constraint(equalTo: restaurantTitleContainerView.leadingAnchor, constant: 10),
        ])
        
        restaurantTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        restaurantTitleLabel.font = .preferredFont(forTextStyle: .headline)
        restaurantTitleLabel.numberOfLines = 0
        
        informationStack.addArrangedSubview(restaurantTitleContainerView)
        informationStack.addArrangedSubview(locationView)
        informationStack.addArrangedSubview(priceRangeView)
        informationStack.addArrangedSubview(cousineTypeView)
        
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        horizontalStackView.addArrangedSubview(informationStack)
        
        // Rating Information
        
        let ratingContainerView = UIView(frame: .zero)
        ratingContainerView.translatesAutoresizingMaskIntoConstraints = false
        restaurantRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        restaurantRatingLabel.layer.backgroundColor = UIColor.systemGray.cgColor
        restaurantRatingLabel.layer.cornerRadius = 18
        restaurantRatingLabel.layer.masksToBounds = true
        restaurantRatingLabel.font = .preferredFont(forTextStyle: .subheadline)
        restaurantRatingLabel.textAlignment = .center
        
        horizontalStackView.addArrangedSubview(ratingContainerView)
        ratingContainerView.addSubview(restaurantRatingLabel)
        
        NSLayoutConstraint.activate([
            restaurantRatingLabel.topAnchor.constraint(equalTo: ratingContainerView.topAnchor, constant: 10),
            restaurantRatingLabel.trailingAnchor.constraint(equalTo: ratingContainerView.trailingAnchor, constant: -10),
            restaurantRatingLabel.heightAnchor.constraint(equalToConstant: 36),
            restaurantRatingLabel.widthAnchor.constraint(equalToConstant: 36)
        ])
        
        stackView.addArrangedSubview(horizontalStackView)
    }
    
    private func configureFavoriteButton() {
        favoriteButtonContainer.backgroundColor = .white
        favoriteButtonContainer.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.setImage(Self.emptyImage, for: .normal)
        favoriteButtonContainer.addSubview(favoriteButton)
        
        addSubview(favoriteButtonContainer)
        contentView.bringSubviewToFront(favoriteButton)
        
        NSLayoutConstraint.activate([
            favoriteButtonContainer.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            favoriteButtonContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            favoriteButtonContainer.widthAnchor.constraint(equalToConstant: 40),
            favoriteButtonContainer.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.topAnchor.constraint(equalTo: favoriteButtonContainer.topAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: favoriteButtonContainer.trailingAnchor, constant: -10),
            favoriteButton.heightAnchor.constraint(equalToConstant: 28),
            favoriteButton.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func configureOfferView() {
        let offerViewContainer = UIView(frame: .zero)
        offerViewContainer.translatesAutoresizingMaskIntoConstraints = false
        offerViewContainer.backgroundColor = .cyan
        restaurantBestOffer.translatesAutoresizingMaskIntoConstraints = false
        restaurantBestOffer.font = .preferredFont(forTextStyle: .headline)
        restaurantBestOffer.numberOfLines = 0
        
        offerViewContainer.addSubview(restaurantBestOffer)
        addSubview(offerViewContainer)
        
        
        NSLayoutConstraint.activate([
            offerViewContainer.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            offerViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            offerViewContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 140),
            offerViewContainer.heightAnchor.constraint(equalToConstant: 30),
            restaurantBestOffer.topAnchor.constraint(equalTo: offerViewContainer.topAnchor),
            restaurantBestOffer.leadingAnchor.constraint(equalTo: offerViewContainer.leadingAnchor, constant: 10),
            restaurantBestOffer.bottomAnchor.constraint(equalTo: offerViewContainer.bottomAnchor),
            restaurantBestOffer.trailingAnchor.constraint(equalTo: offerViewContainer.trailingAnchor),
        ])
    }
    
    @objc
    private func didPressFavoriteButton(_ sender: UIButton) {
        guard let identifier = viewModel?.identifier else { return }
        onFavorite?(identifier)
    }
}
