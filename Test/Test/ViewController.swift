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
        Alamofire.request(.GET, "http://openapi.aurin.org.au/csw?request=GetRecords&service=CSW&version=2.0.2&typeNames=csw:Record&elementSetName=summary&resultType=results&constraintLanguage=CQL_TEXT&constraint_language_version=1.1.0&maxRecoeds=200").authenticate(user: "student", password: "dj78dfGF").response
            { (request, response, data, error) in
                //print(data) // if you want to check XML data in debug window.
                let xml = SWXMLHash.parse(data!)
                //print(xml)
                
                print(xml["csw:GetRecordsResponse"]["csw:SearchResults"]["csw:SummaryRecord"].all.map { elem in
                        elem["dc:identifier"][0].element!.text!
                    })
            }


        let xmlWithNamespace =
            "<csw:GetRecords" +
            "    service=\"CSW\"" +
            "    version=\"2.0.2\"" +
            "    resultType=\"hints\"" +
            "    outputSchema=\"http://www.opengis.net/cat/csw/2.0.2\"" +
            "    xmlns:ogc=\"http://www.opengis.net/ogc\"" +
            "    xmlns:csw=\"http://www.opengis.net/cat/csw/2.0.2\"" +
            "    xmlns:gml=\"http://www.opengis.net/gml\">" +
            "    <csw:Query typeNames=\"csw:Record\">" +
            "        <csw:ElementSetName>full</csw:ElementSetName>" +
            "        <csw:Constraint version=\"1.1.0\">" +
            "            <ogc:Filter>" +
            "                <ogc:BBOX>" +
            "                    <ogc:PropertyName>ows:BoundingBox</ogc:PropertyName>" +
            "                    <gml:Envelope>" +
            "                        <gml:lowerCorner>-45.0 100.0</gml:lowerCorner>" +
            "                        <gml:upperCorner>-0.0 140.0</gml:upperCorner>" +
            "                    </gml:Envelope>" +
            "                </ogc:BBOX>" +
            "            </ogc:Filter>" +
            "        </csw:Constraint>" +
            "    </csw:Query>" +
            "</csw:GetRecords>"
        
        let URLString = "http://openapi.aurin.org.au/csw?service=CSW&request=GetRecords&typeNames=csw:Record"

        
        
//        let custom: (URLRequestConvertible, [String: AnyObject]?) -> (NSURLRequest, NSError?) = {
//            (URLRequest, parameters) in
//            let mutableURLRequest = URLRequest.URLRequest.mutableCopy() as! NSMutableURLRequest
//            mutableURLRequest.setValue("application/xml", forHTTPHeaderField: "Content-Type")
//            mutableURLRequest.HTTPBody = xmlWithNamespace.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
//            return (mutableURLRequest, nil)
//        }
        
        


//        Alamofire.request(.POST, URLString, parameters: Dictionary(), encoding: .Custom(custom)).responseString { (request, response, data, error) -> Void in
//            println(data)
//        }
        
        
        
        
        
        Alamofire.request(.POST, URLString, parameters: nil, encoding: .Custom({
                (convertible, params) in
                    let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
                    mutableRequest.URL = NSURL(string: URLString)
                    mutableRequest.HTTPBody = xmlWithNamespace.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                    return (mutableRequest, nil)
            })).authenticate(user: "student", password: "dj78dfGF")
            .response{ (request, response, data, error) in
                            let xml = SWXMLHash.parse(data!)
                            print(xml)
                     }
        
        //Custom((URLRequestConvertible, [String: AnyObject]?) -> (NSMutableURLRequest, NSError?))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

