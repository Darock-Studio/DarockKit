#if os(iOS)
import UIKit

public enum AlertKitAPI {
    public static func present(title: String? = nil, subtitle: String? = nil, icon: DarockKit.UIAlert.AlertIcon? = nil, style: DarockKit.UIAlert.AlertViewStyle, haptic: DarockKit.UIAlert.AlertHaptic? = nil, duration: TimeInterval? = nil) {
        switch style {
        case .iOS16AppleMusic:
            guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
            let view = AlertAppleMusic16View(title: title, subtitle: subtitle, icon: icon, duration: duration)
            view.haptic = haptic
            view.present(on: window)
        case .iOS17AppleMusic:
            guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
            let view = AlertAppleMusic17View(title: title, subtitle: subtitle, icon: icon, duration: duration)
            view.haptic = haptic
            view.present(on: window)
        }
    }
}
#endif
