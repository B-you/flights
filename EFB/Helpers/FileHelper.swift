//
//  FileHelper.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 27/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//

import Foundation

class FileHelper
{
    static let filemgr = FileManager.default
    static let mainDir  = "EFBFiles";
    static func createDirectory(directory: String?) -> Bool
    {
        let doc = self.filemgr.urls(for: .documentDirectory, in: .userDomainMask)[0]
        //always append root directory
        var path = doc.appendingPathComponent(self.mainDir)
        
        //If dir is not nil
        if(directory != nil)
        {
            path = path.appendingPathComponent(directory!)
        }
        
        var isDir: ObjCBool = false;
        if(filemgr.fileExists(atPath: path.path, isDirectory: &isDir))
        {
            //If it is not a directory
            if !isDir.boolValue
            {
                return self.doCreateDir(path: path.path)
            }
            else
            {
                return true;
            }
        }
        else
        {
            //Doesn't exist, create it
            return self.doCreateDir(path: path.path)
        }
        
    }
    
    static func emptyMainDirectory()
    {
        let doc = self.filemgr.urls(for: .documentDirectory, in: .userDomainMask)[0]
        //always append root directory
        let path = doc.appendingPathComponent(self.mainDir)
        do
        {
            
            let contents = try self.filemgr.contentsOfDirectory(at: path, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
            
            for url in contents
            {
                try filemgr.removeItem(at: url)
            }
        }
        catch
        {
            
        }
        
    }
    
    static private func doCreateDir(path: String) -> Bool
    {
        do
        {
            try filemgr.createDirectory(atPath: path, withIntermediateDirectories: true, attributes:nil)
            return true;
        }
        catch let error as NSError
        {
            print ("Unable to create directory \(error.debugDescription)")
            return false;
        }
    }
    
    //load Files on Start
    //It attempts to get all the directories and files within a directory
    static func GetDirectories() -> [DirectoryVM]
    {
        var result = [DirectoryVM]()
        
        //Get all directories from the efb folder
        let doc = self.filemgr.urls(for: .documentDirectory, in: .userDomainMask)[0]
        //always append root directory
        let path = doc.appendingPathComponent(self.mainDir)
        do
        {
            let dirs = try filemgr.contentsOfDirectory(atPath: path.path)
            
            //Iterate through thoseguys and get content of the directory
            for d in dirs
            {
                debugPrint(d)
                let dv = DirectoryVM()
                dv.DirectoryName = filemgr.displayName(atPath: d)
                dv.Files = ContentOfDirectory(path: path.appendingPathComponent(d) )
                result.append(dv)
            }
            return result; 
        }
        catch let error as NSError
        {
            print ("Unable to load directory \(error.debugDescription)")
            return result;
        }
        
    }
    
    static func ContentOfDirectory(path: URL) -> [FileVM]
    {
        do
        {
            var res = [FileVM]()
            let paths = try filemgr.contentsOfDirectory(atPath: path.path)
            let df = DateFormatter()
            df.dateFormat = "MMM dd, yyyy h:mm a"
            for p in paths
            {
                let fpath  = path.appendingPathComponent(p)  //full path of the file
                let fl = FileVM()
                fl.FileName = p
                
                //Add file attributes
                let fatts = try filemgr.attributesOfItem(atPath: fpath.path)
                fl.FileSize = String((fatts[FileAttributeKey.size] as! Int)/1024)  + " KB";
                fl.FullPath = fpath.path
                let cdate = fatts[FileAttributeKey.creationDate] as! Date
                fl.LastUpdated = cdate;
                fl.LastUpdatedString = df.string(from: cdate)
                res.append(fl);
            }
            return res;
        }
        catch let error as NSError
        {
            print ("Unable to load directory \(error.debugDescription)")
            return [FileVM]();
        }
    }
}
