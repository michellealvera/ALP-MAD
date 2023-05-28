//
//  ExperimentalTimerView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 28/05/23.
//

import SwiftUI

struct ExperimentalTimerView: View {
            
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
            
        }
        .padding()
        // Moving To Top Without Spacer
        .frame(maxHeight: .infinity, alignment: .top)
        
    }
    
    // MARK: Sleep Timer Circular Slider
//    @ViewBuilder
//    func SleepTimerSlider()-> some View{
        
//        ZStack{
//
//            // MARK: Inner Clock Design
//            ZStack {
//                LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                    .edgesIgnoringSafeArea(.all)
//
//                ForEach(0..<12) { hour in
//                    HourStrip(hour: hour)
//                }.mask(GradientMask())
//            }
//            .rotationEffect(.degrees(-90)) // Rotate the entire clock to have the hour strips in a circular arrangement
//        }
//        .frame(width: screenBounds().width / 1.6, height:
//                screenBounds().width / 1.
        
//            ZStack {
//                ForEach(0..<12) { hour in
//                    HourTick(hour: hour)
//                }
//                .overlay(
//                    LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                        .blendMode(.overlay)
//                )
//            }
//            .rotationEffect(.degrees(-90)) // Rotate the entire clock to have the hour strips in a circular arrangement
//            .frame(width: screenBounds().width / 1.6, height: screenBounds().width / 1.6)
        
        
        
//    }
    

    
}

struct SleepTimerSlider: View {
    var body: some View {
        ZStack {
            HourTicks()
                .foregroundColor(.black)
            
            GradientOverlay()
                .mask(HourTicks())
        }
        .rotationEffect(.degrees(-90))
        .frame(width: 200, height: 200)
    }
}

struct HourTicks: View {
    var body: some View {
        ForEach(0..<12) { hour in
            HourTick(hour: hour)
        }
    }
}

struct HourTick: View {
    let hour: Int
    
    var body: some View {
        Rectangle()
            .fill(Color.white)
            .frame(width: 4, height: 40)
            .rotationEffect(angle(for: hour))
    }
    
    private func angle(for hour: Int) -> Angle {
        let degrees = Double(hour) * 30.0
        return .degrees(degrees)
    }
}

struct GradientOverlay: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .blendMode(.overlay)
    }
}


//
//struct SleepTimerSlider: View {
//    var body: some View {
//        ZStack {
//            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                .blendMode(.overlay)
//
//            HourTicks()
//                .foregroundColor(.black)
//        }
//        .rotationEffect(.degrees(-90))
//        .frame(width: 200, height: 200)
//    }
//}
//
//struct HourTicks: View {
//    var body: some View {
//        ForEach(0..<12) { hour in
//            HourTick(hour: hour)
//        }
//    }
//}
//
//struct HourTick: View {
//    let hour: Int
//
//    var body: some View {
//        Rectangle()
//            .fill(Color.black)
//            .frame(width: 4, height: 40)
//            .rotationEffect(angle(for: hour))
//    }
//
//    private func angle(for hour: Int) -> Angle {
//        let degrees = Double(hour) * 30.0
//        return .degrees(degrees)
//    }
//}




//struct HourStrip: View {
//    let hour: Int
//
//    var body: some View {
//        Rectangle()
////            .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color.black]), startPoint: .top, endPoint: .bottom))
//            .fill(LinearGradient(gradient: Gradient(colors: [Color("Fuschia 500"), Color("Violet 500")]), startPoint: .top, endPoint: .bottom))
////            .fill(GradientHelper.fuschiaVioletGradient)
//            .frame(width: 4, height: 120) // Hour strip size
//            .rotationEffect(angle(for: hour))
//    }
//
//    private func angle(for hour: Int) -> Angle {
//        let degrees = Double(hour) * 30.0 // Each hour strip is separated by 30 degrees
//        return .degrees(degrees)
//    }
//}

//struct HourStrip: View {
//    let hour: Int
//
//    var body: some View {
//        Rectangle()
//            .fill(Color.white) // Hour strip color
//            .frame(width: 4, height: 120) // Hour strip size
//            .rotationEffect(angle(for: hour))
//            .offset(y: 0) // Adjust the vertical position of the hour strips
//    }
//
//    private func angle(for hour: Int) -> Angle {
//        let degrees = Double(hour) * 30.0 // Each hour strip is separated by 30 degrees
//        return .degrees(degrees)
//    }
//
//}


struct GradientMask: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let radius = rect.width / 0.5
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        path.addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
        path.closeSubpath()
        
        return path
    }
}


struct ExperimentalTimerView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentalTimerView()
//            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom))

    }
}
