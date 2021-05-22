//
//  ContentView.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI

struct ContentView: View, Identifiable {
    let id = UUID()
    let dateFormatter = DateFormatter()
    let date = NSDate() as Date
    @State var currentMonth = ""
    @State private var allOrgs: [String] = ["all"]
    @State var allTapped: [Bool] = [true]
    @State private var allOrgsPics: [String] = ["all"]
    @State var currentOrg = "all"
    @State var missions: [Mission] = []
    @State var newMissions: [Mission] = []
    @State var labelShow = false
    var body: some View {
            NavigationView {
                
                
                ScrollView{
                    
                    VStack {
                        HStack {
                            Text("Launches")
                                .font(.system(size: 60, weight: .bold))
                                .padding(.top, -80)
                            .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        .padding(.bottom, -40)
                        HStack(alignment: .bottom){
                            Spacer()
                            if labelShow {
                                Text("Swipe for more")
                                    .font(.caption)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 12, alignment: .center)
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 12, height: 12, alignment: .center)
                                    .padding(.horizontal, 10)
                            } else {
                                Text(" ")
                                    .font(.caption)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 12, alignment: .center)
                            }
                            
                        }
                        
                        .foregroundColor(.gray)
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            
                            VStack {
                                
                                
                                HStack(alignment: .top, spacing: 18) {
                                    
                                    
                                    ForEach(allOrgs, id: \.self){ a in
                                        
                                        FilterButton(count: allOrgs.firstIndex(of: a)!, allTapped: $allTapped, full:$allOrgs, item: a, isText: a == "all", currentOrg: $currentOrg)
                                        
                                        
                                        //									.foregroundColor(.white)
                                        
                                        Spacer(minLength: 15)
                                        
                                    }
                                    
                                    
                                }.padding(30)
                            }
                            
                            .gesture(
                                DragGesture().onChanged { _ in
                                    withAnimation {
                                        labelShow = false
                                    }
                                    
                                }
                            )
                            .transition(
                                .opacity
                            )
                        }
                    }
                    
                    
                    VStack(alignment:.leading) {
                        Text("This Month")
                            .font(.title)
                            .bold()
                            .padding(.horizontal, 30)
                            .padding(.top, 30)
                            .padding(.bottom, 20)
                            .foregroundColor(.white)
                        
                        ForEach(newMissions.filter{$0.date.lowercased().contains(currentMonth) && ($0.org == currentOrg || currentOrg == "all")}) { mission in
                            MissionRow(mission: mission, full:$allOrgs)
                                .padding(.horizontal, 35)
                                .padding(.vertical, 10)
                        }
                        if newMissions.filter{$0.date.lowercased().contains(currentMonth) && ($0.org == currentOrg || currentOrg == "all")}.isEmpty {
                            HStack {
                                Spacer()
                                Text("No more missions this month")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 18, weight: .heavy, design: .default))
                                    .shadow(color: Color("b-c"), radius: 10)
                                Spacer()
                            }
                        }
                        if !newMissions.filter{!$0.date.lowercased().contains(currentMonth) && !$0.date.lowercased().contains("tbd")  && ($0.org == currentOrg || currentOrg == "all")}.isEmpty {
                            Text("Later")
                                .font(.title)
                                .bold()
                                .padding(.horizontal, 30)
                                .padding(.top, 30)
                                .padding(.bottom, 20)
                                .foregroundColor(.white)
                        }
                        ForEach(newMissions.filter{!$0.date.lowercased().contains(currentMonth) && !$0.date.lowercased().contains("tbd")  && ($0.org == currentOrg || currentOrg == "all")}) { mission in
                            MissionRow(mission: mission, full:$allOrgs)
                                .padding(.horizontal, 35)
                                .padding(.vertical, 10)
                        }
                        if !missions.filter{$0.date.lowercased().contains("tbd")  && ($0.org == currentOrg || currentOrg == "all")}.isEmpty {
                            Text("TBD")
                                .font(.title)
                                .bold()
                                .padding(.horizontal, 30)
                                .padding(.top, 30)
                                .padding(.bottom, 20)
                                .foregroundColor(.white)
                        }
                        ForEach(missions.filter{$0.date.lowercased().contains("tbd")  && ($0.org == currentOrg || currentOrg == "all")}) { mission in
                            MissionRow(mission: mission, full:$allOrgs)
                                .padding(.horizontal, 35)
                                .padding(.vertical, 10)
                        }
                    }
                    
                }
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color("fancy-start"), Color("fancy-end")]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
                )
                
                //				}
            }
//            .navigationBarTitle(Text("Launches"), displayMode: .large)
            
        //		.accentColor(Color.black)
        .onAppear {
            loadLaunchData(to: &missions)
            newMissions = missions
            dateFormatter.setLocalizedDateFormatFromTemplate("MMM")
            currentMonth = dateFormatter.string(from: date).lowercased()
            missions.forEach { m in
                let x = m.rocket.lowercased()
                if !allOrgs.contains(orgNameFromRocket(rocket: x))
                {
                    allOrgs.append(orgNameFromRocket(rocket: x))
                    allOrgsPics.append(orgPicFromRocket(rocket: x))
                    allTapped.append(false)
                }
            }
            
        }
    }
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white]
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
            .preferredColorScheme(.dark)
    }
}
