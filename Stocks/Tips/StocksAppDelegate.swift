import SwiftUI
import AppsFlyerLib
import Combine
import AdSupport
import AppTrackingTransparency

class StocksAppDelegate: NSObject, UIApplicationDelegate, AppsFlyerLibDelegate {
    
    @objc private func dnsajdnjaksncfad() {
        AppsFlyerLib.shared().start()
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                UserDefaults.standard.set(ASIdentifierManager.shared().advertisingIdentifier.uuidString, forKey: "idfa_user_app")
            }
        }
    }
    
    
    func onConversionDataSuccess(_ conversionData: [AnyHashable: Any]) {
        NotificationCenter.default.post(name: .ndjsnajdnajbdjbjfsadgsgad, object: nil, userInfo: ["data": conversionData])
    }
    
    func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppsFlyerLib.shared().appsFlyerDevKey = "CneNXb4Kx9txATiBkKF3de"
        AppsFlyerLib.shared().appleAppID = "6636547904"
        let a = 1
        let b = 2
        let c = a + b + a + b
        AppsFlyerLib.shared().isDebug = false
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
        AppsFlyerLib.shared().delegate = self
        
        if c > 2 {
            let _ = a + b
        } else {
            let _ = a - b
        }
        NotificationCenter.default.addObserver(self, selector: #selector(dnsajdnjaksncfad),
            name: UIApplication.didBecomeActiveNotification, object: nil)
        
        return true
    }
    
    func onConversionDataFail(_ error: Error) {
        let s: String? = "String!"
        let s2 = s ?? nil
        let result = (s2 != nil) ? true : false
        if result {
        }
        NotificationCenter.default.post(name: .ndjsnajdnajbdjbjfsadgsgad, object: nil, userInfo: [:])
    }
    
}

extension Notification.Name {
    static let ndjsnajdnajbdjbjfsadgsgad = Notification.Name("app_success_or_error_conv")
}

