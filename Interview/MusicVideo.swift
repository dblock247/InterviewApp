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
    private var _vRights: String
    private var _vPrice: String
    private var _vImageUrl: String
    private var _vArtist: String
    private var _vVideoUrl: String
    private var _vImid: String
    private var _vGenre: String
    private var _vLinkToiTunes: String
    private var _vReleaseDate: String
    
    var vImageData: NSData?
    
    var vName: String {
        return _vName
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vRights: String {
        return _vRights
    }
    
    var vPrice: String {
        return _vPrice
    }
    
    var vArtist: String {
        return _vArtist
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    var vImid: String {
        return _vImid
    }
    
    var vGenre: String {
        return _vGenre
    }
    
    var vLinkToiTunes: String {
        return _vLinkToiTunes
    }
    
    var vReleaseDate: String {
        return _vReleaseDate
    }
    
    init(data: JSONDictionary) {
        if let name = data["im:name"] as? JSONDictionary,
            vName = name["label"] as? String {
            self._vName = vName
        } else {
            _vName = ""
        }
        
        if let rights = data["rights"] as? JSONDictionary,
            vRights = rights["label"] as? String {
            self._vRights = vRights
        } else {
            _vRights = ""
        }
        
        if let price = data["im:price"] as? JSONDictionary,
            vPrice = price["label"] as? String {
            self._vPrice = vPrice
        } else {
            _vPrice = ""
        }
        
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            immage = image["label"] as? String {
                _vImageUrl =
                    immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            _vImageUrl = ""
        }
        
        if let artist = data["im:artist"] as? JSONDictionary,
            vArtist = artist["label"] as? String {
            self._vArtist = vArtist
        } else {
            _vArtist = ""
        }
        
        if let video = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String {
            self._vVideoUrl = vVideoUrl
        } else  {
            _vVideoUrl = ""
        }
        
        if let imid = data["id"] as? JSONDictionary,
            vid = imid["attributes"] as? JSONDictionary,
            vImid = vid["im:id"] as? String {
            self._vImid = vImid
        } else {
            _vImid = ""
        }
        
        if let genre = data["category"] as? JSONDictionary,
            rel2 = genre["attributes"] as? JSONDictionary,
            vGenre = rel2["term"] as? String {
            self._vGenre = vGenre
        } else {
            _vGenre = ""
        }
        
        if let release2 = data["id"] as? JSONDictionary,
            vLinkToiTunes = release2["label"] as? String {
            self._vLinkToiTunes = vLinkToiTunes
        } else {
            _vLinkToiTunes = ""
        }
        
        if let release2 = data["im:releaseDate"] as? JSONDictionary,
            rel2 = release2["attributes"] as? JSONDictionary,
            vReleaseDate = rel2["label"] as? String {
            self._vReleaseDate = vReleaseDate
        } else {
            _vReleaseDate = ""
        }
    }
}