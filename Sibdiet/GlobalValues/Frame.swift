//  Created by amin sadeghian on 6/30/19.
//  Copyright © 2019 maminyoo. All rights reserved.

import UIKit

let BOUNDS = UIScreen.main.bounds
let HEIGHT = BOUNDS.height
let WIDTH  = BOUNDS.width


let is5     = HEIGHT == 568
let is6     = HEIGHT == 667
let isPlus  = HEIGHT == 736
let isX     = HEIGHT == 812
let is12    = HEIGHT == 844
let is14    = HEIGHT == 852
let isMax   = HEIGHT == 896
let is12Max = HEIGHT == 926
let is14Max = HEIGHT == 932
let isiPad  = HEIGHT > 1000

let hasSafeArea = isX || isMax || is12Max || is12 || is14 || is14Max

private let btmHeight: CGFloat = hasSafeArea ? 85 : 56
private let topHeight: CGFloat = hasSafeArea ? 105 : 72
private let midHeight: CGFloat = HEIGHT - (topHeight + btmHeight) - 2

let topFrame = CGRect(0, 0, WIDTH, topHeight)
let btmFrame = CGRect(0, HEIGHT-btmHeight, WIDTH, btmHeight)
let midFrame = CGRect(0, topFrame.maxY + 1, WIDTH, midHeight)
