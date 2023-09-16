//
//  UIExt.swift
//  DarockKit
//
//  Created by WindowsMEMZ on 2023/6/29.
//

import Foundation
import SwiftUI

public struct CenterAlign: ViewModifier {
    public func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}

public struct NoAutoInput: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
}

//MARK: Neumorphic
@ViewBuilder public func NeuInput(_ placeholder: String, icon: String, text: Binding<String>, password: Bool = false, paddings: [CGFloat] = [5, 20], noAutoInput: Bool = false) -> some View {
    VStack {
        HStack {
            if icon != "" {
                Image(systemName: icon)
                    .foregroundColor(.Neumorphic.secondary)
                    .font(.system(size: 20, weight: .bold))
            }
            if password {
                SecureField(placeholder, text: text)
                    .foregroundColor(.Neumorphic.secondary)
            } else {
                if noAutoInput {
                    TextField(placeholder, text: text)
                        .foregroundColor(.Neumorphic.secondary)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                } else {
                    TextField(placeholder, text: text)
                        .foregroundColor(.Neumorphic.secondary)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.Neumorphic.main)
                .softInnerShadow(RoundedRectangle(cornerRadius: 30), darkShadow: .Neumorphic.darkShadow, lightShadow: .Neumorphic.lightShadow, spread: 0.05, radius: 2)
        )
    }
    .padding(.vertical, paddings[0])
    .padding(.horizontal, paddings[1])
}

@ViewBuilder public func NeuButton(action: @escaping () -> Void, label: LocalizedStringKey, icon: String? = nil, cornerRadius: CGFloat = 18, paddings: [CGFloat] = [5, 20], fontSize: CGFloat = 22, fontWeight: Font.Weight = .bold, width: CGFloat? = nil) -> some View {
    Button(action: {
        action()
    }, label: {
        HStack {
            Spacer()
            Group {
                if icon != nil {
                    Image(systemName: icon!)
                }
                Text(label)
            }
            .font(.system(size: fontSize, weight: fontWeight))
            Spacer()
        }
    })
    .softButtonStyle(RoundedRectangle(cornerRadius: cornerRadius))
    .frame(width: width)
    .padding(.vertical, paddings[0])
    .padding(.horizontal, paddings[1])
}
@ViewBuilder public func NeuButton(action: @escaping () -> Void, label: String, icon: String? = nil, cornerRadius: CGFloat = 18, paddings: [CGFloat] = [5, 20], fontSize: CGFloat = 22, fontWeight: Font.Weight = .bold, width: CGFloat? = nil) -> some View {
    Button(action: {
        action()
    }, label: {
        HStack {
            Spacer()
            Group {
                if icon != nil {
                    Image(systemName: icon!)
                }
                Text(label)
            }
            .font(.system(size: fontSize, weight: fontWeight))
            Spacer()
        }
    })
    .softButtonStyle(RoundedRectangle(cornerRadius: cornerRadius))
    .frame(width: width)
    .padding(.vertical, paddings[0])
    .padding(.horizontal, paddings[1])
}
@ViewBuilder public func NeuButton(action: @escaping () -> Void, label: () -> some View, cornerRadius: CGFloat = 18, paddings: [CGFloat] = [5, 20], fontSize: CGFloat = 22, fontWeight: Font.Weight = .bold, width: CGFloat? = nil) -> some View {
    Button(action: {
        action()
    }, label: {
        label()
    })
    .softButtonStyle(RoundedRectangle(cornerRadius: cornerRadius))
    .frame(width: width)
    .padding(.vertical, paddings[0])
    .padding(.horizontal, paddings[1])
}

@ViewBuilder public func NStack(_ main: () -> some View) -> some View {
    ZStack {
        Color.Neumorphic.main
            .ignoresSafeArea()
        main()
    }
}

@ViewBuilder public func NeuText(_ text: LocalizedStringKey, fontSize: CGFloat = 22) -> some View {
    Text(text)
        .font(.system(size: fontSize, weight: .bold))
        .foregroundColor(.Neumorphic.secondary)
}
@ViewBuilder public func NeuText(_ text: String, fontSize: CGFloat = 22) -> some View {
    Text(text)
        .font(.system(size: fontSize, weight: .bold))
        .foregroundColor(.Neumorphic.secondary)
}

@ViewBuilder public func NeuProgressView(value: Float, total: Float = 1.0, foregroundColor fc: Color = .blue, width: CGFloat? = 200, height: CGFloat? = 15) -> some View {
    ZStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 18)
            .fill(Color.Neumorphic.main)
            .softInnerShadow(RoundedRectangle(cornerRadius: 18), spread: 0.3, radius: 2)
            .frame(width: width, height: height)
        
        RoundedRectangle(cornerRadius: 18)
            .fill(fc)
            .frame(width: width! * CGFloat(value / total), height: height)
    }
}

@ViewBuilder public func NeuToggle(_ titleKey: LocalizedStringKey, isOn: Binding<Bool>, tint: Color = .green) -> some View {
    HStack {
        NeuText(titleKey, fontSize: 20)
        Toggle("", isOn: isOn)
            .softSwitchToggleStyle(tint: tint, labelsHidden: true)
    }
}
@ViewBuilder public func NeuToggle(isOn: Binding<Bool>, label: () -> some View, tint: Color = .green) -> some View {
    HStack {
        label()
        Toggle("", isOn: isOn)
            .softSwitchToggleStyle(tint: tint, labelsHidden: true)
    }
}

@ViewBuilder public func NeuNavigationLink(@ViewBuilder destination: () -> some View, @ViewBuilder label: () -> some View, cornerRadius: CGFloat = 18, paddings: [CGFloat] = [5, 20], width: CGFloat? = nil) -> some View {
    NavigationLink(destination: destination, label: label)
        .softNavigationLinkStyle(RoundedRectangle(cornerRadius: cornerRadius))
        .frame(width: width)
        .padding(.vertical, paddings[0])
        .padding(.horizontal, paddings[1])
}

public extension DarockKit {
    class UIExt {
        public struct PaddingGroup {
            public init(vertical: CGFloat, horizontal: CGFloat) {
                self.vertical = vertical
                self.horizontal = horizontal
            }
            
            let vertical: CGFloat
            let horizontal: CGFloat
        }
    }
}

internal extension View {
    func padding(_ pg: DarockKit.UIExt.PaddingGroup) -> some View {
        return self
            .padding(.vertical, pg.vertical)
            .padding(.horizontal, pg.horizontal)
    }
}
