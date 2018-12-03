//
//  NavigationController.swift
//  2018.05.19_app2
//
//  Created by admin on 2018/5/29.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit
import SystemConfiguration

class NavigationController: UINavigationController, UINavigationControllerDelegate {
    let reach = SCNetworkReachabilityCreateWithName(nil, "localhost")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        delegate = self
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (timer) in
            if let bn = self.topViewController?.navigationItem.rightBarButtonItem {
                self.checkOnline(bn)
                //                bn.isEnabled = false
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        var bn = navigationItem.rightBarButtonItem
        if bn == nil{
            bn = UIBarButtonItem()
            viewController.navigationItem.rightBarButtonItem = bn
        }
        checkOnline(bn!)
    }
    
    
    func checkOnline(_ bn: UIBarButtonItem){
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reach!, &flags)
        DispatchQueue.main.async {
            
            if flags .contains(.reachable) {
                bn.image = UIImage(named: "online")?.withRenderingMode(.alwaysOriginal)

//                let alert = self.storyboard?.instantiateViewController(withIdentifier: "loading")
//                self.present(alert!, animated: true, completion: nil)
            }else{
                bn.image = UIImage(named: "offline")?.withRenderingMode(.alwaysOriginal)
            }
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
