//
//  NewsData+CoreDataProperties.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 2/18/23.
//
//

import Foundation
import CoreData


extension NewsData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsData> {
        return NSFetchRequest<NewsData>(entityName: "NewsData")
    }
    @NSManaged public var descriptions: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var link: String?
    @NSManaged public var source: String?
    @NSManaged public var title: String?

}
