//
//  ShimmerCollectionViewCell.swift
//  Countries
//

import UIKit

final class ShimmerCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: ShimmerCollectionViewCell.self)

    private let flagShimmer: ShimmerView = {
        let v = ShimmerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 12
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

    private var shimmerViews: [ShimmerView] {
        [flagShimmer, line1Shimmer, line2Shimmer]
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        contentView.clipsToBounds = true

        contentView.addSubview(flagShimmer)
        contentView.addSubview(line1Shimmer)
        contentView.addSubview(line2Shimmer)

        NSLayoutConstraint.activate([
            flagShimmer.topAnchor.constraint(equalTo: contentView.topAnchor),
            flagShimmer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            flagShimmer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            flagShimmer.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.55),

            line1Shimmer.topAnchor.constraint(equalTo: flagShimmer.bottomAnchor, constant: 12),
            line1Shimmer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            line1Shimmer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            line1Shimmer.heightAnchor.constraint(equalToConstant: 14),

            line2Shimmer.topAnchor.constraint(equalTo: line1Shimmer.bottomAnchor, constant: 8),
            line2Shimmer.leadingAnchor.constraint(equalTo: line1Shimmer.leadingAnchor),
            line2Shimmer.widthAnchor.constraint(equalTo: line1Shimmer.widthAnchor, multiplier: 0.6),
            line2Shimmer.heightAnchor.constraint(equalToConstant: 12),
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
