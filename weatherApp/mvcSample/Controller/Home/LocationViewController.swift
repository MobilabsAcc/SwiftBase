//
//  LocationViewController.swift
//  mvcSample
//
//  Created by Julia Debecka on 19/03/2020.
//  Copyright © 2020 lpb. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class LocationViewController: UIViewController {
    typealias LocationCellData = (city: String, date: Calendar, temperature: (String, String))
    
    let data = [LocationCellData("Warsaw", Calendar.current, ("20° / ", "20°") ),
            LocationCellData(city: "Poznan", date: Calendar.current, temperature: ("10° / ", "15°")),
            LocationCellData(city: "Italy", date: Calendar.current, temperature: ("23° / ", "14°")),
            LocationCellData(city: "USA", date: Calendar.current, temperature: ("23° / ", "14°")),
            LocationCellData(city: "Argentina", date: Calendar.current, temperature: ("23° / ", "14°"))
    ]
    
    
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(LocationCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return cv
    }()
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(collectionView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        collectionView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
}

extension LocationViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.1 , height: collectionView.frame.width / 2.2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LocationCollectionViewCell
        cell.data = self.data[indexPath.row]
        return cell
    }
    
    
}

