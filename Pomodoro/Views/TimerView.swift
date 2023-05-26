//
//  TimerView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 26/05/23.
//

import SwiftUI

// The TimerView contains the active timer and the playlist at the bottom, if we have time.
struct TimerView: View {
    
    // MARK: Properties
    @State var startAngle: Double = 0
    // Since our to progress is 0.5
    // 0.5 * 360 = 180
    @State var toAngle: Double = 180
    @State var startProgress: CGFloat = 0
    @State var toProgress: CGFloat = 0.5
    
    var body: some View {
        
        VStack{
            HStack{
    
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text ("Today")
                        .font(.title.bold())
                    
                    Text ("Good Morning! Justine")
                        .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
    
                    Button{
                    
                    
                    } label: {
                        Text("Hi")
//                        Image ("Pic" )
//                        .resizable ()
//                        .aspectRatio(contentMode:.fill)
//                        .frame(width: 45, height: 45)
//                        .clipShape(Circle ())
                    }
    
                }
            SleepTimerSlider()
                .padding(.top, 50)
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
                
                
                // MARK: Clock Design
                ZStack{
                    
                    ForEach (1...60,id: \.self){index in
                        Rectangle ()
                            .fill(index % 5 == 0 ? .black : .gray)
                        // Each hour will have big Line
                        // 60/5 = 12
                        // 12 Hours
                            .frame (width: 2, height: index % 5 ==
                        0 ? 15 : 7)
                        // Setting into entire Circle
                            .offset (y: (width - 60) / 2)
                            .rotationEffect(.init(degrees:
                             Double(index) * 6))
                    }
                    
                }
                
                Circle ()
                    .stroke(.black.opacity(0.06), lineWidth: 40)
                
                Circle()
                    .trim(from: startProgress, to: toProgress)
//                5F2EEA
                    .stroke(Color(.blue), style:
                    StrokeStyle(lineWidth: 40, lineCap:
                            .round, lineJoin: .round))
                    .rotationEffect(.init(degrees: -90))
                
                // Slider Buttons
                Image(systemName: "moon.fill")
                    .font(.callout)
                    .foregroundColor(Color(.blue))
                    .frame(width: 30, height: 30)
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: startAngle))
                    .background(.white,in: Circle())
                // Moving To Right & Rotating
                    .offset(x: width / 2)
                    .rotationEffect(.init(degrees: -90))
                    .rotationEffect(.init(degrees: startAngle))
                
                
                Image(systemName: "alarm")
                    .font(.callout)
                    .foregroundColor(Color(.blue))
                    .frame(width: 30, height: 30)
                // Rotating Image Inside the circle
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: toAngle))
                    .background(.white, in: Circle())
                // Moving To Right & Rotating
                    .offset(x: width / 2) 
                    .rotationEffect(.init(degrees: -90))
                // To the Current Angle
                    .rotationEffect(.init(degrees: toAngle))
                
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
    func screenBounds ( )->CGRect {
        return UIScreen.main.bounds
    }
    
}
