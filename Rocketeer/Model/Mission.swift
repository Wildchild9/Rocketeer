//
//  Mission.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI
import Foundation
import CoreLocation

var favouriteLaunches: [String] = UserDefaults.standard.stringArray(forKey: "favouriteLaunches") ?? []

struct Mission: Identifiable, Codable, Hashable {
    var id: String {
        return rocket.lowercased() + payload.lowercased()
    }
    var date: String
    var rocket: String
    var payload: String
    var launchTime: String
    var launchSite: String
    var description: String
//	var loaded: Bool = false
	var key: String {
//		return b64Encode(input: "\(rocket):\(payload)")
		return "\(rocket):\(payload)"
	}
	
//	lazy var background: Image = {
//
//		do{
//			let o = rocket == "Delta 4-Heavy" || rocket == "Electron" ? "" : (org + "+")
//			
//			let u = try String(contentsOf: URL(string: "https://allpurpose.netlify.app/.netlify/functions/images?q=" + o +  rocket.replacingOccurrences(of: " ", with: "+") + "+rocket+phone+wallpaper&url")!)
//			return urltoimg(input: u)
//		}
//		catch {
//			return Image(systemName: "rectangle.slash")
//		}
//	}()
	lazy var coordinate: CLLocationCoordinate2D = {
		let address = launchSite.replacingOccurrences(of: " ", with: "+")
		do {
			let c = try String(contentsOf: URL(string: "https://allpurpose.netlify.app/.netlify/functions/coordinates?a="+address)!)
			return  .init(latitude: Double(c.split(separator: ",")[0]) ?? 0, longitude: Double(c.split(separator: ",")[1]) ?? 0)
		} catch {
			return .init(latitude: 0, longitude: 0)
		}
	}()
    var logo: Image {
        let name = rocket.lowercased()
        
        switch name {
        case "ariane|vega".asRegex:
            return Image("arianespace-logo")
            
        case #"rocket \d+.\d+"#.asRegex:
            return Image("astra-logo")
            
        case "cz-|lm-|shenzou|long march".asRegex:
            return Image("cnsa-logo")
            
        case "slv".asRegex:
            return Image("isro-logo")
            
        case "antares|cygnus|pegasus|minotaur|peacekeeper".asRegex:
            return Image("orbital-logo")
            
        case "electron|photon".asRegex:
            return Image("rocketlab-logo")
            
        case "soyuz|angara".asRegex:
            return Image("roscosmos-logo")
            
        case "falcon".asRegex:
            return Image("spacex-logo")
            
        case "delta|atlas|vulcan|centaur".asRegex:
            return Image("ula-logo")
            
        case "launcherone".asRegex:
            return Image("virgin-logo")
            
        default:
            return Image("rocket-icon")
        }
    }
	var org: String {
		let name = rocket.lowercased()
		
		switch name {
			case "ariane|vega".asRegex:
				return "arianespace"
				
			case #"rocket \d+.\d+"#.asRegex:
				return "astra"
				
			case "cz-|lm-|shenzou|long march".asRegex:
				return "cnsa"
				
			case "slv".asRegex:
				return "isro"
				
			case "antares|cygnus|pegasus|minotaur|peacekeeper".asRegex:
				return "orbital"
				
			case "electron|photon".asRegex:
				return "rocketlab"
				
			case "soyuz|angara".asRegex:
				return "soyuz"
				
			case "falcon".asRegex:
				return "spacex"
				
			case "delta|atlas|vulcan|centaur".asRegex:
				return "ula"
				
			case "launcherone".asRegex:
				return "virgin"
				
			default:
				return ""
		}
	}
    var exactTime: String {
        if let time = launchTime.firstMatch(of: #"(\d+:)?\d+ (a.m.|p.m.)"#) {
            return String(time)
        }
        return launchTime
    }
    
