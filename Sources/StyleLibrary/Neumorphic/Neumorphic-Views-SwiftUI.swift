//
//  File.swift
//  
//
//  Created by Misha L. G. Stone on 2021/01/16.
//

import Foundation
import SwiftUI


//MARK: Backgrounds

public struct DarkBackgroundNeumorphic<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S
    
    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.lightEnd, Color.lightStart))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: 5, y: 5)
                    .shadow(color: Color.darkEnd, radius: 10, x: -5, y: -5)
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    .overlay(shape.stroke(Color.lightStart, lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: -10, y: -10)
                    .shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
            }
        }
    }
}

//MARK: Buttons

public struct IconNeumorphicButton: View {
    //Toggle between the color scheme of the device
    @Environment(\.colorScheme) var colorScheme
    var image: String
    var foregroundColor: Color?
    var action: (() -> Void)?
    
    private var schemedButton: some View {
        if colorScheme == .light {
            return AnyView(LightIconButton(image, foregroundColor, action: action))
        } else {
            return AnyView(DarkIconButton(image, foregroundColor, action: action))
        }
    }
    
    init(_ image: String, foregroundColor: Color? = Color.gray, action: (() -> Void)? = nil) {
        self.image = image
        self.foregroundColor = foregroundColor ?? Color.gray
        self.action = action
    }
    
    var body: some View {
        schemedButton
    }
}

// Icon Button Dependencies
public struct LightIconButton: View {
    var image: String
    var foregroundColor: Color
    var action: (() -> Void)?
    
    init(_ image: String, _ foregroundColor: Color? = nil, action: (() -> Void)? = nil) {
        self.image = image
        self.foregroundColor = foregroundColor ?? Color.gray
        self.action = action
    }
    
    var body: some View {
        Button (action: {
            guard let getAction = action else {
                return
            }
            
            getAction()
        }) {
            
            if #available(OSX 11.0, *) {
                Image(systemName: image)
                    .foregroundColor(foregroundColor)
            } else {
                // Fallback on earlier versions
                Image(image)
                    .foregroundColor(foregroundColor)
            }
        }
        .buttonStyle(LightNeumorphicStyle())
    }
}

public struct DarkIconButton: View {
    var image: String
    var foregroundColor: Color
    var action: (() -> Void)?
    
    init(_ image: String, _ foregroundColor: Color? = nil, action: (() -> Void)? = nil) {
        self.image = image
        self.foregroundColor = foregroundColor ?? Color.gray
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            guard let getAction = action else {
                return
            }
            
            getAction()
        }) {
            if #available(OSX 11.0, *) {
                Image(systemName: image)
                    .foregroundColor(foregroundColor)
            } else {
                // Fallback on earlier versions
                Image(image)
                    .foregroundColor(foregroundColor)
            }
        }
        .buttonStyle(DarkNeumorphicStyle())
    }
}
