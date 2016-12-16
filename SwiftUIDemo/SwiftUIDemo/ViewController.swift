//
//  ViewController.swift
//  SwiftUIDemo
//
//  Created by 方圆 on 2016/12/16.
//  Copyright © 2016年 方圆. All rights reserved.
//

import UIKit

let tabelViewCellId = "home";

enum UIDemoType {
    case ActivityIndicator
    case AlertView
    case Button
    case Calendar
    case Camera
    case HUD
    case Image
    case Keyboard
    case Label
    case Map
    case Menu
    case NavigationBar
    case Picker
    case Progress
    case ScrollView
    case Segment
    case Slider
    case StatusBar
    case Switch
    case TabBar
    case Table
    case TextField
    case TextView
    case WebView
}

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: tabelViewCellId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tabelViewCellId, for: indexPath)
        switch indexPath.row {
        case UIDemoType.ActivityIndicator.hashValue:
            cell.textLabel?.text = "ActivityIndicator";
        case UIDemoType.AlertView.hashValue:
            cell.textLabel?.text = "AlertView";
        case UIDemoType.Button.hashValue:
            cell.textLabel?.text = "Button";
        case UIDemoType.Calendar.hashValue:
            cell.textLabel?.text = "Calendar";
        case UIDemoType.Camera.hashValue:
            cell.textLabel?.text = "Camera";
        case UIDemoType.HUD.hashValue:
            cell.textLabel?.text = "HUD";
        case UIDemoType.Image.hashValue:
            cell.textLabel?.text = "Image";
        case UIDemoType.Keyboard.hashValue:
            cell.textLabel?.text = "Keyboard";
        case UIDemoType.Label.hashValue:
            cell.textLabel?.text = "Label";
        case UIDemoType.Map.hashValue:
            cell.textLabel?.text = "Map";
        case UIDemoType.Menu.hashValue:
            cell.textLabel?.text = "Menu";
        case UIDemoType.NavigationBar.hashValue:
            cell.textLabel?.text = "NavigationBar";
        case UIDemoType.Picker.hashValue:
            cell.textLabel?.text = "Picker";
        case UIDemoType.Progress.hashValue:
            cell.textLabel?.text = "Progress";
        case UIDemoType.ScrollView.hashValue:
            cell.textLabel?.text = "ScrollView";
        case UIDemoType.Segment.hashValue:
            cell.textLabel?.text = "Segment";
        case UIDemoType.Slider.hashValue:
            cell.textLabel?.text = "Slider";
        case UIDemoType.StatusBar.hashValue:
            cell.textLabel?.text = "StatusBar";
        case UIDemoType.Switch.hashValue:
            cell.textLabel?.text = "Switch";
        case UIDemoType.TabBar.hashValue:
            cell.textLabel?.text = "TabBar";
        case UIDemoType.Table.hashValue:
            cell.textLabel?.text = "Table";
        case UIDemoType.TextField.hashValue:
            cell.textLabel?.text = "TextField";
        case UIDemoType.TextView.hashValue:
            cell.textLabel?.text = "TextView";
        case UIDemoType.WebView.hashValue:
            cell.textLabel?.text = "WebView";
        default:
            cell.textLabel?.text = nil;
        }
        
        return cell;
    }
    
    override var prefersStatusBarHidden: Bool {
        return true;
    }
}