    static let placeholder = Mission(
        date: "Nov. 1",
        rocket: "Falcon 9",
        payload: "Starlink 12",
        launchTime: "10 a.m.",
        launchSite: "Cape Canaveral, Florida",
        description: "A SpaceX Falcon 9 rocket will be sending up the company's 14th Starlink satelite into a geostationary orbit around the Earth. This will be the newest addition to SpaceX's growing constellation of Starlink satellites."
    )
}


//func convertBase64StringToImage (imageBase64String:String) -> Image {
//	let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
//	let image = UIImage(data: imageData!)
//	return Image(uiImage: image!)
//}

func urltoimg(input:String) -> Image{
	let urlk = input //"https://th.bing.com/th/id/OIP.mA_RRZy8Kl_1LCJYaxFwigHaLH?w=172&h=258&c=7&o=5&pid=1.7"
	if let url = URL(string: urlk){
		do{
			let data = try Data(contentsOf: url)
			let uii = UIImage(data: data)
			return Image(uiImage: uii!)
		} catch let err{
			print(err.localizedDescription)
		}
	}
	return Image(systemName: "ellipsis")
}

func datatoimg(input:Data) -> Image{

			let uii = UIImage(data: input)
			return Image(uiImage: uii!)

}
//
//
//let blank = "iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAABQ2lDQ1BJQ0MgUHJvZmlsZQAAKJFjYGASSSwoyGFhYGDIzSspCnJ3UoiIjFJgf8LAwSDJwA/EConJxQWOAQE+QCUMMBoVfLvGwAiiL+uCzGpI3G/tG9I/z6b22a5ZdlcaMdWjAK6U1OJkIP0HiNOSC4pKGBgYU4Bs5fKSAhC7A8gWKQI6CsieA2KnQ9gbQOwkCPsIWE1IkDOQfQPIFkjOSASawfgCyNZJQhJPR2JD7QUBHsfk1CIFDyNjMw8s3qMQlKRWlIBo5/yCyqLM9IwSBUdgKKUqeOYl6+koGBkYGTAwgMIcovrzDXBYMopxIMQKGhgYrDwYGJjzEGKx7QwMG+YzMPDXIsQ0zjMwiEoxMBxwKkgsSoQ7gPEbS3GasRGEzb2dgYF12v//n8MZGNg1GRj+Xv////f2////LgOafwuo9xsA+4tf9wUf7hQAAACWZVhJZk1NACoAAAAIAAUBEgADAAAAAQABAAABGgAFAAAAAQAAAEoBGwAFAAAAAQAAAFIBKAADAAAAAQACAACHaQAEAAAAAQAAAFoAAAAAAAAASAAAAAEAAABIAAAAAQADkoYABwAAABIAAACEoAIABAAAAAEAAAAKoAMABAAAAAEAAAAKAAAAAEFTQ0lJAAAAU2NyZWVuc2hvdJu89p8AAAAJcEhZcwAACxMAAAsTAQCanBgAAAI9aVRYdFhNTDpjb20uYWRvYmUueG1wAAAAAAA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJYTVAgQ29yZSA2LjAuMCI+CiAgIDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+CiAgICAgIDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiCiAgICAgICAgICAgIHhtbG5zOmV4aWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vZXhpZi8xLjAvIgogICAgICAgICAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyI+CiAgICAgICAgIDxleGlmOlBpeGVsWURpbWVuc2lvbj4zMTc8L2V4aWY6UGl4ZWxZRGltZW5zaW9uPgogICAgICAgICA8ZXhpZjpVc2VyQ29tbWVudD5TY3JlZW5zaG90PC9leGlmOlVzZXJDb21tZW50PgogICAgICAgICA8ZXhpZjpQaXhlbFhEaW1lbnNpb24+MzE3PC9leGlmOlBpeGVsWERpbWVuc2lvbj4KICAgICAgICAgPHRpZmY6T3JpZW50YXRpb24+MTwvdGlmZjpPcmllbnRhdGlvbj4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+CgbL/uoAAAAbSURBVBgZY/wPBAxEACYi1ICVjCrEG1JEBw8AaZoEENQWWPAAAAAASUVORK5CYII="
//let uu = "/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAIAAVQMBIgACEQEDEQH/xAAbAAABBQEBAAAAAAAAAAAAAAAFAgMEBgcAAf/EADwQAAIBAwIDBQUFBgYDAAAAAAECAwAEERIhBTFBBhNRYXEUIjKBkRUjUqGxQrLB0eHwJHKCosLxJTQ1/8QAGgEAAgMBAQAAAAAAAAAAAAAAAwQBAgUABv/EACURAAICAgIBBAIDAAAAAAAAAAABAhEDBBIhMiIxQXETI4Gxwf/aAAwDAQACEQMRAD8ApAQkZpJj35U+EJ2xTqR+Vejsw0iKsQzvSxCOlSu6pax46VFluJFWIilhAOdSu7qRw+x9svre2BwZpVjB8MkCocq7J4g9I1J5UswirD2+jise0NjY2capBHAY9I9dj5nY/WhQiNUx5VkjaLzxODpkVIB4UsQgHlUpYsGliPflRLK8RlItuVdU1YtuVdUcjuIJMajcLXmcU6c+FeFM11nUeAFqWF9a5AV2xTitg7rUE0JAx0oj2d347w8ZwTcxgH/UKisuQMHan7Ivb3kE8QPeRSK6+GQciqy8WWiu0P8Ab2Aw9r4tUjOHwfe6bmobyIDjBNGu3DSL2pSApG6NGWBdMsCPA0KbXnZd/SldNvh2M7Xc+hj2nHJRSluhndKdEDHmu/pSmtnUAgCm7QtTOW6GPhrqV7LJzDA/Kva60R6hj7NcbswFFI7GNeArlEMhuG+80jVgBNs+G5+tLmnC7FFIHUVIaQfYSSBNP+Ifb5JSeabpfaGsUVb+n/QLFnEfiFKbh8Z5frXNcA9DXqzN+ypotsHSEi0jTAwdql2saNNGiruzgfnTQaQ80ovwWwuJHhvMKsaXCKBndzzOPQVWc6jbJjG2Qu2S6u3SE4PuMBv00j+JPKkNECNhvRji3DRxLtiEi0KQwDEDqQ2T64FCI7hZbu+gjXHstw0WT+0ByP8AfgaX15+mg2WPdiVh8qdS2zy50tSaeTzYCmOTB0htLVgOf5V1SlZQPjrqryZ1IGNbjG9Tyq/Y0QIyO/f9EoIeIEr8O9T3vD9hwEnBaeT8tFUzRdR+0WwyVv6Y4sceM6FpQWEH4QKFe3MOTU2bmQnnmjcGC5oMMIvGiUUXFG4Vw82dxDGov9SgpnVFtqB8GyGGR5VVTPIfKr5whSOznCyebM5yfU0ttRqAxryuQxd21xL2oUJczC2hOZk6SYiJIx/fOqXwS3lt+I8UMszuXkVijHOkkE4+mBWnBQeOT5AAAPTb4DWXyPJ9r8SYE5eYEgelL6yvJQfN1Cw0Fz1FcdI50FZ3B3ZgfI07btczHEMUkpH4VJ/StLgIcyycM4Rc8TR3ttGhDgljjJrqN9jI5rbh8jXMbRiV9SKeeMc8dK6kcmaSk0hqGOLimzKVZvGi17932fsDlye/ffTt7wU8/LAHLrUeOGF5Eihtb92fAV2hVUJJwMe9nxPLkM0RkF/IYrSTg7tDAyrqa8jGBnGrTjJ/oR40XY24dV8MFg1p938gPUaWrHxqbELS5gZzFPazLjVDKuGB3+WNjv8AzFRzpV2XHIkUxg2cebxBZtaeHyG2Z/xVp/CIe77OcIRs5K538Tk/xrNGK48PWtXhi7jhnDIgxOkAZJzketA3n6Ug2pH1Nj0Y/wDMXXiB/wAaya8Gjid7oBGZd61tP/s3IxjKn92sru8LxS+DDbvBt8qV1H+1DOdfrZCGr18q1jstw1eHcBhjlUrK47yQHnk9P0rMCqH4DvWqcPnXiVvbXEUuYnXLJ4Ecx9aa3pPikhbVirbZLmm0MFVFYAdDXUO4npe40jUNPnXtZTmkaCxNmVR9pfZDHKQAsQCjLooCZbOMEnJJQ58sbcqmcN43LezQteNkupClAyqTnoSuD0/PFD+MRW9+ssAZDKkXeKgxk6WIz6cyfWnOAWMSX9tG0qO1tKwCrIG04cgggZ2264oWx0vL3Da6t+PsFbS3WYe1RzLPBICkhG23TA8sDqc6aigWsyySxyI6rksVcHFT4OGNCJFt1/wTLoCquFj6jl0zgn1PjTh7gRiC7ilLOXChFJOc/wDXWmNfYeONxny/wHsYVOVSjxBMUcU4VoxIFY4GpCD+datKoS0sVByBjfx2rNLCO5jmhjlTEkbAMzHYkHyzWnXaaYLQb7MM5o+zkcop2AwYuMmqEqCvG5dxlgMemn+lZpdW6vxW9Gc4cD6bfwrTMD7ccnqmx+VUG7iJ4zejGGOlseRGR+tD1pVkQTLG8b/gHPZr0Iqy9hn7qee3eUnUAyRnl4E/pQn2didxinINdncR3EAGtDnflWjl/ZBxEILhJMv1xLElyyjT8I6etdQ6yEt7BHcSxlGdAcfXeurHkpJmjFxoz689mPezaAJ+5aMaQSSoLAAnpkk89qc4JYSy8YVhGUL3LgO+3u6s4PmN9/KljhFnxIPcQXDIzIsZaJ913Zuh2yTv44HoS/ZXhcsVyjv3QZWYHu8jOSCDv18dqXzzt0M4YUrFWfDvYWNvGr9w4wjZJII368877+dT7Cf2a7lABK5ZW6EEHI2+ZodYPcWgazSaQsg2YkZdxzz6jI+lS2U/ad1kH3ZS2x/Zyf50fH4P2XXwDmvWl2/sYe3IvrpBHkRytJ7u+FPvZ/3VcF9+0hZiTlFbJHpVWnZV4irrhTJGhIHLO6kfkKs3EeI2tpIkLd4XaMYVI2bbffYVE8q/Gm37ErE+fS9x8IBcscbAn90fyqocVgK8eZgD/wCqgqzRcUhku5IkhmOFLM2g4Bxyqum9HFLyWRYJIu6XTlsbgnbkT4H61TFmj+RJMtLFLhK18ER4mpywgD38AfRjWM6ztXsgZSd6Jdn7C3vO9kuSxMbAKM4FarnUWZvDsNyp96eYAAAANe0i4mZZyurACjl8/wCldSQfsz22nRUkjt7fSW0MSJy3MM3UY/F5VYuEWls0NrcQqIpPdLY6sTuTv1wKrVjr9jn1qiTyQLu+xVSrdd8DpnwzVm4Ak4hgNwEEypDrUEFd+uPMnn1rGnJOVGvxahZ3CL6K6nkgdVmuoT7zOQ+l+o3GcgqabTEvHbmNFVNQeMgHIOx3+oFEbG7hSCR+6XLSB2GMEFsZ5Z36/OodriPjV2wGl++2B8NW5+ePzrQ1YVGXXwJ5ZXNUPmCAy2UjL7ugpkY5jr9atVvbW1xFDI8MckiIFDMoJHKq3HC9uX2wsVxlc1bLQAI2ORYkVGv6m0ydvpKj1beFX1iJA/4gozQ/j0SeyqQgBzzAotQ/jQzaj/NTUkkuhPHbmiiXqkE4ruA3cdrxRWuG0qylQSNgemam3iDO4oZCqtfRfctIquGZUXJ0g70zBpxaZORUy1Xb/f5U5yozgV1eRTxl3cKQGAxtiupNosmf/9k"
