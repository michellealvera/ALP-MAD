//
//  TimerView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 26/05/23.
//

import SwiftUI

// The TimerView contains the active timer and the playlist at the bottom, if we have time.
struct TimerView: View {
    
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
        
        GeometryReader{proxy in
            
            let width = proxy.size.width
            
            ZStack{
                
                Circle ()
                    .stroke(.black.opacity (0.06), lineWidth: 40)
                
                Circle()
                    .trim(from: 0, to: 0.5)
                    .stroke(Color("Blue"), style:
                    StrokeStyle(lineWidth: 40, lineCap:
                            .round, lineJoin: .round))
                    .rotationEffect(.init(degrees: -90))
                
                // Slider Buttons
                Image(systemName: "moon.fill")
                    .font (.callout)
                    .foregroundColor (Color ("Blue"))
                    .frame (width: 30, height: 30).background(.white,in: Circle())
                // Moving To Right & Rotating
                    .offset(x: width / 2)
                    .rotationEffect(.init(degrees: -90))
                
                
                Image (systemName: "alarm")
                    .font (.callout)
                    .foregroundColor (Color ("Blue"))
                    .frame (width: 30, height: 30) .background (.white,in: Circle())
                // Moving To Right & Rotating
                    .offset(x: width / 2)
                    .rotationEffect(.init(degrees: -90))
                // To the Current Angle
                    .rotationEffect(.init(degrees: 0.0))
                
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
