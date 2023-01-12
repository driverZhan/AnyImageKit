//
//  OCPickerResult.swift
//  AnyImageKit
//
//  Created by .77 on 2023/1/12.
//  Copyright © 2023 AnyImageKit.org. All rights reserved.
//

import Foundation
import Photos

open class OCPickerResult: NSObject {
    @objc public let assets: [Asset]
    @objc public let useOriginalImage: Bool
    
    init(assets: [Asset], useOriginalImage: Bool) {
        self.assets = assets
        self.useOriginalImage = useOriginalImage
    }
}
