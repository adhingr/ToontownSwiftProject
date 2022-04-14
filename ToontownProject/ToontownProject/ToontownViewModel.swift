//
//  ToontownViewModel.swift
//  ToontownProject
//
//  Created by Mines Student on 4/13/22.
//

import Foundation


class ToontownViewModel: ObservableObject {
    
    @Published var sillymeter = SillyMeter()
    @Published var invasionsStuff = Invasions()
    @Published var populationStuff = Population()
    @Published var fieldOfficeStuff = FieldOffice()
    
    func getSillyMeterData() -> Data? {
        let session = URLSession.shared
        var dataReceived: Data?
        //var dataString: String = ""
        let sem = DispatchSemaphore.init(value: 0)

        let url = URL(string: "https://www.toontownrewritten.com/api/sillymeter")
            let task = session.dataTask(with: url!) { data, response, error in
                defer { sem.signal() }
                guard let data = data else { return }
                if let error = error {
                    print("Error -> \(error)")
                    return
                }

                //let jsonString = String(data: data, encoding: .utf8)
                dataReceived = data
                //dataString = jsonString!
            }

          task.resume()

          // This line will wait until the semaphore has been signaled
          // which will be once the data task has completed
          sem.wait()
          if let sillyMeterData = try? JSONSerialization.jsonObject(with: dataReceived!, options: .allowFragments) as? [String: Any] {
                if let rewards = sillyMeterData["rewards"] as? [String] {
                    //print(rewards)
                    sillymeter.rewards = rewards
                    //print(type(of: rewards))
                }
                if let rewardDescriptions = sillyMeterData["rewardDescriptions"] as? [String] {
                    //print(rewardDescriptions)
                    sillymeter.rewardDescriptions = rewardDescriptions
                }
                if let winner = sillyMeterData["winner"] as? String {
                    print(winner)
                    sillymeter.winner = true
                    sillymeter.winnerString = winner
                } else {
                    print("NULL")
                    sillymeter.winner = false
                    sillymeter.winnerString = "No Winner"
                }
                if let state = sillyMeterData["state"] as? String {
                    print(state)
                    sillymeter.state = state
                }
                if let hp = sillyMeterData["hp"] as? Int {
                    //print(hp)
                    sillymeter.hp = hp
                }
            }
          return dataReceived
    }
    
    
    func getInvasionData() -> Data? {
        let session = URLSession.shared
        var dataReceived: Data?
        //var dataString: String = ""
        let sem = DispatchSemaphore.init(value: 0)

        let url = URL(string: "https://www.toontownrewritten.com/api/invasions")
            let task = session.dataTask(with: url!) { data, response, error in
                defer { sem.signal() }
                guard let data = data else { return }
                if let error = error {
                    print("Error -> \(error)")
                    return
                }

                //let jsonString = String(data: data, encoding: .utf8)
                dataReceived = data
                //dataString = jsonString!
            }

          task.resume()

          // This line will wait until the semaphore has been signaled
          // which will be once the data task has completed
          sem.wait()
        if let invasionData = try? JSONSerialization.jsonObject(with: dataReceived!, options: .allowFragments) as? [String: Any] {
            if let invasions = invasionData["invasions"] as? [String: [String: Any]] {
                let keys = invasions.keys
                var keyArray = [String]()
                for key in keys {
                    keyArray.append(String(key))
                }
                invasionsStuff.invasionDistricts = keyArray
                for invasionName in keyArray{
                    //print(invasions[invasionName]!["type"]!)
                    invasionsStuff.invasionDict[invasionName] = (invasions[invasionName]!["type"]! as? String)
                }
                //print(invasions)
            }
        }

          return dataReceived
    }
    
    func getPopulationData() -> Data? {
        //var populationhaha = Population()
        let session = URLSession.shared
        var dataReceived: Data?
        //var dataString: String = ""
        let sem = DispatchSemaphore.init(value: 0)

        let url = URL(string: "https://www.toontownrewritten.com/api/population")
            let task = session.dataTask(with: url!) { data, response, error in
                defer { sem.signal() }
                guard let data = data else { return }
                if let error = error {
                    print("Error -> \(error)")
                    return
                }

                //let jsonString = String(data: data, encoding: .utf8)
                dataReceived = data
                //dataString = jsonString!
            }

          task.resume()

          // This line will wait until the semaphore has been signaled
          // which will be once the data task has completed
          sem.wait()
          if let populationData = try? JSONSerialization.jsonObject(with: dataReceived!, options: .allowFragments) as? [String: Any] {
            if let populations = populationData["totalPopulation"] as? Int {
                print("population: \(populations)")
                //populationhaha.population = populations
                //populationStuff = populationhaha
                print(populationStuff.population)
                populationStuff.population = populations
                print(populationStuff.population)
            }
        }
          return dataReceived
    }
    
    func getFieldOfficeData() -> Data? {
        let session = URLSession.shared
        var dataReceived: Data?
        //var dataString: String = ""
        let sem = DispatchSemaphore.init(value: 0)

        let url = URL(string: "https://www.toontownrewritten.com/api/fieldoffices")
            let task = session.dataTask(with: url!) { data, response, error in
                defer { sem.signal() }
                guard let data = data else { return }
                if let error = error {
                    print("Error -> \(error)")
                    return
                }

                //let jsonString = String(data: data, encoding: .utf8)
                dataReceived = data
                //dataString = jsonString!
            }

          task.resume()

          // This line will wait until the semaphore has been signaled
          // which will be once the data task has completed
          sem.wait()
        if let fieldOfficeData = try? JSONSerialization.jsonObject(with: dataReceived!, options: .allowFragments) as? [String: Any] {
            if let fieldOffice = fieldOfficeData["fieldOffices"] as? [Int: [String: Any]] {
                let keys = fieldOffice.keys
                var keyArray = [Int]()
                for key in keys {
                    keyArray.append(Int(key))
                }
                fieldOfficeStuff.zoneID = keyArray
                for zone in keyArray{
                    //print(fieldOffice[zone]!["difficulty"]!)
                    fieldOfficeStuff.FieldOfficeDict[zone] = fieldOffice[zone]!["difficulty"]! as? Int
                }
            }
        }
          return dataReceived
    }
    
    
}
