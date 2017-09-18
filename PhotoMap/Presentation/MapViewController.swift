//
//  MapViewController.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/19.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var reloadPhotosBarButtonItem: UIBarButtonItem!
    
    fileprivate var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: .none, action: .none)
        locationManager.delegate = self
        mapView.userTrackingMode = .follow
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

// MARK: - Subscriber

extension MapViewController: Subscriber {
    
    func newState(_ state: PhotoMapState) {
        if !state.mapState.hasAskedForAuthorization {
            locationManager.requestWhenInUseAuthorization()
        }
        
        navigationItem.prompt = state.googleState.errorMessage
        reloadPhotosBarButtonItem.isEnabled = !state.googleState.isLoadingData
        mapView.showsUserLocation = state.mapState.canShowUsersLocation
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(getAnnotations(fromPlaces: state.googleState.places))
    }
    
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    func mapViewWillStartLocatingUser(_ mapView: MKMapView) {
        photoMapStore.dispatch(
            .googleService(
                .getPlacesAroundCurrentLocation
            )
        )
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") as? MKPinAnnotationView ?? {
            let annotationView = MKPinAnnotationView(annotation: .none, reuseIdentifier: "annotationView")
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            return annotationView
        }()
        
        view.annotation = annotation
        view.isEnabled = true
        view.canShowCallout = true
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? PlaceAnnotation else {
                return
        }
        
        photoMapStore.dispatch(
            .photosView(
                .selectedPlace(annotation.place)
            )
        )
        
        let photosCollectionViewController = PhotosCollectionViewController()
        navigationController?.pushViewController(photosCollectionViewController, animated: true)
    }
    
}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        photoMapStore.dispatch(
            .mapView(
                .requestedAuthorization(status)
            )
        )
    }
    
}

// MARK: - Events

extension MapViewController {
    
    @IBAction func reloadPhotosOnMapButtonTapped(_ sender: UIBarButtonItem) {
        photoMapStore.dispatch(
            .googleService(
                .reloadPlacesAroundCurrentLocation
            )
        )
    }
    
}

// MARK: - Private

extension MapViewController {
    
    fileprivate func getAnnotations(fromPlaces places: [Place]) -> [MKAnnotation] {
        return places.map { PlaceAnnotation(place: $0) }
    }
    
}
