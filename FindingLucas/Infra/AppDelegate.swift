//
//  AppDelegate.swift
//  FindingLucas
//
//  Created by Guilherme Coelho on 19/07/18.
//  Copyright © 2018 DevForFun_Guilherme_Coelho. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  // MARK: - Class Properties
  
  var window: UIWindow?
  private var baseRouter: FLBaseRouter?

  // MARK: - Class Methods
  
  private func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    initAppBaseRouter()

    return true
  }
  
  // MARK: - Instance App Router -
  
  private func initAppBaseRouter() {
    
    if baseRouter == nil {
      window = UIWindow(frame: UIScreen.main.bounds)
      baseRouter = FLBaseRouter(window: self.window!)
    }
    
    baseRouter?.initRouter()
  }
}
