//
//  FLCharSelectionViewController.swift
//  FindingLucas
//
//  Created by Guilherme Coelho on 19/07/18.
//  Copyright (c) 2018 DevForFun_Guilherme_Coelho. All rights reserved.
//

import UIKit

final class FLCharSelectionViewController: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var lblTitl: UILabel!
  @IBOutlet weak var lblCharDesc: UILabel!
  
  @IBOutlet weak var btnStart: FLBlueBorderButton!
  
  // MARK: - Class properties
  
  // MARK: - Public properties
  
  var presenter: FLCharSelectionPresenterInterface!
  
  // MARK: - Life Cycle - 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.viewConfiguration()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Init Deinit -
  
  required convenience init() {
    self.init(nibName: nil, bundle: nil)
  }
  
  deinit {
    
  }
  
  // MARK: - Class Configurations
  
  func viewConfiguration() {
    
  }
  
  // MARK: - Class Methods
  
  
  // MARK: - UIActions
  
  @IBAction func startIsPressed(_ sender: Any) {
    
  }
}

// MARK: - Extensions

extension FLCharSelectionViewController: FLCharSelectionViewInterface {
}
