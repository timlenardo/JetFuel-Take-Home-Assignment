// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseWelcome { response in
//     if let welcome = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - Welcome
class Welcome: Codable {
    let campaigns: [Campaign]
    
    init(campaigns: [Campaign]) {
        self.campaigns = campaigns
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseCampaign { response in
//     if let campaign = response.result.value {
//       ...
//     }
//   }

// MARK: - Campaign
class Campaign: Codable {
    let id: Int
    let campaignName: String
    let campaignIconURL: String
    let payPerInstall: String
    let medias: [Media]
    
    enum CodingKeys: String, CodingKey {
        case id
        case campaignName = "campaign_name"
        case campaignIconURL = "campaign_icon_url"
        case payPerInstall = "pay_per_install"
        case medias
    }
    
    init(id: Int, campaignName: String, campaignIconURL: String, payPerInstall: String, medias: [Media]) {
        self.id = id
        self.campaignName = campaignName
        self.campaignIconURL = campaignIconURL
        self.payPerInstall = payPerInstall
        self.medias = medias
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseMedia { response in
//     if let media = response.result.value {
//       ...
//     }
//   }

// MARK: - Media
class Media: Codable {
    let coverPhotoURL: String
    let downloadURL: String
    let trackingLink: String
    let mediaType: MediaType
    
    enum CodingKeys: String, CodingKey {
        case coverPhotoURL = "cover_photo_url"
        case downloadURL = "download_url"
        case trackingLink = "tracking_link"
        case mediaType = "media_type"
    }
    
    init(coverPhotoURL: String, downloadURL: String, trackingLink: String, mediaType: MediaType) {
        self.coverPhotoURL = coverPhotoURL
        self.downloadURL = downloadURL
        self.trackingLink = trackingLink
        self.mediaType = mediaType
    }
}

enum MediaType: String, Codable {
    case video = "video"
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try newJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseWelcome(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Welcome>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
