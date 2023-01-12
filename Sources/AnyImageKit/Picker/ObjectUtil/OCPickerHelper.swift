//
//  OCPickerHelper.swift
//  AnyImageKit
//
//  Created by .77 on 2023/1/11.
//  Copyright © 2023 AnyImageKit.org. All rights reserved.
//

import Foundation

@objc enum ThemeStyle:NSInteger {
    case auto
    case light
    case dark
}

@objc enum AlbumOption: NSInteger {
    case smart
    case userCreated
    case shared
}

@objc public protocol OCPickerDelegate {
    func imagePickerDidCancel(_ picker: ImagePickerController)
    func imagePicker(_ picker: ImagePickerController, didFinishPicking result: OCPickerResult)
}

open class OCPickerHelper: NSObject {
    @objc open weak var pickerDelegate: OCPickerDelegate?
    
    private var options = PickerOptionsInfo()
    
    /// Theme
    /// - Default: Auto
    @objc var style: ThemeStyle = .auto {
        didSet {
            switch style {
            case .auto:
                options.theme = PickerTheme(style: .auto)
                break
            case .light:
                options.theme = PickerTheme(style: .light)
                break
            default:
                options.theme = PickerTheme(style: .dark)
                break
            }
        }
    }
    
    /// Select Limit
    /// - Default: 9
    @objc public var selectLimit: Int = 9 {
        didSet {
            options.selectLimit = selectLimit
        }
    }
    
    /// Column Number
    /// - Default: 4
    @objc public var columnNumber: Int = 4 {
        didSet {
            options.columnNumber = columnNumber
        }
    }
    
    /// Auto Calculate Column Number
    /// In iOS column number is `columnNumber`, in iPadOS column number will calculated by device orientation or device size.
    /// - Default: true
    @objc public var autoCalculateColumnNumber: Bool = true {
        didSet {
            options.autoCalculateColumnNumber = autoCalculateColumnNumber
        }
    }
    
    /// - Default: 1200
    @objc public var photoMaxWidth: CGFloat = 1200 {
        didSet {
            options.photoMaxWidth = photoMaxWidth
        }
    }
    
    /// Max Width for export Large Photo(When User pick original image)
    /// - Default: 1800
    @objc public var largePhotoMaxWidth: CGFloat = 1800 {
        didSet {
            options.largePhotoMaxWidth = largePhotoMaxWidth
        }
    }
    
    /// Album Options
    /// - Default: smart album + user create album
    open var albumOptions: PickerAlbumOption = [.smart, .userCreated]
    
    
    
}

extension OCPickerHelper: ImagePickerControllerDelegate {
    public func imagePickerDidCancel(_ picker: ImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePicker(_ picker: ImagePickerController, didFinishPicking result: PickerResult) {
        picker.dismiss(animated: true, completion: nil)
    }
}

