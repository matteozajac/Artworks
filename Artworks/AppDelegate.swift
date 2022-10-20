import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(
            rootViewController: ArtworkListComposer.compose(
                loadArtworkUseCase: LoadArtworkInteractor(
                    remoteArtworkRepository: AICArtworkRemoteDataSource(
                        httpClient: URLSessionHTTPClient(),
                        host: URL(string: "https://api.artic.edu/api/v1")!
                    ))
            ))
        window?.makeKeyAndVisible()

        return true
    }
}

// Testing App Delegate
// Handle server issue in a different way
// Composer
// Use cases
// Diagram
// Different Data Stores MET, AIC
// Programatic UI - no storyboards
