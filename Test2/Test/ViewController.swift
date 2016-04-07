//
//  ViewController.swift
//  Test
//
//  Created by Hayden on 16/4/6.
//  Copyright © 2016年 University of Melbourne. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // 发送请求的URL
        let URLString = "http://openapi.aurin.org.au/csw?service=CSW&request=GetRecords&typeNames=csw:Record"

        let fileURL = NSBundle.mainBundle().URLForResource("bboxFilter", withExtension: "xml")
        Alamofire.upload(.POST, URLString, headers: ["Content-Type" : "application/xml"], file: fileURL!)
        .authenticate(user: "student", password: "dj78dfGF")
        .response{ (request, response, data, error) in
            let xml = SWXMLHash.parse(data!)
            //self.enumerate(xml)
            print(xml["csw:GetRecordsResponse"])
            print(xml["csw:SearchStatus"])
            print(xml["csw:SearchResults"])
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

