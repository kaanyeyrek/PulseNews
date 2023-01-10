//
//  CoreDataManager.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/9/23.
//

import CoreData
import UIKit

protocol CoreDataManagerInterface {
    func save(model: NewCasts)
    func fetch() -> [NewsData]
    func delete(model: NewCasts)
    func deleteAll()
}

final class CoreDataManager: CoreDataManagerInterface {
//MARK: - Components
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save(model: NewCasts) {
        let saved = NewsData(context: context)
        saved.title = model.title
        saved.descriptions = model.description
        saved.link = model.link
        saved.imageURL = model.image_url
        saved.source = model.source_id
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    func fetch() -> [NewsData] {
        var news = [NewsData]()
        do {
            news = try context.fetch(NewsData.fetchRequest())
            return news
        } catch {
            return []
        }
    }
    func delete(model: NewCasts) {
        let savedNews = fetch()
        var newsDelete: NewsData!
        for savedNew in savedNews {
            if savedNew.title == model.title {
                newsDelete = savedNew
            }
        }
        context.delete(newsDelete)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    func deleteAll() {
        let savedNews = fetch()
        for savedNew in savedNews {
            context.delete(savedNew)
        }
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
