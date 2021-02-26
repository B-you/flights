//
//  FileDownloader.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 27/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//

import Foundation

class FileDownloader {
    
    static func loadFileSync(url: URL, folder: String?, completion: @escaping (String?, Error?) -> Void)
    {
        let doc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        //always append root directory
        var path = doc.appendingPathComponent(FileHelper.mainDir)
        
        //If dir is not nil
        if(folder != nil)
        {
            path = path.appendingPathComponent(folder!)
        }
        
        let destinationUrl = path.appendingPathComponent(url.lastPathComponent)
        
        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else if let dataFromURL = NSData(contentsOf: url)
        {
            if dataFromURL.write(to: destinationUrl, atomically: true)
            {
                print("file saved [\(destinationUrl.path)]")
                completion(destinationUrl.path, nil)
            }
            else
            {
                print("error saving file")
                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                completion(destinationUrl.path, error)
            }
        }
        else
        {
            let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
            completion(destinationUrl.path, error)
        }
    }
    
    static func loadFileAsync(url: URL, folder: String?, completion: @escaping (String?, Error?) -> Void)
    {

        let doc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        //always append root directory
        var path = doc.appendingPathComponent(FileHelper.mainDir)
        
        //If dir is not nil
        if(folder != nil)
        {
            path = path.appendingPathComponent(folder!)
        }
        
        let destinationUrl = path.appendingPathComponent(url.lastPathComponent)
        
        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else
        {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request, completionHandler:
            {
                data, response, error in
                if error == nil
                {
                    if let response = response as? HTTPURLResponse
                    {
                        if response.statusCode == 200
                        {
                            if let data = data
                            {
                                if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                                {
                                    completion(destinationUrl.path, error)
                                }
                                else
                                {
                                    completion(destinationUrl.path, error)
                                }
                            }
                            else
                            {
                                completion(destinationUrl.path, error)
                            }
                        }
                    }
                }
                else
                {
                    completion(destinationUrl.path, error)
                }
            })
            task.resume()
        }
    }
}
