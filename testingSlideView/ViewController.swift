//
//  ViewController.swift
//  testingSlideView
//
//  Created by Cage Johnson on 1/25/17.
//  Copyright © 2017 desk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var contains: ContainerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        contains = ContainerView(frame: CGRect(x: self.view.frame.width - 240, y: 0, width: 240, height: 710))
        self.view.addSubview(contains)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

