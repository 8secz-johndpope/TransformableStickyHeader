//
//  StickyViewController.swift
//  TransformableStickyHeader
//
//  Created by Jayant Arora on 1/10/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import SnapKit
import UIKit

fileprivate enum Section {
    case main
}

final class StickyHeader: UICollectionReusableView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .green
    }

}

final class StickyCell: UICollectionViewCell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(label)
        label.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

final class StickyViewController: UIViewController {

    private let mainScrollView = UIScrollView(frame: .zero)

    var headerCoverView: UIView!
    var profileHeaderView: UIView!
    private let stickyHeaderContainerView = UIView()
    var blurEffectView: UIVisualEffectView!
    var shouldUpdateScrollViewContentFrame = false

    var scrollViews: [UIScrollView] = []

//    var currentScrollView: UIScrollView {
//      return scrollViews[currentIndex]
//    }

    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout())

    private let sampleData = ["Lorem ipsum dolor sit amet", "consectetur adipiscing elit.",
                              "Mauris non turpis vel", "tellus laoreet pulvinar.",
                              "Quisque vitae ligula a", "lectus interdum rhoncus.",
                              "Vestibulum fermentum erat in", "nulla auctor, ac tempor sem rutrum."]

    private var dataSource: UICollectionViewDiffableDataSource<Section, String>!

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.addSubview(mainScrollView)
        view.addSubview(collectionView)

        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareViews()
//        setupCollectionView()
        shouldUpdateScrollViewContentFrame = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        updateCollectionView()

//        print(profileHeaderView.sizeThatFits(self.mainScrollView.bounds.size))

    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
//        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionHeadersPinToVisibleBounds = true

        collectionView.register(StickyCell.self, forCellWithReuseIdentifier: "StickyCell")
        collectionView.register(StickyHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "StickyHeader")

        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView,
                                                                         cellProvider: { cv, indexPath, vm in
                                                                            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: "StickyCell", for: indexPath) as? StickyCell
                                                                                else { return nil }

                                                                            cell.label.text = vm
                                                                            return cell
        })
        //        let header: UICollectionViewDiffableDataSource<Section, String>.SupplementaryViewProvider = { cv, type, indexPath in
        //            guard let header = cv.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
        //                                                                   withReuseIdentifier: "StickyHeader",
        //                                                                   for: indexPath) as? StickyHeader
        //            else { return nil }
        //
        //            return header
        //        }
        //
        //        dataSource.supplementaryViewProvider = header
    }

    private func updateCollectionView() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, String>()
        snapShot.appendSections([.main])
        snapShot.appendItems(sampleData, toSection: .main)
        dataSource.apply(snapShot, animatingDifferences: true)
    }

    private func prepareViews() {
        // main scroll view
        mainScrollView.delegate = self
        mainScrollView.showsHorizontalScrollIndicator = false
        mainScrollView.backgroundColor = .systemRed
        mainScrollView.alwaysBounceVertical = true

        mainScrollView.snp.makeConstraints { (make) in
          make.edges.equalToSuperview()
        }

        // sticker header Container view
        self.mainScrollView.addSubview(stickyHeaderContainerView)
        stickyHeaderContainerView.clipsToBounds = true
        stickyHeaderContainerView.backgroundColor = .systemGreen

        stickyHeaderContainerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(125)
        }

        // blur effect on top of coverImageView
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0
        self.blurEffectView = blurEffectView

        stickyHeaderContainerView.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { (make) in
          make.edges.equalTo(stickyHeaderContainerView)
        }

//        // Cover Image View
//        let coverImageView = UIImageView()
//        coverImageView.clipsToBounds = true
//        self.stickyHeaderContainerView.addSubview(coverImageView)
//        coverImageView.snp.makeConstraints { (make) in
//          make.edges.equalToSuperview()
//        }

        // cover
