//
//  UIExt.swift
//  DarockKit
//
//  Created by WindowsMEMZ on 2023/6/29.
//

import Foundation
import SwiftUI
#if canImport(WatchKit)
import WatchKit
#endif

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

#if !os(visionOS)
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
#endif

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

#if os(watchOS)
public struct VolumeControlView: WKInterfaceObjectRepresentable {
    public init() {
        
    }
    
    public typealias WKInterfaceObjectType = WKInterfaceVolumeControl
    
    public func makeWKInterfaceObject(context: WKInterfaceObjectRepresentableContext<VolumeControlView>) -> WKInterfaceVolumeControl {
        // Return the interface object that the view displays.
        return WKInterfaceVolumeControl(origin: .local)
    }
    
    public func updateWKInterfaceObject(_ map: WKInterfaceVolumeControl, context: WKInterfaceObjectRepresentableContext<VolumeControlView>) {
        
    }
}

public struct Zoomable: ViewModifier {
    @AppStorage("MaxmiumScale") var maxmiumScale = 6.0
    @State var scale: CGFloat = 1.0
    @State var offset = CGSize.zero
    @State var lastOffset = CGSize.zero
    
    public init() {
        
    }
    
    public func body(content: Content) -> some View {
        content
            .scaleEffect(self.scale)
            .focusable()
            .digitalCrownRotation($scale, from: 0.5, through: maxmiumScale, by: 0.02, sensitivity: .low, isHapticFeedbackEnabled: true)
            .offset(x: offset.width, y: offset.height)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = CGSize(width: gesture.translation.width + lastOffset.width, height: gesture.translation.height + lastOffset.height)
                    }
                    .onEnded { _ in
                        lastOffset = offset
                    }
            )
            .onDisappear {
                offset = CGSize.zero
                lastOffset = CGSize.zero
            }
            .onChange(of: scale) { value in
                if value < 2.0 {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        offset = CGSize.zero
                        lastOffset = CGSize.zero
                    }
                }
            }
    }
}
#else
public struct Zoomable: ViewModifier {
    @AppStorage("MaxmiumScale") var maxmiumScale = 6.0
    @State var scale: CGFloat = 1.0
    @State var offset = CGSize.zero
    @State var lastOffset = CGSize.zero
    
    public init() {
        
    }
    
    public func body(content: Content) -> some View {
        content
            .scaleEffect(self.scale)
            .offset(x: offset.width, y: offset.height)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = CGSize(width: gesture.translation.width + lastOffset.width, height: gesture.translation.height + lastOffset.height)
                    }
                    .onEnded { _ in
                        lastOffset = offset
                    }
            )
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        self.scale = value
                    }
            )
            .onDisappear {
                offset = CGSize.zero
                lastOffset = CGSize.zero
            }
    }
}
#endif

#if !os(watchOS)
import WebKit

public struct WebView: UIViewRepresentable {
    let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) {}
}

public struct TextSelectView: View {
    @usableFromInline var text: String
    
    @usableFromInline
    init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        VStack {
            TextEditor(text: .constant(text))
                .padding()
        }
    }
}

public struct CopyableView<V: View>: View {
    var content: String
    var allowSelect: Bool
    var view: () -> V
    @State var present = false
    init(_ content: String, allowSelect: Bool = true, view: @escaping () -> V) {
        self.content = content
        self.allowSelect = allowSelect
        self.view = view
    }
    public var body: some View {
        view()
            .contextMenu {
                Button(action: {
                    UIPasteboard.general.string = content
#if !os(visionOS)
                    AlertKitAPI.present(title: "已复制", subtitle: "简介内容已复制到剪贴板", icon: .done, style: .iOS17AppleMusic, haptic: .success)
#endif
                }, label: {
                    Label("复制", systemImage: "doc.on.doc")
                })
                if allowSelect {
                    Button(action: {
                        present = true
                    }, label: {
                        Label("选择文本", systemImage: "selection.pin.in.out")
                    })
                }
            }
            .sheet(isPresented: $present, content: {
                TextSelectView(text: content)
            })
    }
}
#endif

public extension View {
    func onPressChange(_ action: @escaping (Bool) -> Void) -> some View {
        self.buttonStyle(ButtonStyleForPressAction(pressAction: action))
    }
}
public struct ButtonStyleForPressAction: ButtonStyle {
    var pressAction: (Bool) -> Void
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { value in
                pressAction(value)
            }
    }
}

public extension Binding {
    // From - rdar://so?64655458
    func onUpdate(_ closure: @escaping () -> Void) -> Binding<Value> {
        Binding(get: {
            wrappedValue
        }, set: { newValue in
            wrappedValue = newValue
            closure()
        })
    }
    func onUpdate(_ closure: @escaping (_ oldValue: Value, _ newValue: Value) -> Void) -> Binding<Value> {
        Binding(get: {
            wrappedValue
        }, set: { newValue in
            let oldValue = wrappedValue
            wrappedValue = newValue
            closure(oldValue, newValue)
        })
    }
}

public extension View {
    func border<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
            .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}
