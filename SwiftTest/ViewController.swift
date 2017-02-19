//
//  ViewController.swift
//  SwiftTest
//
//  Created by Guibin on 15/7/4.
//  Copyright (c) 2015年 Person. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var _tableView: UITableView!
    
    
    let data = ["Use this tag ",
        "only for questions ",
        "that are specific to Swift language features, or those that require code in the language. Use the related tags [ios], [osx]",
        "[cocoa-touch], and [cocoa] for (language-agnostic) questions about the platforms or frameworks. Swift is Apple's application programming ..."]
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _tableView.registerNib(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "testCell")
        
        testFunc()
    }

    ///////////////////// UITableViewDataSource 实现
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = _tableView.dequeueReusableCellWithIdentifier("testCell", forIndexPath: indexPath) as! TestTableViewCell
        
        cell._headImg.image = UIImage(named: "IMG_1697.JPG")
        cell._labName.text = String(indexPath.row)
//        _headImg.image = UIImage(named: "IMG_1697.JPG")
        
        cell._labDetail.text = data[indexPath.row]
        
        return cell
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        
    }

    func toRaw() -> Int{
        return 33
    }
    
    //测试的一些方法
    func testFunc() {
        
        
        
        func minMac(array:[Int]) -> (min:Int , max :Int)?{
            if array.isEmpty{
                return nil
            }
        
            var currentMin = array[0]
            var currenMax = array[0]
            //从数组中第二个元素开始循环: 1.. < array.count
            for value in array[1..<array.count]{
                if value < currentMin{
                    currentMin = value
                }else if value > currenMax{
                    currenMax = value
                }
            }
            
            return (currentMin, currenMax)
        }
        
        
        let bounds = minMac([8 , 0 , 10 , 32 , -6 , 128, 79])
        
       
        print("items is \(bounds!.min)")
        print("items is \(bounds!.max)")
        
        struct BlackjackCard{
            enum Suit: Character{
                case Spedes = "😁",Hearts = "😘",Diamonds = "🐓" , Clubs = "🐠"
            }
            
            enum Rank : Int{
                case Two = 2, Three, Four, Five, Six, Seven , Eight, Nine , Ten
                case Jack , Queen , King , Ace
                
                struct Values {
                    let first: Int , second: Int?
                }
                
                var values: Values{
                    switch self{
                    case .Ace:
                        return Values(first: 1, second: 11)
                    default :
                        return Values (first: self.toRaw(), second: nil)
                    }
                }
                
            }
            
        }
        
        
        
        
        
    }

    
}

/*
//用protocol 声明一个协议
protocol ExampleProtocol{
    var simpleDescription : String {
        get
    }
    mutating func adjust()
    
}


class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple cless."
    var anotherProperty: Int = 69105
    
    func adjust() {
        simpleDescription += "Now 100% adjusted."
    }
    

    
}


struct SimplesStructure: ExampleProtocol {
    var simpleDescription:String = "A Simple structure"
    mutating func adjust() {
        simpleDescription += "(sdjusted)"
    }
}
*/
//extension Int: ExampleProtocol{
//        var simpleDescroption: String{
//            return "The number \(self)";
//        }
//    mutating func adjust() {
//        self += 22
//    }
//}

