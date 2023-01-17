//
//  OCPickerHelper.swift
//  AnyImageKit
//
//  Created by .77 on 2023/1/11.
//  Copyright © 2023 AnyImageKit.org. All rights reserved.
//

import Foundation
import UIKit


@objc public protocol OCPickerDelegate {
    func imagePickerDidCancel(_ picker: ImagePickerController)
    func imagePicker(_ picker: ImagePickerController, didFinishPicking result: OCPickerResult)
}


open class OCPickerHelper: NSObject {
    @objc open weak var pickerDelegate: OCPickerDelegate?
    
    @objc open var config: OCPickerOptions = OCPickerOptions()
    
    @objc open func showPicker(controller ctl: UIViewController,fullScreen isFullScreen: Bool = true) {
        let controller = ImagePickerController(options: config.options, delegate: self)
        controller.trackDelegate = self
        if #available(iOS 13.0, *) {
            controller.modalPresentationStyle = isFullScreen ? .fullScreen : .automatic
        }
        ctl.present(controller, animated: true, completion: nil)
    }
    
    @objc open func showAvatarPicker(controller ctl: UIViewController) {
        var options = PickerOptionsInfo()
        options.selectLimit = 1
        options.selectionTapAction = .openEditor
        options.saveEditedAsset = false
        options.editorOptions = [.photo]
        options.editorPhotoOptions.toolOptions = [.crop]
        options.editorPhotoOptions.cropOptions = [.custom(w: 1, h: 1)]
        let controller = ImagePickerController(options: options, delegate: self)
        controller.modalPresentationStyle = .fullScreen
        ctl.present(controller, animated: true, completion: nil)
    }
    
}

extension OCPickerHelper: ImagePickerControllerDelegate {
    public func imagePickerDidCancel(_ picker: ImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        self.pickerDelegate?.imagePickerDidCancel(picker)
    }
    
    public func imagePicker(_ picker: ImagePickerController, didFinishPicking result: PickerResult) {
        picker.dismiss(animated: true, completion: nil)
        let ocResult = OCPickerResult(assets: result.assets, useOriginalImage: result.useOriginalImage)
        self.pickerDelegate?.imagePicker(picker, didFinishPicking: ocResult)
    }
}

extension OCPickerHelper: ImageKitDataTrackDelegate {
    public func dataTrack(page: AnyImagePage, state: AnyImagePageState) {
        
    }
    
    public func dataTrack(event: AnyImageEvent, userInfo: [AnyImageEventUserInfoKey : Any]) {
        
    }
}
