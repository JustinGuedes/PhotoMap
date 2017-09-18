//
//  PlacesTableViewController.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/22.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit
import MapKit

class PlacesTableViewController: UITableViewController {

    @IBOutlet weak var reloadPlacesBarButtonItem: UIBarButtonItem!
    
    fileprivate var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: .none, action: .none)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "placeCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photoMapStore.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        photoMapStore.unsubscribe(self)
    }

}

extension PlacesTableViewController: Subscriber {
    
    func newState(_ state: PhotoMapState) {
        if !state.mapState.hasAskedForAuthorization {
            locationManager.requestWhenInUseAuthorization()
        }
        
        navigationItem.prompt = state.googleState.errorMessage
        reloadPlacesBarButtonItem.isEnabled = !state.googleState.isLoadingData
        tableView.reloadData()
    }
    
}

// MARK: - UITableViewDatasource

extension PlacesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoMapStore.state.googleState.places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath)
        let place = photoMapStore.state.googleState.places[indexPath.row]
        cell.textLabel?.text = place.name
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension PlacesTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        photoMapStore.dispatch(
            .photosView(
                .selectedPlace(photoMapStore.state.googleState.places[indexPath.row])
            )
        )
        
        let photosCollectionViewController = PhotosCollectionViewController()
        navigationController?.pushViewController(photosCollectionViewController, animated: true)
    }
    
}

// MARK: - Events

extension PlacesTableViewController {
    
    @IBAction func reloadPlacesBarButtonItemTapped(_ sender: UIBarButtonItem) {
        photoMapStore.dispatch(
            .googleService(
                .reloadPlacesAroundCurrentLocation
            )
        )
    }
    
}
