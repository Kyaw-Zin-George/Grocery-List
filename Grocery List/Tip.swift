//
//  Tip.swift
//  Grocery List
//
//  Created by Kyaw Thant Zin(George) on 1/14/25.
//

import Foundation
import TipKit

struct ButtonTip : Tip {
    var title: Text = Text("Essential Foods")
    var message: Text? = Text("Add some everyday items into your list!")
    var image: Image? = Image(systemName: "info.circle")
}
