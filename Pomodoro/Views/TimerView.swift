//
//  TimerView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 26/05/23.
//

import SwiftUI
import Foundation

// The TimerView contains the active timer and the playlist at the bottom, if we have time.
struct TimerView: View {
    
    // General Concept
    // StartAngle and Start Progress is always 0
    
    // The toAngle and toProgress is also fixed if not later removed
    // It will slowly be reduced
    
    // ( CurrentTime / TotalTime ) * 360
    
    
    // MARK: Clock View Properties
    var startAngle: Double = 0
    var startProgress: CGFloat = 0
    // Since our to progress is 0.95
    // 0.95 * 360 = 342
    @State var toAngle: Double = 342
    @State var toProgress: CGFloat = 0.95
    
    
    // MARK: TimerView Properties
    @EnvironmentObject var modelData: ModelData
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
                    + Text("Marcell")
                        .font(.title.bold())
                        .foregroundColor(Color("Violet 500"))
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            SleepTimerSlider()
                .padding(.top, 50)
            
            // Refactor and and all isRunning instance to the ViewModal
            // Includes handling the logic to set running to true and false
            if(isRunning){
                
                HStack{
                    
                    Button("Reset") {
                        isRunning = false
                        // Code to set the time to original
                    }.buttonStyle(VioletOutlinedCapsuleButton())
                    
                    Spacer()
                    
                    Button("Pause") {
                        isRunning = false
                    }.buttonStyle(VioletFilledCapsuleButton())
                    
                    
                }
                .padding(.top, 40)
                .padding(.horizontal)
                
                
            } else {
                
                Button {
                    isRunning = true
                } label: {
                    Text("Start")
                        .font(.headline)
                }
                .buttonStyle(VioletOutlinedCapsuleButton())
                .padding(.top, 40)
                .padding(.horizontal)
                
                
            }
            
        }
//        .onAppear{
//            self.vm.setup(activeTimer: self.modelData.activeUser.getActiveTimer())
//        }
        .padding()
        // Moving To Top Without Spacer
        .frame(maxHeight: .infinity, alignment: .top)
        
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
                let reverseRotation = (startProgress > toProgress) ? -Double((1 - startProgress) * 360) : 0
                
                Circle()
                    .trim(from: startProgress > toProgress ? 0 : startProgress, to: toProgress + (-reverseRotation / 360))
//                5F2EEA
                    .stroke(GradientHelper.violetFuschiaGradient, style:
                    StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.init(degrees: -90))
                    .rotationEffect(.init(degrees: reverseRotation))
                
                
                // MARK: Hour Text
                VStack(spacing: 6){
                    
                    Text("\(vm.activeTimer.name)")
                        .font(.caption.italic())
                    
                    Text("\(vm.theTime)")
                        .font(.largeTitle.bold())
                        .padding()
                    

//                    Text ("\(getTimeDifference().0)hr")
//                        .font(.largeTitle.bold())
//                    Text("\(getTimeDifference().1)min")
//                        .foregroundColor(.gray)
                }
                
            }
            .onReceive(timer) { _ in
                vm.updateCountDown()
                // Every second the Timer updates
                // we will call the updateCountDown function
            }
        }
        .frame(width: screenBounds().width / 1.6, height:
        screenBounds().width / 1.6)
        
    }
    
    func onDrag(value: DragGesture.Value) {
        
        // MARK: Converting Translation into Angle
//        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
        // Removing the Button Radius
        // Button Diameter = 30
        // Radius = 15
//        let radians = atan2(vector.dy - 15, vector.dx - 15)
        
        // 5.96 is full
        // 0.0 is dead center
        
        let radians = 0.0
        // Converting into Angle
        var angle = radians * 180 / .pi
        if angle < 0{angle = 360 + angle}
        // Progress
        let progress = angle / 360
        
        // Update To Values
        self.toAngle = angle
        self.toProgress = progress
        
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