//        coverImageView.backgroundColor = .systemBlue
//        coverImageView.contentMode = .scaleAspectFill
//        coverImageView.clipsToBounds = true
//        self.headerCoverView = coverImageView



        // Detail Title
//        let _navigationDetailLabel = UILabel()
//        _navigationDetailLabel.text = "121 Tweets"
//        _navigationDetailLabel.textColor = UIColor.white
//        _navigationDetailLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
//        stickyHeaderContainer.addSubview(_navigationDetailLabel)
//        _navigationDetailLabel.snp.makeConstraints { (make) in
//          make.centerX.equalTo(stickyHeaderContainer.snp.centerX)
//          make.bottom.equalTo(stickyHeaderContainer.snp.bottom).inset(8)
//        }
//        self.navigationDetailLabel = _navigationDetailLabel

        // Navigation Title
//        let _navigationTitleLabel = UILabel()
//        _navigationTitleLabel.text = "{username}"
//        _navigationTitleLabel.textColor = UIColor.white
//        _navigationTitleLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
//        stickyHeaderContainer.addSubview(_navigationTitleLabel)
//        _navigationTitleLabel.snp.makeConstraints { (make) in
//          make.centerX.equalTo(stickyHeaderContainer.snp.centerX)
//          make.bottom.equalTo(_navigationDetailLabel.snp.top).offset(4)
//        }
//        self.navigationTitleLabel = _navigationTitleLabel

//        self.scrollViews = []
//        for index in 0..<1 {
//          let scrollView = mainScrollView
//          self.scrollViews.append(scrollView)
//          scrollView.isHidden = (index > 0)
//          mainScrollView.addSubview(scrollView)
//        }

    }

//    func computeStickyHeaderContainerViewFrame() -> CGRect {
//      return CGRect(x: 0, y: 0, width: mainScrollView.bounds.width, height: stickyheaderContainerViewHeight)
//    }
//
//    func computeProfileHeaderViewFrame() -> CGRect {
//      return CGRect(x: 0, y: computeStickyHeaderContainerViewFrame().origin.y + stickyheaderContainerViewHeight, width: mainScrollView.bounds.width, height: profileHeaderViewHeight)
//    }
//
//    func computeTableViewFrame(tableView: UIScrollView) -> CGRect {
//      let upperViewFrame = computeSegmentedControlContainerFrame()
//      return CGRect(x: 0, y: upperViewFrame.origin.y + upperViewFrame.height , width: mainScrollView.bounds.width, height: tableView.contentSize.height)
//    }
//
//    func computeMainScrollViewIndicatorInsets() -> UIEdgeInsets {
//      return UIEdgeInsetsMake(self.computeSegmentedControlContainerFrame().lf_originBottom, 0, 0, 0)
//    }
//
//    func computeNavigationFrame() -> CGRect {
//      return headerCoverView.convert(headerCoverView.bounds, to: self.view)
//    }
//
//    func computeSegmentedControlContainerFrame() -> CGRect {
//      let rect = computeProfileHeaderViewFrame()
//      return CGRect(x: 0, y: rect.origin.y + rect.height, width: mainScrollView.bounds.width, height: segmentedControlContainerHeight)
//
//    }
//
//    func updateMainScrollViewFrame() {
//
//      let bottomHeight = max(currentScrollView.bounds.height, 800)
//
//      self.mainScrollView.contentSize = CGSize(
//        width: view.bounds.width,
//        height: stickyheaderContainerViewHeight + profileHeaderViewHeight + segmentedControlContainer.bounds.height + bottomHeight)
//    }

}

extension StickyViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }

}

extension StickyViewController {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y

        if offset < 0 {
//             let headerScaleFactor: CGFloat = -(offset) / header.bounds.height
//             let headerSizevariation = ((header.bounds.height * (1.0 + headerScaleFactor)) - header.bounds.height)/2.0
//             headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
//             headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
//
//             header.layer.transform = headerTransform
        }

        print(offset)
    }

}
