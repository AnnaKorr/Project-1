//
//  ViewController.swift
//  Проект1_ШатроваАнна
//
//  Created by apple on 05.07.17.
//  Copyright © 2017 Korona. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class ViewController: UIViewController {

// Проект - мобильный клиент для чтения новостей с Медузы. 
// Используемый API : https://meduza.io/api/v3/search?chrono=news&locale=ru&page=0&per_page=24
/*
     1. Выбрать тему проекта и записаться в таблицу, ссылка в комментариях.
     
     2. Создать проект и подключить библиотеки Alamofire, Realm, SwiftyJSON
     
     ***3. Загрузить из интернета и сохранить БД ̆ JSON набор данных для вашего проекта.
*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var articlesTitle : String = ""
        let latestNewsURL = "https://meduza.io/api/v3/search?chrono=news&page=0&per_page=10&locale=ru"

        let myRealm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL ?? (Any).self)
        
        
        Alamofire.request(latestNewsURL, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let newsJSON = JSON(value)
                print("JSON: \(newsJSON["collection"][0].stringValue)")
                
                let meduzaNews = MeduzaData()
                meduzaNews.article_name = newsJSON["collection"][0].stringValue
                try! myRealm.write {
                    myRealm.add(meduzaNews)
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        print(articlesTitle)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

