//
//  WeatherView.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

//import SwiftUI
import WeatherKit
//import CoreLocation
//
//struct WeatherView: View {
//    @State private var location: CLLocation? = nil
//    @State private var currentlocation: CLLocation? = nil
//    @State private var locationManager = CLLocationManager()
////    @State private var location =()
//    
//    
//    var body: some View {
//        Text("Hello, World!")
//            .onTapGesture {
//                print("잘 들어옴2")
//                if let location = location {
//                    print("잘 들어옴1")
//                    getAppleWeather(location)
//                } else {
//                    //
//                }
//            }
//            .onAppear {
//                location = CLLocation(latitude: 36.0190178, longitude: 129.3434808)
////                location = currentlocation
//            }
//    }
    
    import CoreLocation
    import SwiftUI

    class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
        private let locationManager = CLLocationManager()
        @Published var location: CLLocation?

        override init() {
            super.init()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }

        func requestLocation(completion: @escaping (CLLocation?) -> Void) {
            locationManager.requestWhenInUseAuthorization()
            
            if CLLocationManager.locationServicesEnabled() {
                locationManager.startUpdatingLocation()
            } else {
                completion(nil)
            }
            
            // 비동기 위치 업데이트를 처리하는 클로저 설정
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if let location = self.locationManager.location {
                    completion(location)
                    self.locationManager.stopUpdatingLocation()
                } else {
                    completion(nil)
                }
            }
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                self.location = location
                locationManager.stopUpdatingLocation()
            }
        }

        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("위치 업데이트 실패: \(error.localizedDescription)")
        }
    }

    struct WeatherView: View {
        @StateObject private var locationManager = LocationManager()
        @State private var location: CLLocation?

        var body: some View {
            Text("현재 위치 기반 날씨 정보")
                .onTapGesture {
                    locationManager.requestLocation { location in
                        if let location = location {
                            getAppleWeather(location)
                        } else {
                            // 위치 정보가 없을 때 처리
                            print("위치 정보를 가져올 수 없습니다.")
                        }
                    }
                }
                .onAppear {
                    locationManager.requestLocation { location in
                        self.location = location
                    }
                }
        }

//        private func getAppleWeather(_ location: CLLocation) {
//            // Apple Weather API 호출 코드
//            print("현재 위치: \(location.coordinate.latitude), \(location.coordinate.longitude)")
//        }
        
        func getAppleWeather(_ location: CLLocation) {
            Task {
                do {
                    print("잘 들어옴")
                    let service = WeatherService()
                    let result = try await service.weather(for: location)
                    
                    let uvIndex = result.currentWeather.uvIndex
                    
                    print(uvIndex)
                    
                    print("현재 날씨")
                    print(result.currentWeather.temperature)
                    print(result.currentWeather.humidity)
                    print(result.currentWeather.condition)
                    
                    guard let hourly = result.hourlyForecast.first else { return }
                    print("\n시간별 예보 첫 데이터")
                    print(hourly.date)
                    print(hourly.condition)
                    print(hourly.temperature)
                    
                    guard let daily = result.dailyForecast.first else { return }
                    print("\n주간 예보 첫 데이터")
                    print(daily.date)
                    print(daily.condition)
                    print(daily.highTemperature)
                    
                } catch {
                    print(String(describing: error))
                }
            }
        }
    }

    
//    private func getCurrentLocation() {
//        locationManager.requestWhenInUseAuthorization()
//        
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//            
//            if locationManager.location != nil {
//                _ = CGFloat(location?.coordinate.latitude ?? 36.0190178)
//                _ = CGFloat(location?.coordinate.longitude ?? 129.3434808)
//                
//            }
////            return CLLocation(latitude: CurrentLatitude, longitude: CurrentLongitude)
//        }
//    }
//    
//    
//    func getAppleWeather(_ location: CLLocation) {
//        Task {
//            do {
//                print("잘 들어옴")
//                let service = WeatherService()
//                let result = try await service.weather(for: location)
//                
//                let uvIndex = result.currentWeather.uvIndex
//                
//                print(uvIndex)
//                
//                print("현재 날씨")
//                print(result.currentWeather.temperature)
//                print(result.currentWeather.humidity)
//                print(result.currentWeather.condition)
//                
//                guard let hourly = result.hourlyForecast.first else { return }
//                print("\n시간별 예보 첫 데이터")
//                print(hourly.date)
//                print(hourly.condition)
//                print(hourly.temperature)
//                
//                guard let daily = result.dailyForecast.first else { return }
//                print("\n주간 예보 첫 데이터")
//                print(daily.date)
//                print(daily.condition)
//                print(daily.highTemperature)
//                
//            } catch {
//                print(String(describing: error))
//            }
//        }
//    }
//}

#Preview {
    WeatherView()
}
