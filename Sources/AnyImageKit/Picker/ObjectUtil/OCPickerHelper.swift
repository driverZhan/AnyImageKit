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

@objc enum SelectedTapAction: NSInteger {
    case browse
    case pick
    case edit
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
    public var albumOptions: PickerAlbumOption = [.smart, .userCreated]
    
    
    /// Select Options
    /// - Default: Photo
    /// - .photoLive and .photoGIF are subtype of .photo and will be treated as a photo when not explicitly indicated, otherwise special handling will be possible (playable & proprietary)
    public var selectOptions: PickerSelectOption = [.photo]
    
    @objc public var videoEnable: Bool = false {
        didSet {
            let hasVideo: Bool = selectOptions.contains(.video)
            if (hasVideo && !videoEnable) {
                selectOptions.remove(.video)
            }else if (!hasVideo && videoEnable){
                selectOptions.insert(.video)
            }
            options.selectOptions = selectOptions
        }
    }
    
    @objc public var livePhotoEnable: Bool = false {
        didSet {
            let hasVideo: Bool = selectOptions.contains(.photoLive)
            if (hasVideo && !livePhotoEnable) {
                selectOptions.remove(.photoLive)
            }else if (!hasVideo && livePhotoEnable){
                selectOptions.insert(.photoLive)
            }
            options.selectOptions = selectOptions
        }
    }
    
    @objc public var gifEnable: Bool = false {
        didSet {
            let hasVideo: Bool = selectOptions.contains(.photoGIF)
            if (hasVideo && !gifEnable) {
                selectOptions.remove(.photoGIF)
            }else if (!hasVideo && gifEnable){
                selectOptions.insert(.photoGIF)
            }
            options.selectOptions = selectOptions
        }
    }
    
    @objc var selectionTapAction: SelectedTapAction = .browse {
        didSet {
            switch selectionTapAction {
            case .browse:
                options.selectionTapAction = .preview
                break
            case .pick:
                options.selectionTapAction = .quickPick
                break
            case .edit:
                options.selectionTapAction = .openEditor
                break
            }
        }
    }
    
    @objc public var preSelected: [String] = [] {
        didSet {
            options.preselectAssets = preSelected
        }
    }
    
    
    
    @objc public var enableDebugLog: Bool = false {
        didSet {
            options.enableDebugLog = enableDebugLog
        }
    }
    
#if ANYIMAGEKIT_ENABLE_EDITOR
    /// Save edited asset when picker dismiss with success
    /// - Default: true
    public var saveEditedAsset: Bool = true {
        didSet {
            options.saveEditedAsset = saveEditedAsset
        }
    }
    
    @objc public var photoEditable: Bool = false {
        didSet {
            let editable = options.editorOptions.contains(.photo)
            if (!editable && photoEditable){
                options.editorOptions.insert(.photo)
            }else if (editable && !photoEditable) {
                options.editorOptions.remove(.photo)
            }
        }
    }
    
    ///TODO
    /*public*/ var videoEditable: Bool = false {
        didSet {
            let editable = options.editorOptions.contains(.video)
            if (!editable && videoEditable){
                options.editorOptions.insert(.video)
            }else if (editable && !videoEditable) {
                options.editorOptions.remove(.video)
            }
        }
    }
    
    /// Editor photo option info items
    public var editorPhotoOptions: EditorPhotoOptionsInfo = .init()
    
    /// Editor video option info items
    /*public*/ var editorVideoOptions: EditorVideoOptionsInfo = .init()
#endif
    
#if ANYIMAGEKIT_ENABLE_CAPTURE
    /// Capture option info items
    public var captureOptions: CaptureOptionsInfo = .init()
#endif
    
#if ANYIMAGEKIT_ENABLE_EDITOR && ANYIMAGEKIT_ENABLE_CAPTURE
    /// Use Same Editor Options In Capture
    /// - Default: true
    @objc public var useSameEditorOptionsInCapture: Bool = true {
        didSet {
            options.useSameEditorOptionsInCapture = useSameEditorOptionsInCapture
        }
    }
#endif
    
    
    
}

extension OCPickerHelper: ImagePickerControllerDelegate {
    public func imagePickerDidCancel(_ picker: ImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePicker(_ picker: ImagePickerController, didFinishPicking result: PickerResult) {
        picker.dismiss(animated: true, completion: nil)
    }
}

