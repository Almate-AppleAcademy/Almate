//
//  AppDelegate.swift
//  Almate
//
//  Created by Qiarra on 30/10/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setFirebaseApp()
        setController()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: UISceneSession Lifecycle

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard let controller = GIDSignIn.sharedInstance().presentingViewController as? LoginViewController else { return }
        if let error = error {
            // ...
                print("opo : \(error)")
                    return
                }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
                  // ...
        print(credential.provider)
//        controller.successLogin(credential)
    }
}

extension AppDelegate: AppDelegateFunc {
    func setController() {
        //MARK: CHECK LOGIN IF TRUE TO MAIN PAGE IF FALSE TO LOGIN PAGE
        window = UIWindow(frame: UIScreen.main.bounds)
        if Auth.auth().currentUser == nil {
            window?.rootViewController = MainTabBarController()
            window?.makeKeyAndVisible()
        } else {
            let loginController = LoginViewController(nibName: "LoginViewController", bundle: nil)
            window?.rootViewController = loginController
            window?.makeKeyAndVisible()
        }
    }
    
    func setFirebaseApp() {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
    }
}

protocol AppDelegateFunc {
    func setController()
    func setFirebaseApp()
}

