//
//  MusicVideo.swift
//  Interview
//
//  Created by Londre Blocker on 4/24/16.
//  Copyright © 2016 Londre Blocker. All rights reserved.
//

import Foundation

class Videos
{
    private var _vName: String
    private var _vImageUrl: String
    private var _vVideoUrl: String
    
    var vName: String {
        return _vName
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    init(data: JSONDictionary) {
        if let name = data["im:name"] as? JSONDictionary, vName = data["label"] as? String {
            self._vName = vName
        } else {
            _vName = ""
        }
        
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            immage = image["label"] as? String {
                _vImageUrl =
                    immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            _vImageUrl = ""
        }
        
        if let video = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String {
            self._vVideoUrl = vVideoUrl
        } else  {
            _vVideoUrl = ""
        }
    }
}