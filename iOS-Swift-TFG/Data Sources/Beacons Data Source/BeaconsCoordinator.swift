//
//  BeaconsCoordinator.swift
//  MyPod
//
//  Created by Jonattan Nieto Sánchez on 5/3/17.
//  Copyright © 2017 Jonattan Nieto Sánchez. All rights reserved.
//


import UIKit
import CoreBluetooth
import CoreLocation

class BeaconsCoordinator: NSObject, CBCentralManagerDelegate, CLLocationManagerDelegate {
	
	let centralManager: CBCentralManager! //CoreBluetoothCentralManager
	var locationManager: CLLocationManager
	var isInicializatedCentralManager:Bool //Var to handle bluetooth status
	var beaconRegions:Array<CLBeaconRegion>
	var beaconsManaged: NSMutableDictionary
	var lastBeaconInRange: NSString
    
    weak var interactor : BeaconRepositoryHandler?
	
	
	//MARK: Life Cycle Methods
	init(beaconRegions:Array<CLBeaconRegion>) {
		
		self.centralManager = CBCentralManager.init()
		self.locationManager = CLLocationManager.init()
		self.beaconRegions = beaconRegions
		self.isInicializatedCentralManager = true
		self.beaconsManaged = NSMutableDictionary.init()
		self.lastBeaconInRange = NSString.init()
  
		super.init()
		self.centralManager.delegate = self
		self.locationManager.delegate = self
		
		self.locationManager.requestAlwaysAuthorization()

	}
	
	convenience init(beaconRegions:Array<CLBeaconRegion>, startMonitoring:Bool) {
		self.init(beaconRegions:beaconRegions)
		if(startMonitoring){
			self.startMonitoringBeaconRegions()
		}

	}
	
	//MARK: Monitoring Methods
	func startMonitoringBeaconRegions() -> Void {
		for beaconRegion:CLBeaconRegion in self.beaconRegions {
			self.locationManager.startMonitoring(for: beaconRegion)
		}
	}
	
	func stopMonitoringBeaconRegions() -> Void {
		for beaconRegion:CLBeaconRegion in self.beaconRegions {
			self.locationManager.stopMonitoring(for: beaconRegion)
		}
	}
	//MARK: Ranging Methods
	func startRangingBeaconRegions() -> Void {
		for beaconRegion:CLBeaconRegion in self.beaconRegions {
			self.locationManager.startRangingBeacons(in: beaconRegion)
		}
	}
	
	func stopRangingBeaconRegions() -> Void {
		for beaconRegion:CLBeaconRegion in self.beaconRegions {
			self.locationManager.stopRangingBeacons(in: beaconRegion)
		}
	}
	
	
	
	//MARK: CLLocationManagerDelegate
	func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
		print("didEnterRegion")
		for beaconRegion:CLBeaconRegion in self.beaconRegions {
			if(beaconRegion.identifier == region.identifier){
				self.locationManager.startRangingBeacons(in: beaconRegion)
			}
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
		print("didExitRegion")
		for beaconRegion:CLBeaconRegion in self.beaconRegions {
			if(beaconRegion.identifier == region.identifier){
				self.locationManager.stopRangingBeacons(in: beaconRegion)
			}
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
		
		print("didRangeBeacons")
		print(beacons.count)
		for beacon:CLBeacon in beacons {
			
			if beacon.accuracy < 0 {
				return
			}
			
			let uuid:NSString = beacon.proximityUUID.uuidString as NSString
			
			let rssi:NSInteger = labs(beacon.rssi)
			
			var winner:NSString = uuid
			winner = winner.appending("-\(beacon.major)-\(beacon.minor)") as NSString
			
			let totalMeanItems:NSInteger = 5
			var rssis:[Int]
			if let rssis_aux = (self.beaconsManaged.object(forKey: winner) as? NSDictionary)?.object(forKey: "rssi") as? [Int] {
				rssis = rssis_aux
			} else {
				let rssis_aux = [Int]()
				rssis = rssis_aux
			}
			
			rssis.insert(rssi, at: 0)
			
			if rssis.count > totalMeanItems {
				rssis.remove(at: totalMeanItems)
			}
	
			self.beaconsManaged.setObject(["rssi": rssis], forKey: winner)
			
			var lowestMedian:CGFloat = CGFloat(NSIntegerMax)

			for object in self.beaconsManaged {
				
				var rssis:[Int]
				if let rssis_aux = (self.beaconsManaged.object(forKey: object.key) as? NSDictionary)?.object(forKey: "rssi") as? [Int] {
					rssis = rssis_aux
				} else {
					let rssis_aux = [Int]()
					rssis = rssis_aux
				}
				let currentMedian:CGFloat = self.calculateMean(array: rssis)
				if currentMedian <= lowestMedian {
					lowestMedian = currentMedian
					winner = object.key as! NSString
				}
				
			}
			print("Winner = \(winner)")
            
            let lastBeaconInRange = winner
            if !self.lastBeaconInRange.isEqual(to: lastBeaconInRange as String) {
                self.lastBeaconInRange = lastBeaconInRange
                self.interactor?.handleBeaconRange(beaconID: self.lastBeaconInRange as String)
            }
        }
    }
	
	func showAlert(title:NSString, message:NSString, preferredStyle:UIAlertControllerStyle) -> Void {
		// create the alert
		let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertControllerStyle.alert)
		
		// add the actions (buttons)
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
		
		// show the alert
		//self.present(alert, animated: true, completion: nil)
	}
	
	
	//MARK: CBCentralManagerDelegate
	func centralManagerDidUpdateState(_ central: CBCentralManager) {
		switch central.state {
		case .poweredOff:
			if(self.isInicializatedCentralManager){
				showAlert(title: "Enable bluetooth on your device", message: "In order to use receive beacons information bluetooth must be enabled", preferredStyle: UIAlertControllerStyle.alert)
			}
			break;
		case .poweredOn:
			self.isInicializatedCentralManager = false
			break;
		default:
			break;
		}
	}
	
	
	func calculateMean(array:[Int]) -> CGFloat {
		var sum:CGFloat = 0
		for object:Int in array {
			sum += CGFloat(object)
		}
		return sum/max(CGFloat(array.count), 1)
	}
	
	
	
}
