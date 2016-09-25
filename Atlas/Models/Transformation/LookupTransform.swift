//
//  LookupTransform.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/24/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import ObjectMapper
import RealmSwift

/// Transforms a list of ids into a list of actual records from the Realm. Non-existent records will
/// be created and persisted.
class LookupTransform<T: RealmSwift.Object where T: Mappable, T: Identifiable> : TransformType {

    let mapper = Mapper<T>()

    func transformFromJSON(value: AnyObject?) -> List<T>? {
        let result = List<T>()

        if let array = value as? Array<String>? {
            let realm = try! Realm()
            for id in array! {
                if let object = realm.objectForPrimaryKey(T.self, key: id) {
                    result.append(object)
                } else {
                    let shouldCreateWriteTransaction = !realm.inWriteTransaction
                    if shouldCreateWriteTransaction {
                        realm.beginWrite()
                    }

                    let object = realm.create(T.self, value: ["id": id], update: true)

                    if shouldCreateWriteTransaction {
                        try! realm.commitWrite()
                    }

                    result.append(object)
                }
            }
        }

        return result
    }

    func transformToJSON(value: List<T>?) -> Array<AnyObject>? {
        var results = [AnyObject]()

        if let value = value {
            for object in value {
                let json = mapper.toJSON(object)
                results.append(json)
            }
        }

        return results
    }
}
