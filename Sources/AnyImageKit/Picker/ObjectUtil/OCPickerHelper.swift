//
//  OCPickerHelper.swift
//  AnyImageKit
//
//  Created by .77 on 2023/1/11.
//  Copyright © 2023 AnyImageKit.org. All rights reserved.
//

import Foundation

public protocol OCPickerDelegate: AnyObject {
    func imagePickerDidCancel(_ picker: ImagePickerController)
    func imagePicker(_ picker: ImagePickerController, didFinishPicking result: PickerResult)
}

open class OCPickerHelper {
    open weak var pickerDelegate: OCPickerDelegate?
}
