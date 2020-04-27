//
//  ViewController.swift
//  UnsplashAPIDemo
//
//  Created by Apple on 4/25/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

// Note: Khi define Picture thi bat buoc phai lam sao no la duy nhat

class ViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!

    private enum Section: String, CaseIterable {
        case sport
        case music
        case technology
    }

    private let reuseIdentifier = "ImageCollectionViewCell"
    private let headerReuseIdentifier = "HeaderView"
    private var sports: [Picture] = []
    private var musics: [Picture] = []
    private var technologies: [Picture] = []
    private var dataSource: UICollectionViewDiffableDataSource<Section, Picture>?

    override func viewDidLoad() {
        super.viewDidLoad()
        initialCollectionViewDataSource()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = createCollectionViewLayout()
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        setupData()
    }

    private func setupData() {
        let group = DispatchGroup()
        // Get sport photos
        group.enter()
        UnsplashService.Photos.shared.getPhotos(query: "sport", page: 1) { [weak self] sportPictures, error in
            guard let self = self, error == nil, let sportPictures = sportPictures else {
                group.leave()
                return
            }
            self.sports = sportPictures
            group.leave()
        }
        // Get music photos
        group.enter()
        UnsplashService.Photos.shared.getPhotos(query: "sport", page: 2) { [weak self] musicPictures, error in
            guard let self = self, error == nil, let musicPictures = musicPictures else {
                group.leave()
                return
            }
            self.musics = musicPictures
            group.leave()
        }
        // Get technology photos
        group.enter()
        UnsplashService.Photos.shared.getPhotos(query: "sport", page: 3) { [weak self] technologyPhotos, error in
            guard let self = self, error == nil, let technologyPhotos = technologyPhotos else {
                group.leave()
                return
            }
            self.technologies = technologyPhotos
            group.leave()
        }
        // Update UI when call api finished
        group.notify(queue: .main) {
            var snapshot = NSDiffableDataSourceSnapshot<Section, Picture>()
            if !self.sports.isEmpty {
                snapshot.appendSections([.sport])
                snapshot.appendItems(self.sports, toSection: .sport)
            }
            if !self.musics.isEmpty {
                snapshot.appendSections([.music])
                snapshot.appendItems(self.musics, toSection: .music)
            }
            if !self.technologies.isEmpty {
                snapshot.appendSections([.technology])
                snapshot.appendItems(self.technologies, toSection: .technology)
            }
            self.dataSource?.apply(snapshot, animatingDifferences: false)
        }
    }

    private func initialCollectionViewDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Picture>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, _) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as? ImageCollectionViewCell
            return cell
        })

        dataSource?.supplementaryViewProvider = { (collectionView, _, indexPath) -> UICollectionReusableView? in
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerReuseIdentifier, for: indexPath) as? HeaderView
            if Section.allCases.indices.contains(indexPath.section) {
                let section = Section.allCases[indexPath.section]
                headerView?.lblTitle.text = section.rawValue.uppercaseFirstCharater()
            }
            return headerView
        }
    }

    private func createCollectionViewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            guard Section.allCases.indices.contains(sectionIndex) else { return nil }
            let section = Section.allCases[sectionIndex]
            switch section {
            case .sport:
                return self.createLayoutSportSection()
            case .music:
                return self.createLayoutMusicSection()
            case .technology:
                return self.createLayoutTechnologySection()
            }
        }
    }

    private func createLayoutSportSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }

    private func createLayoutMusicSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }

    private func createLayoutTechnologySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
}
