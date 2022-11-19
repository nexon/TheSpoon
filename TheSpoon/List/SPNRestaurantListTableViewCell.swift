//
//  SPNRestaurantListTableViewCell.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 14-11-22.
//

import UIKit

class SPNRestaurantListTableViewCell: UITableViewCell {

    // MARK: - Private Properties
  
    private let emptyImage = UIImage(named: "empty-heart")?.withRenderingMode(.alwaysOriginal)
    private let filledImage = UIImage(named: "filled-heart")?.withRenderingMode(.alwaysOriginal)
    private var favoriteButtonContainer = UIView(frame: .zero)
    private var favoriteButton = UIButton()
    private var stackView = UIStackView()
    private var restaurantImageView = UIImageView()
    private var restaurantTitleLabel = UILabel(frame: .zero)
    private var restaurantLocationLabel = UILabel(frame: .zero)
    private var restaurantPriceRangeLabel = UILabel(frame: .zero)
    private var restaurantRatingLabel = UILabel(frame: .zero)
    private var restaurantCousineTypeLabel = UILabel(frame: .zero)
    private var restaurantBestOffer = UILabel(frame: .zero)
    private var informationStack = UIStackView()
    private var viewModel: SPNRestaurantListTableViewModel?
    private var onFavorite: ((_ identifier: String) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Configure the cell with the given information
    /// - Parameters:
    ///   - viewModel: The `viewModel` where the business logic and information for the specific row is located.
    ///   - onFavorite: A block that will be triggering the taps for favoriting the restaurant.
    func configure(with viewModel: SPNRestaurantListTableViewModel, onFavorite: @escaping (_ identifier: String) -> Void) {
        self.viewModel = viewModel
        self.onFavorite = onFavorite
        restaurantTitleLabel.text = viewModel.name
        restaurantLocationLabel.text = viewModel.location
        restaurantPriceRangeLabel.text = viewModel.priceRange
        restaurantRatingLabel.text = "\(viewModel.overallRating)"
        restaurantCousineTypeLabel.text = viewModel.type
        restaurantBestOffer.text = viewModel.bestOffer
        
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
        
        restaurantTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        restaurantTitleLabel.font = .preferredFont(forTextStyle: .headline)
        restaurantTitleLabel.numberOfLines = 0
        
        informationStack.addArrangedSubview(restaurantTitleLabel)
        
        // Restaurant Location
        
        let locationContainer = UIStackView()
        locationContainer.translatesAutoresizingMaskIntoConstraints = false
        locationContainer.spacing = 3
        locationContainer.axis = .horizontal
        
        locationContainer.addArrangedSubview(UIImageView(image: UIImage(named:"location")))
        restaurantLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        restaurantLocationLabel.font = .preferredFont(forTextStyle: .subheadline)
        restaurantLocationLabel.numberOfLines = 0
        
        locationContainer.addArrangedSubview(restaurantLocationLabel)
        
        informationStack.addArrangedSubview(locationContainer)
        
        // Restaurant Price Range
        
        let priceRangeContainer = UIStackView()
        priceRangeContainer.translatesAutoresizingMaskIntoConstraints = false
        priceRangeContainer.spacing = 3
        priceRangeContainer.axis = .horizontal
        
        priceRangeContainer.addArrangedSubview(UIImageView(image: UIImage(named: "cash")))
        restaurantPriceRangeLabel.translatesAutoresizingMaskIntoConstraints = false
        restaurantPriceRangeLabel.font = .preferredFont(forTextStyle: .caption1)
        restaurantPriceRangeLabel.numberOfLines = 0
        
        priceRangeContainer.addArrangedSubview(restaurantPriceRangeLabel)
        
        informationStack.addArrangedSubview(priceRangeContainer)
        
        // Restaurant Cousine type
        
        let cousineTypeContainer = UIStackView()
        cousineTypeContainer.translatesAutoresizingMaskIntoConstraints = false
        cousineTypeContainer.spacing = 3
        cousineTypeContainer.axis = .horizontal
        cousineTypeContainer.addArrangedSubview(UIImageView(image: UIImage(named: "food")))
        restaurantCousineTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        restaurantCousineTypeLabel.font = .preferredFont(forTextStyle: .caption1)
        restaurantCousineTypeLabel.numberOfLines = 0
        
        cousineTypeContainer.addArrangedSubview(restaurantCousineTypeLabel)
        
        informationStack.addArrangedSubview(cousineTypeContainer)
        
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        horizontalStackView.addArrangedSubview(informationStack)
        
        // Rating info
        
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
        favoriteButton.setImage(emptyImage, for: .normal)
        favoriteButtonContainer.addSubview(favoriteButton)
        addSubview(favoriteButtonContainer)
        
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
        
        favoriteButton.addTarget(self, action: #selector(didPressFavoriteButton(_:)), for: .touchUpInside)
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
        print("PRESSED!!")
    }
}
