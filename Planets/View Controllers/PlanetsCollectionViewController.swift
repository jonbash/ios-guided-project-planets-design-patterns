//
//  PlanetsCollectionViewController.swift
//  Planets
//
//  Created by Andrew R Madsen on 8/2/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit



class PlanetsCollectionViewController: UICollectionViewController {
    // MARK: - Properties
    
    let planetController = PlanetController()
    
    // MARK: - Methods
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateViews),
            name: .plutoSwitchWasFlipped,
            object: nil)
		updateViews()
	}
    
    @objc
	func updateViews() {
        collectionView?.reloadData()
	}
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSettings" {
			guard let detailVC = segue.destination as? SettingsViewController else { return }
            
			// Configure the popover on iPhone to not be fullscreen
			detailVC.popoverPresentationController?.delegate = self
            
			// Listen for popover or iOS13 modal is dismissed notifications
			detailVC.presentationController?.delegate = self
        }
        
        if segue.identifier == "ShowPlanetDetail" {
            guard let indexPath = collectionView?.indexPathsForSelectedItems?.first else { return }
			
			guard let detailVC = segue.destination as? PlanetDetailViewController else { return }
            detailVC.planet = planetController.planets[indexPath.row]
        }
    }
	
    @IBAction func unwindToPlanetsCollectionViewController(_ sender: UIStoryboardSegue) {
		// Update the UI if we segue back to this view controller
		updateViews()
	}
}

// MARK: UICollectionViewDataSource
extension PlanetsCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planetController.planets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetCell", for: indexPath) as! PlanetCollectionViewCell
        
        let planet = planetController.planets[indexPath.item]
        cell.imageView.image = planet.image
        cell.textLabel.text = planet.name
        
        return cell
    }
}

extension PlanetsCollectionViewController: UIPopoverPresentationControllerDelegate {
    // We can "force" an iPhone to display an iPad-like popover by changing the model
	// presentation style in code.
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension PlanetsCollectionViewController: UIAdaptivePresentationControllerDelegate {
	func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
		// Every time the user goes to swipe down to dismiss the modal
		// popover, we should update the UI based on the new state
		updateViews()
	}
}
