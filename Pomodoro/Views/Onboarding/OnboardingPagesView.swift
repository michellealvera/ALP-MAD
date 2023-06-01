//
//  OnboardingPagesView.swift
//  Pomodoro
//
//  Created by MacBook Pro on 01/06/23.
//

import Foundation
import SwiftUI

/* In the next work iteration we will be creating the more complex UI
 This includes using Geometry Reader to place certain elements.
 Along with importing certain designs into the project
*/

struct OnboardingPagesView: View {
    
    var title: String = "Something New"
    var briefMessage: String = "This is Awesome"
    var imageName: String = "moon.fill"
    var isFinalPage: Bool = false
    
    init(){}
    
    init(theTitle title:String, theMessage briefMessage:String, theImage imageName:String,
         finalPage isFinalPage:Bool){
        self.title = title
        self.briefMessage = briefMessage
        self.imageName = imageName
        self.isFinalPage = isFinalPage
    }
    
    var body: some View {
        
        VStack{
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height:150)
                .padding()
            
            Text("\(title)")
                .font(.title)
            
            Text("\(briefMessage)")
                .font(.callout)
            
            if isFinalPage {
                Text("This is the final Page, their should be a button here")
            }
                
        }
        
    }
}

struct OnboardingPagesView_Previews: PreviewProvider {

    static var previews: some View {
        OnboardingPagesView()
    }
}
