//
//  ContentView.swift
//  Jokes in SwiftUI
//
//  Created by rgs on 1/6/21.
//

import SwiftUI

struct ContentView: View {
    var jokes = [
        Joke(setup: "Why did the chicken cross the road?", punchline: "To get to the other side!"),
        Joke(setup: "Can February March?", punchline: "No, but April May"),
        Joke(setup: "What do you call cheese that isn't yours?", punchline: "Nacho cheese"),
        Joke(setup: "Did you hear about the guy who invented the knock knock joke?", punchline: "He won the no-bell prize"),
        Joke(setup: "Why are corns the best?", punchline: "Because they're corn-y!")
    ]
    
    @State private var showPunchline = false
    @State private var currentJoke = 0
    @State private var isFeedbackPresented = false
    @State private var isFeedbackResponsePresented = false
    @State private var feedbackButtonPressed = 1
    
    // Animations
    @State private var punchlineSize: CGFloat = 0.1 // Size
    @State private var punchlineRotation: Angle = .zero // Rotation
    @State private var opacity = 0.0 // Opacity
    @State private var tapToContinueOffset: CGFloat = 200 // Offset
    
    
    var body: some View {
        ZStack {
            Color.pink
            VStack {
                Text(jokes[currentJoke].setup)
                    .padding()
                
                Button("What?") {
                    withAnimation {
                        showPunchline = true
                    }
                }
                .padding() // Fill the button with blue colour
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .padding() // Padding away from other elements
                
                if showPunchline{
                    Text(jokes[currentJoke].punchline)
                        .padding()
                        .scaleEffect(punchlineSize)
                        .rotationEffect(punchlineRotation)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 2)) {
                                punchlineSize = 1
                                punchlineRotation = Angle(degrees: 720)
                                opacity = 1
                                tapToContinueOffset = 0
                            }
                            
                        }
                        .onDisappear {
                            punchlineSize = 0.1
                            punchlineRotation = Angle(degrees: 0)
                            opacity = 0
                            tapToContinueOffset = 200
                        }
                    
                    Text("Tap to continue")
                        .italic()
                        .offset(x: 0, y: tapToContinueOffset)
                        .padding()
                    Spacer()
                } else {
                    Spacer()
                }
            }
        }
        .alert(isPresented: $isFeedbackPresented, content: {
            Alert(title: Text("Did you like the joke?"), primaryButton: Alert.Button.default(Text("😍")) {
                isFeedbackResponsePresented = true
                feedbackButtonPressed = 1
            }, secondaryButton: Alert.Button.default(Text("😑"))
            {
                isFeedbackResponsePresented = true
                feedbackButtonPressed = 2
            })
        })
        
        .onTapGesture {
            
            if showPunchline {
                isFeedbackPresented = true
                if currentJoke == jokes.count {
                    currentJoke = 0
                    
                }
                
                showPunchline = false
                currentJoke += 1
            }
        }
        
        .sheet(isPresented: $isFeedbackResponsePresented) {
            if feedbackButtonPressed == 1 {
                FeedbackResponseView(isPositive: true)
            }
            else if feedbackButtonPressed == 2 {
                FeedbackResponseView(isPositive: false)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
