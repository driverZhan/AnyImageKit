//
//  VideoEditorToolView.swift
//  AnyImageKit
//
//  Created by 蒋惠 on 2019/12/19.
//  Copyright © 2019 AnyImageProject.org. All rights reserved.
//

import UIKit

protocol VideoEditorToolViewDelegate: class {
    func videoEditorTool(_ tool: VideoEditorToolView, optionDidChange option: AnyImageEditorVideoEditOption?)
}

final class VideoEditorToolView: UIView {

    public weak var delegate: VideoEditorToolViewDelegate?
    private(set) var currentOption: AnyImageEditorVideoEditOption?
    
    private(set) lazy var doneButton: UIButton = {
        let view = UIButton(type: .custom)
        view.layer.cornerRadius = 2
        view.backgroundColor = options.tintColor
        view.setTitle(BundleHelper.editorLocalizedString(key: "Done"), for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        view.contentEdgeInsets = UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 10)
        return view
    }()
    private var buttons: [UIButton] = []
    private let spacing: CGFloat = 25
    
    private let options: AnyImageEditorVideoOptionsInfo
    
    init(frame: CGRect, options: AnyImageEditorVideoOptionsInfo) {
        self.options = options
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(doneButton)
        doneButton.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.right.equalToSuperview()
        }
        
        
        for (idx, option) in options.editOptions.enumerated() {
            let button = createButton(tag: idx, option: option)
            buttons.append(button)
        }
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.spacing = spacing
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.snp.makeConstraints { (maker) in
            maker.top.left.bottom.equalToSuperview()
        }
        buttons.forEach {
            $0.snp.makeConstraints { (maker) in
                maker.width.height.equalTo(stackView.snp.height)
            }
        }
    }
    
    private func createButton(tag: Int, option: AnyImageEditorVideoEditOption) -> UIButton {
        let button = UIButton(type: .custom)
        let image = BundleHelper.image(named: option.imageName)?.withRenderingMode(.alwaysTemplate)
        button.tag = tag
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .white
        button.addTarget(self, action: #selector(optionButtonTapped(_:)), for: .touchUpInside)
        button.accessibilityLabel = BundleHelper.editorLocalizedString(key: option.description)
        return button
    }
    
    private func selectButton(_ button: UIButton) {
        currentOption = options.editOptions[button.tag]
        for btn in buttons {
            let isSelected = btn == button
            btn.isSelected = isSelected
            btn.imageView?.tintColor = isSelected ? options.tintColor : .white
        }
    }
}

// MARK: - Public
extension VideoEditorToolView {
    
    func selectOption(_ option: AnyImageEditorVideoEditOption) -> Bool {
        guard let idx = options.editOptions.firstIndex(of: option) else { return false }
        selectButton(buttons[idx])
        return true
    }
    
    func unselectButtons() {
        self.currentOption = nil
        for button in buttons {
            button.isSelected = false
            button.imageView?.tintColor = .white
        }
    }
}

// MARK: - Target
extension VideoEditorToolView {
    
    @objc private func optionButtonTapped(_ sender: UIButton) {
        if let current = currentOption, options.editOptions[sender.tag] == current {
            unselectButtons()
        } else {
            selectButton(sender)
        }
        delegate?.videoEditorTool(self, optionDidChange: currentOption)
    }
}