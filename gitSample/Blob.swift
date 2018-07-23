//
//  Blob.swift
//  gitSample
//
//  Created by ST20591 on 2018/07/22.
//  Copyright © 2018年 ha1f. All rights reserved.
//

import Foundation

class GitObject {
    func hashValue() -> String {
        fatalError("This have to be implemented")
    }
}

/// Base class for blob and tree
class GitItem: GitObject {
    
}

class Blob: GitItem {
    
}

class Tree: GitItem {
    /// blob or tree with its name
    var items: [String: GitItem] = [:]
    
    func addItem(_ item: GitItem, with path: String, update: Bool = true) {
        var pathParams = path.split(separator: "/").map { String($0) }
        let lastParam = pathParams.removeLast()
        guard let targetTree = getItemWithPathParams(pathParams) as? Tree else {
            // invalid path
            return
        }
        if !update, let _ = targetTree.items[lastParam] {
            // already exists
            return
        }
        targetTree.items[lastParam] = item
    }
    
    func getItemWithPath(_ path: String) -> GitItem? {
        return getItemWithPathParams(path.split(separator: "/").map { String($0) })
    }
    
    func getItemWithPathParams<C: Collection>(_ pathParams: C) -> GitItem? where C.Element == String {
        guard let name = pathParams.first else {
            // last element
            return self
        }
        guard let tree = items[name] as? Tree else {
            // invalid path
            return nil
        }
        return tree.getItemWithPathParams(pathParams.dropFirst())
    }
}

class GitUser {
    var name: String = ""
    var email: String = ""
}

class Commit: GitObject {
    var author: GitUser = GitUser()
    var committer: GitUser = GitUser()
    var message: String = ""
    var rootTree: Tree = Tree()
    /// Shold be 1. multile when it's "merge" commit
    var parents: [Commit] = []
}

class GitFileManager {
    func setHead(branchName: String) {
        // save to .git/HEAD, "ref: refs/heads/master"
    }
    
    func getTags() {
        // return filelist from .git/refs/tags
    }
    func setTagHead(for tagName: String, head: String) {
        // save to .git/refs/tags
    }
    
    func getBranches() {
        // return filelist from .git/refs/heads
    }
    func setBranchHead(for branchName: String, head: String) {
        // save to .git/refs/heads/branchName
    }
    
    func save(_ object: GitObject) {
        // save to .git/objects/\(hashValue)
    }
    func object(with name: String) {
        // read from .git/objects/name
    }
}

class Git {
    var head: Commit?
    
    let stage: Commit = Commit()
    
    func branch() {
        
    }
    
    func add() {
        // stage
    }
    
    func commit() {
        
    }
}
