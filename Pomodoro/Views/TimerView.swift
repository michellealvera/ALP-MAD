//
//  TimerView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 26/05/23.
//

import SwiftUI
import Foundation
import RealmSwift

// The TimerView contains the active timer and the playlist at the bottom, if we have time.
struct TimerView: View {
    
    
    // MARK: Clock View Properties
    
    var startProgress: CGFloat = 0
    // Since our to progress is 0.95
    // 0.95 * 360 = 342
    //    @State var toAngle: Double = 342
    //    @State var toProgress: CGFloat = 0.95
    
    
    // MARK: TimerView Properties
    
    @ObservedResults(
        Preference.self,
        where: { $0.key == "username" }
    ) var username
    
    @StateObject private var vm = ViewModel()
    
    private let timer = Timer.publish(every: 1, on: .main, in:
            .common).autoconnect()
    @State var isRunning: Bool = false
    
    var body: some View {
        
        VStack{
            HStack{
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Home")
                        .font(.headline)
                        .foregroundColor(Color("Grayscale Label"))
                    
                    Text("Welcome, ")
                        .font(.title.bold())
                        .foregroundColor(.black)
                    // Replace this with current users name
                    + Text(username.first!.value)
                        .font(.title.bold())
                        .foregroundColor(Color("Violet 500"))
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            
            SleepTimerSlider()
                .padding(.top, 50)
            
            if(vm.isActive){
                
                HStack{
                    
                    Button("Reset") {
                        vm.isActive = false
                        vm.reset()
                        // Code to set the time to original
                    }.buttonStyle(VioletOutlinedCapsuleButton())
                    
                    Spacer()
                    
                    Button("Pause") {
                        vm.isActive = false
                        
                    }.buttonStyle(VioletFilledCapsuleButton())
                    
                    
                }
                .padding(.top, 40)
                .padding(.horizontal)
                
                
            } else {
                
                Button {
                    vm.isActive = true
                    vm.start()
                } label: {
                    Text("Start")
                        .font(.headline)
                }
                .buttonStyle(VioletOutlinedCapsuleButton())
                .padding(.top, 40)
                .padding(.horizontal)
                
                
            }
            
            
            
            Spacer()
            MusicPlayerView()
        }
        // Moving To Top Without Spacer
        .frame(maxHeight: .infinity, alignment: .top)
        .edgesIgnoringSafeArea(.horizontal)
//        .onAppear{
//            self.vm.setup(
//                activeTimer: self.modelData.activeUser.getActiveTimer()
//            )
//        }
        
    }
    
    // MARK: Sleep Timer Circular Slider
    @ViewBuilder
    func SleepTimerSlider()->some View{
        
        GeometryReader{ proxy in
            
            let width = proxy.size.width
            
            ZStack{
                
                // MARK: Inner Clock Design
                ZStack{
                    
                    ForEach (1...60,id: \.self){index in
                        Rectangle ()
                            .fill(index % 5 == 0 ? .black : .gray)
                        // Each hour will have big Line
                        // 60/5 = 12
                        // 12 Hours
                            .frame (
                                width: index % 5 == 0 ? 3 : 2,
                                height: index % 5 == 0 ? 10 : 7)
                        // Setting into entire Circle
                            .offset(y: (width - 60) / 2)
                            .rotationEffect(.init(degrees:
                                                    Double(index) * 6))
                    }
                    
                }
                
                Circle ()
                    .stroke(.black.opacity(0.06), lineWidth: 40)
                
                // Allowing Reverse Swipping
                let reverseRotation = (startProgress > vm.toProgress) ? -Double((1 - startProgress) * 360) : 0
                
                Circle()
                    .trim(from: startProgress > vm.toProgress ? 0 : startProgress, to: vm.toProgress + (-reverseRotation / 360))
                //                5F2EEA
                    .stroke(GradientHelper.violetFuschiaAngularGradient, style:
                                StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.init(degrees: -90))
                    .rotationEffect(.init(degrees: reverseRotation))
                    .animation(.easeInOut(duration: 0.5), value: vm.sessionDuration)
                
                
                // MARK: Hour Text
                VStack(spacing: 10){
                    
                    Text("\(vm.activeTimer.name)")
                        .font(.caption.italic())
                        .padding(.top, -40)
                    
                    
                    Text("\(vm.theTime)")
                        .font(.largeTitle.bold())
                        .padding(.vertical, 2)
                    
                }
                
                
            }
            .onReceive(timer) { _ in
                vm.updateCountDown()
                // Every second the Timer updates
                // we will call the updateCountDown function
                // It should do what the onDrag does
            }
        }
        .frame(width: screenBounds().width / 1.6, height:
                screenBounds().width / 1.6)
        
    }
    
}

struct TimerView_Previews: PreviewProvider {
  
    
    static var previews: some View {
        TimerView()
           
    }
}

// MARK: Extensions
extension View {
    
    // MARK: Screen Bounds Extension
    func screenBounds()->CGRect {
        return UIScreen.main.bounds
    }
    
}
