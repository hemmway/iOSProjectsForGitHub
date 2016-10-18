//
//  WondersTableColorsViewController.swift
//  LoveWonders
//
//  Created by Ivan Kurhanskyi on 10/16/16.
//  Copyright © 2016 Ivan Kurhanskyi. All rights reserved.
//

import UIKit

class WondersTableColorsViewController: UIViewController {
    var hueColor: CGFloat = 1.0
    var saturationColor: CGFloat = 1.0
    
    @IBOutlet weak var rowHueSliderOutlet: UISlider!
    @IBAction func rowHueSliderChanged(sender: AnyObject) {
        hueColor = CGFloat(rowHueSliderOutlet.value)
        row1ColorLabel.backgroundColor = UIColor(hue: hueColor, saturation: saturationColor, brightness: 1.0, alpha: 1.0)
        row2ColorLabel.backgroundColor = UIColor(hue: hueColor, saturation: saturationColor, brightness: 1.0, alpha: 1.0)
        row3ColorLabel.backgroundColor = UIColor(hue: hueColor, saturation: saturationColor, brightness: 1.0, alpha: 1.0)
        row4ColorLabel.backgroundColor = UIColor(hue: hueColor, saturation: saturationColor, brightness: 1.0, alpha: 1.0)
        row5ColorLabel.backgroundColor = UIColor(hue: hueColor, saturation: saturationColor, brightness: 1.0, alpha: 1.0)
        
    }
    
    @IBOutlet weak var row1ColorLabel: UILabel!
    @IBOutlet weak var row2ColorLabel: UILabel!
    @IBOutlet weak var row3ColorLabel: UILabel!
    @IBOutlet weak var row4ColorLabel: UILabel!
    @IBOutlet weak var row5ColorLabel: UILabel!

    @IBAction func rowSaturationSliderChanged(sender: AnyObject) {
        saturationColor = CGFloat(rowSaturationSliderOutlet.value)
        row1ColorLabel.backgroundColor = UIColor(hue: hueColor, saturation: saturationColor, brightness: 1.0, alpha: 1.0)
        row2ColorLabel.backgroundColor = UIColor(hue: hueColor, saturation: saturationColor, brightness: 1.0, alpha: 1.0)
        row3ColorLabel.backgroundColor = UIColor(hue: hueColor, saturation: saturationColor, brightness: 1.0, alpha: 1.0)
        row4ColorLabel.backgroundColor = UIColor(hue: hueColor, saturation: saturationColor, brightness: 1.0, alpha: 1.0)
        row5ColorLabel.backgroundColor = UIColor(hue: hueColor, saturation: saturationColor, brightness: 1.0, alpha: 1.0)
    }
    @IBOutlet weak var rowSaturationSliderOutlet: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
