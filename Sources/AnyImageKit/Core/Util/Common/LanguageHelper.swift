//
//  LanguageHelper.swift
//  AnyImageKit
//
//  Created by .77 on 2023/1/3.
//  Copyright © 2023 AnyImageKit.org. All rights reserved.
//

import Foundation
import UIKit

open class LanguageHelper {
    public static var shared = LanguageHelper()
    
    public var language: AnyLanguage?
    public var customEnabled: Bool = false
    
    public func setLanguage(_ fileName: String?){
        var result: AnyLanguage = .english;
        guard var name: String = fileName else {
            language = result
            return
        }
        if !name.hasSuffix(".lproj"){
            name += ".lproj"
        }
        switch name {
        case "zh-Hans.lproj":
            result = .chinese
            break
        case "en.lproj":
            result = .english
            break
        case "fr.lproj":
            result = .french
            break
        case "es.lproj":
            result = .spanish
            break
        case "ru.lproj":
            result = .russian
            break
        case "hi-IN.lproj":
            result = .hindi
            break
        case "ur-IN":
            result = .urdu
            break
        case "ja.lproj":
            result = .japanese
            break
        case "ko.lproj":
            result = .korean
            break
        case "th.lproj":
            result = .thai
            break
        case "de.lproj":
            result = .german
            break
        case "it.lproj":
            result = .italian
            break
        case "bn-BD.lproj":
            result = .bangladesh
            break
        case "ro.lproj":
            result = .romanian
            break
        case "vi.lproj":
            result = .vietnam
            break
        case "fa.lproj":
            result = .persian
            break
        case "ar.lproj":
            result = .arabic
            break
        case "nl.lproj":
            result = .dutch
            break
        case "my.lproj":
            result = .burmese
            break
        case "id.lproj":
            result = .indonesian
            break
        case "ms.lproj":
            result = .malay
            break
        case "pt-BR.lproj":
            result = .portuguese
            break
        case "tr.lproj":
            result = .turkish
            break
        case "pl.lproj":
            result = .polish
            break
        case "el.lproj":
            result = .greek
            break
        case "ne.lproj":
            result = .nepali
            break
        case "sv.lproj":
            result = .swedish
            break
        case "cs.lproj":
            result = .czech
            break
        case "hu.lproj":
            result = .hungarian
            break
        case "uz.lproj":
            result = .uzbek
            break
        default:
            break
        }
        language = result;
    }
    
}

@objc public enum AnyLanguage : NSInteger, Equatable, CaseIterable{
    /// 中文
    case chinese
    /// 英文
    case english
    /// 法语
    case french
    /// 西班牙语
    case spanish
    /// 俄语
    case russian
    /// 印地语
    case hindi
    /// 乌尔都语
    case urdu
    /// 日语
    case japanese
    /// 韩语
    case korean
    /// 泰语
    case thai
    /// 德语
    case german
    /// 意大利语
    case italian
    /// 罗马利亚语
    case romanian
    /// 孟加拉语
    case bangladesh
    /// 越南语
    case vietnam
    /// 波斯语
    case persian
    /// 阿拉伯语
    case arabic
    /// 荷兰语
    case dutch
    /// 缅甸语
    case burmese
    /// 印尼语
    case indonesian
    /// 马来语
    case malay
    /// 葡萄牙语
    case portuguese
    /// 土耳其语
    case turkish
    /// 波兰语
    case polish
    /// 希腊语
    case greek
    /// 尼泊尔语
    case nepali
    /// 瑞典语
    case swedish
    /// 捷克语
    case czech
    /// 匈牙利语
    case hungarian
    /// 乌兹别克语
    case uzbek
    
    public var title: String {
        switch self {
        case .chinese:
            return "简体中文"
        case .english:
            return "英语"
        case .french:
            return "法语"
        case .spanish:
            return "西班牙语"
        case .russian:
            return "俄语"
        case .hindi:
            return "印地语"
        case .urdu:
            return "乌尔都语"
        case .japanese:
            return "日语"
        case .korean:
            return "韩语"
        case .thai:
            return "泰语"
        case .german:
            return "德语"
        case .italian:
            return "意大利语"
        case .bangladesh:
            return "孟加拉语"
        case .romanian:
            return "罗马尼亚语"
        case .vietnam:
            return "越南语"
        case .persian:
            return "波斯语"
        case .arabic:
            return "阿拉伯语"
        case .dutch:
            return "荷兰语"
        case .burmese:
            return "缅甸语"
        case .indonesian:
            return "印尼语"
        case .malay:
            return "马来语"
        case .portuguese:
            return "葡萄牙语"
        case .turkish:
            return "土耳其语"
        case .polish:
            return "波兰语"
        case .greek:
            return "希腊语"
        case .nepali:
            return "尼泊尔语"
        case .swedish:
            return "瑞典语"
        case .czech:
            return "捷克语"
        case .hungarian:
            return "匈牙利语"
        case .uzbek:
            return "乌兹别克语"
        }
    }
    
    
    var fileName: String? {
        switch self {
        case .chinese:
            return "zh-Hans.lproj"
        case .english:
            return "en.lproj"
        case .french:
            return "fr.lproj"
        case .spanish:
            return "es.lproj"
        case .russian:
            return "ru.lproj"
        case .hindi:
            return "hi-IN.lproj"
        case .urdu:
            return "ur-IN"
        case .japanese:
            return "ja.lproj"
        case .korean:
            return "ko.lproj"
        case .thai:
            return "th.lproj"
        case .german:
            return "de.lproj"
        case .italian:
            return "it.lproj"
        case .bangladesh:
            return "bn-BD.lproj"
        case .romanian:
            return "ro.lproj"
        case .vietnam:
            return "vi.lproj"
        case .persian:
            return "fa.lproj"
        case .arabic:
            return "ar.lproj"
        case .dutch:
            return "nl.lproj"
        case .burmese:
            return "my.lproj"
        case .indonesian:
            return "id.lproj"
        case .malay:
            return "ms.lproj"
        case .portuguese:
            return "pt-BR.lproj"
        case .turkish:
            return "tr.lproj"
        case .polish:
            return "pl.lproj"
        case .greek:
            return "el.lproj"
        case .nepali:
            return "ne.lproj"
        case .swedish:
            return "sv.lproj"
        case .czech:
            return "cs.lproj"
        case .hungarian:
            return "hu.lproj"
        case .uzbek:
            return "uz.lproj"
        }
    }
    
}
