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
    
    
    // MARK: Clock View Properties
    @State var startAngle: Double = 0
    @State var startProgress: CGFloat = 0
    // Since our to progress is 0.95
    // 0.95 * 360 = 342
    @State var toAngle: Double = 342
    @State var toProgress: CGFloat = 0.95
    
    
    // MARK: TimerView Properties
    @EnvironmentObject var modelData: ModelData
    @StateObject private var vm = ViewModal()
    private let timer = TimerTasks.publish(every: 1, on: .main, in:
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
                
                // Slider Buttons
                Image(systemName: "moon.fill")
                    .font(.callout)
                    .foregroundColor(Color("Violet 700"))
                    .frame(width: 30, height: 30)
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: -startAngle))
                    .background(.white,in: Circle())
                // Moving To Right & Rotating
                    .offset(x: width / 2)
//                    .rotationEffect(.init(degrees: -90))
                    .rotationEffect(.init(degrees: startAngle))
                    .gesture(
                        DragGesture()
                            .onChanged ({ value in
                                onDrag(value: value, fromSlider: true)
                            })
                    )
                    .rotationEffect(.init(degrees: -90))
                
                
                Image(systemName: "alarm")
                    .font(.callout)
                    .foregroundColor(Color("Fuschia 700"))
                    .frame(width: 30, height: 30)
                // Rotating Image Inside the circle
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: -toAngle))
                    .background(.white, in: Circle())
                // Moving To Right & Rotating
                    .offset(x: width / 2) 
//                    .rotationEffect(.init(degrees: -90))
                // To the Current Angle
                    .rotationEffect(.init(degrees: toAngle))
                    .gesture(
                        DragGesture()
                            .onChanged ({ value in
                                onDrag(value: value)
                            })
                    )
                    .rotationEffect(.init(degrees: -90))
                
                // MARK: Hour Text
                VStack(spacing: 6){
                    Text("Timer Name")
                        .font(.callout)
                    Text ("\(getTimeDifference().0)hr")
                        .font(.largeTitle.bold())
                    Text("\(getTimeDifference().1)min")
                        .foregroundColor(.gray)
                }
                
            }
        }
        .frame(width: screenBounds().width / 1.6, height:
        screenBounds().width / 1.6)
        
    }
    
    func onDrag(value: DragGesture.Value, fromSlider: Bool = false) {
        
        // MARK: Converting Translation into Angle
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
        // Removing the Button Radius
        // Button Diameter = 30
        // Radius = 15
        let radians = atan2(vector.dy - 15, vector.dx - 15)
        // Converting into Angle
        var angle = radians * 180 / .pi
        if angle < 0{angle = 360 + angle}
        // Progress
        let progress = angle / 360
        
        if fromSlider{
            // Update From Values
            self.startAngle = angle
            self.startProgress = progress
        }
        else {
            // Update To Values
            self.toAngle = angle
            self.toProgress = progress
        }
        
    }
    
    func getTime(angle: Double)->Date{
        
        // 360 / 12 = 30
        // 12 = Hours
        let progress = angle / 30
        // It will be 6.05
        // 6 is Hour
        // 0.5 is Minutes
        let hour = Int(progress)
        // Why 12
        // Since we're going to update time for each 5 minutes not for each minute
        // 6.1 = 5 minute
        let remainder = (progress.truncatingRemainder(dividingBy: 1)
                         * 12).rounded()
        
        var minute = remainder * 5
        // This is because minutes are returning 60 (12*5)
        // avoiding that to get perfect time
        minute = (minute > 55 ? 55 : minute)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let calendar = Calendar.current
        let components = calendar.dateComponents([.month,.day,.year], from: Date())
          
        let rawDay = (components.day ?? 0)
        var day: Int = 0

        if angle == toAngle{
            day = rawDay + 1
        }
        else{
            day = (startAngle > toAngle) ? rawDay : rawDay + 1
        }
        if let date = formatter.date(from: "\(components.year ?? 0)-\(components.month ?? 0)-\(day) \(hour == 24 ? 0 : hour):\(Int(minute)):00"){
            return date 
        }
        return .init()
    }
    
    func getTimeDifference()->(Int, Int){
        
        let calendar = Calendar.current
        
        let result = calendar.dateComponents([.hour,.minute], from: getTime(angle: startAngle), to: getTime(angle: toAngle))
        
        return (result.hour ?? 0, result.minute ?? 0)
        
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
