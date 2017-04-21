//
//  ContainerViewController.swift
//  GoogleMapDynamic
//
//  Created by mineachem on 4/20/17.
//  Copyright © 2017 Minea Chem. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    

    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    lazy var googleMapViewController: GoogleMapViewController = {
       let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "GoogleMapViewController") as! GoogleMapViewController
        self.addViewControllerAsChildViewController(childViewController: viewController)
        
        return viewController
    }()
    
    lazy var googlePlaceViewController: GooglePlaceViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "GooglePlaceViewController") as! GooglePlaceViewController
        self.addViewControllerAsChildViewController(childViewController: viewController)
        
        return viewController
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        setupSegmentedControl()
    }
    
    // MARK: - segmentControl
    private func setupSegmentedControl(){
        segmentControl.removeAllSegments()
        segmentControl.insertSegment(withTitle: "Google Map", at: 0, animated: false)
        segmentControl.insertSegment(withTitle: "Google Place", at: 1, animated: false)
       segmentControl.addTarget(self, action: #selector(selectDidChange(_:)), for: .valueChanged)
        
        segmentControl.selectedSegmentIndex = 0
        
    }
    
    // MARK: - Actions
    
    func selectDidChange(_ sender: UISegmentedControl){
        updateView()
    }
    
    // MARK: - UpdateView
    private func updateView() {
        if segmentControl.selectedSegmentIndex == 0 {
    
            removeViewControllerAsChildViewController(childViewController: googlePlaceViewController)
            addViewControllerAsChildViewController(childViewController: googleMapViewController)
            
        }else {
            removeViewControllerAsChildViewController(childViewController: googlePlaceViewController)
            addViewControllerAsChildViewController(childViewController: googleMapViewController)
        }
    }
    
    // MARK: - Helper Methods
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChildViewController(childViewController)
        
        view.addSubview(childViewController.view)
        
        childViewController.view.frame = view.bounds
       // childViewController.view.autoresizingMask = [ .flexibleWidth , .flexibleHeight]
        
        
        childViewController.didMove(toParentViewController: self)
        
        
    }
    
    private func removeViewControllerAsChildViewController(childViewController: UIViewController) {
        
        childViewController.willMove(toParentViewController: nil)
        
        childViewController.view.removeFromSuperview()
        
        childViewController.removeFromParentViewController()
    }

}
