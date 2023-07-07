import UIKit
import Flutter
import WidgetKit
import HandyJSON

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        demo()
        let controller:FlutterViewController = window?.rootViewController as! FlutterViewController
        _ = WidgetMethod(message: controller.binaryMessenger)
        GeneratedPluginRegistrant.register(with: self)
//        ui()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func demo() {
        let userDefault = UserDefaults(suiteName: "group.com.demo.cjl.MyWidget")
        userDefault?.setValue("cjl", forKey: "name")
        userDefault?.setValue(30, forKey: "age")
    }

    func ui() {
        if let controller: FlutterViewController = UIApplication.shared.delegate?.window??.rootViewController as? FlutterViewController {
//            let view = FlutterViewController(project: nil, initialRoute: "/mine", nibName: nil, bundle: nil)
//            WidgetShare.share.mineWidget = view
//            view.view.frame = .init(x: 100, y: 100, width: 200, height: 200)
//            controller.view.addSubview(view.view)
            
            let flutter = FlutterViewController()
            controller.addChild(flutter)
            flutter.didMove(toParent: controller)
            
            
            let engine = FlutterEngine(name: "mine_engine")
            engine.run(withEntrypoint: nil)
        }
    }
}

class WidgetMethod {
    init(message: FlutterBinaryMessenger) {
        let channel = FlutterMethodChannel(name: "com.example.flutterUiExample", binaryMessenger: message)
        channel.setMethodCallHandler { call, result in
            if call.method == "reload" {
                let name = "孙悟空"
                let age = 100
                let userDefault = UserDefaults(suiteName: "group.com.demo.cjl.MyWidget")
                userDefault?.set(name, forKey: "name")
                userDefault?.set(age, forKey: "age")
                WidgetCenter.shared.reloadAllTimelines()
            } else if call.method == "ui" {
//                if let controller: FlutterViewController = UIApplication.shared.delegate?.window??.rootViewController as? FlutterViewController {
//                    let view = FlutterViewController(engine: controller.engine!, nibName: nil, bundle: nil)
//                    view.setInitialRoute("mine")
//                    WidgetShare.share.mineWidget = view
//                }
            } else if call.method == "add" {
                let json = DefaultUtils.share.getString(forKey: "add")
                if let json = json {
                    DataUtils.share.add(json: json)
                }
            } else if call.method == "remove" {
                let json = DefaultUtils.share.getString(forKey: "remove")
                if let json = json {
                    DataUtils.share.remove(json: json)
                }
            }
        }
    }
}
