//
//  ToontownViewModel.swift
//  ToontownProject
//
//  Created by Mines Student on 4/13/22.
//

import Foundation


class ToontownViewModel: ObservableObject {
    
    
    @Published var sillymeter = SillyMeter()
    @Published var populationStuff = Population()
    @Published var fieldOfficeStuff = FieldOffice()
    @Published var invasionEachStuff = [Invasion]()
    @Published var fieldOfficeEachStuff = [FieldOffice]()
    
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
                    print(rewards)
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
                    //print("NULL")
                    sillymeter.winner = false
                    sillymeter.winnerString = "No Winner"
                }
                if let state = sillyMeterData["state"] as? String {
                    //print(state)
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
                for key in invasions.keys { 
                    let tempInvasion = Invasion()
                    let tempInvasionNameString = String(key)
                    let tempInvasionTypeString = (invasions[key]!["type"]! as? String)
                    let tempInvasionProgressString = (invasions[key]!["progress"]! as? String)
                    tempInvasion.districtName = tempInvasionNameString
                    tempInvasion.districtType = tempInvasionTypeString!
                    tempInvasion.districtProgress = tempInvasionProgressString!
                    
                    let components = tempInvasionProgressString?.components(separatedBy: "/")
                    let currCogs = (Double(components![1])! - Double(components![0])!)
                    var temp = 0.7 * currCogs
                    temp = temp / 100
                    tempInvasion.timeRemaining = Int(temp)
                    
                    invasionEachStuff.append(tempInvasion)
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
            if let fieldOffice = fieldOfficeData["fieldOffices"] as? [String: [String: Any]] {
                print("Helloooo")
                for key in fieldOffice.keys {
                    var tempStreet: String
                    let tempOffice = FieldOffice()
                    let tempOfficeZone = Int(key)
                    var tempOfficeDifficulty = (fieldOffice[key]!["difficulty"]! as? Int)
                    let tempOfficeAnnexes = (fieldOffice[key]!["annexes"]! as? Int)
                    let tempOfficeOpen = (fieldOffice[key]!["open"]! as? Bool)
                    var tempOpenString: String
                    if tempOfficeOpen == true{
                        tempOpenString = "Open"
                    } else {
                        tempOpenString = "Closed"
                    }
                    
                    switch tempOfficeZone{
                    case 3100:
                        tempStreet = "Walrus Way"
                    case 3200:
                        tempStreet = "Sleet Street"
                    case 3300:
                        tempStreet = "Polar Place"
                    case 4100:
                        tempStreet = "Alto Avenue"
                    case 4200:
                        tempStreet = "Baritone Boulevard"
                    case 4300:
                        tempStreet = "Tenor Terrace"
                    case 5100:
                        tempStreet = "Elm Street"
                    case 5200:
                        tempStreet = "Maple Street"
                    case 5300:
                        tempStreet = "Oak Street"
                    case 9100:
                        tempStreet = "Lullaby Lane"
                    case 9200:
                        tempStreet = "Pajama Place"
                    default:
                        tempStreet = "Error getting street"
                    }
                    if tempOfficeDifficulty == 0{
                        tempOfficeDifficulty = 1
                    }
                    else if tempOfficeDifficulty == 1{
                        tempOfficeDifficulty = 2
                    }
                    else if tempOfficeDifficulty == 2{
                        tempOfficeDifficulty = 3
                    }
                    
                    
                    tempOffice.zone = tempOfficeZone!
                    tempOffice.difficulty = tempOfficeDifficulty!
                    tempOffice.street = tempStreet
                    tempOffice.annexes = tempOfficeAnnexes!
                    tempOffice.open = tempOpenString
                    
                    fieldOfficeEachStuff.append(tempOffice)
                }
            }
            
        }
          return dataReceived
    }
    
    
}
