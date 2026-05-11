//
//  ShimmerTableViewCell.swift
//  Countries
//

import UIKit

final class ShimmerTableViewCell: UITableViewCell {

    static let identifier = String(describing: ShimmerTableViewCell.self)
    static let heightForRowAt: CGFloat = 106

    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 47
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        return view
    }()

    private let flagShimmer: ShimmerView = {
        let v = ShimmerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 35
        return v
    }()

    private let line1Shimmer: ShimmerView = {
        let v = ShimmerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let line2Shimmer: ShimmerView = {
        let v = ShimmerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let line3Shimmer: ShimmerView = {
        let v = ShimmerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private var shimmerViews: [ShimmerView] {
        [flagShimmer, line1Shimmer, line2Shimmer, line3Shimmer]
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        contentView.addSubview(cardView)
        cardView.addSubview(flagShimmer)
        cardView.addSubview(line1Shimmer)
        cardView.addSubview(line2Shimmer)
        cardView.addSubview(line3Shimmer)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            flagShimmer.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            flagShimmer.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            flagShimmer.widthAnchor.constraint(equalToConstant: 100),
            flagShimmer.heightAnchor.constraint(equalToConstant: 70),

            line1Shimmer.topAnchor.constraint(equalTo: flagShimmer.topAnchor, constant: 4),
            line1Shimmer.leadingAnchor.constraint(equalTo: flagShimmer.trailingAnchor, constant: 12),
            line1Shimmer.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -40),
            line1Shimmer.heightAnchor.constraint(equalToConstant: 14),

            line2Shimmer.topAnchor.constraint(equalTo: line1Shimmer.bottomAnchor, constant: 10),
            line2Shimmer.leadingAnchor.constraint(equalTo: line1Shimmer.leadingAnchor),
            line2Shimmer.widthAnchor.constraint(equalTo: line1Shimmer.widthAnchor, multiplier: 0.7),
            line2Shimmer.heightAnchor.constraint(equalToConstant: 14),

            line3Shimmer.topAnchor.constraint(equalTo: line2Shimmer.bottomAnchor, constant: 10),
            line3Shimmer.leadingAnchor.constraint(equalTo: line1Shimmer.leadingAnchor),
            line3Shimmer.widthAnchor.constraint(equalTo: line1Shimmer.widthAnchor, multiplier: 0.5),
            line3Shimmer.heightAnchor.constraint(equalToConstant: 14),
        ])
    }

    func startShimmering() {
        shimmerViews.forEach { $0.startAnimating() }
    }

    func stopShimmering() {
        shimmerViews.forEach { $0.stopAnimating() }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        startShimmering()
    }
}
