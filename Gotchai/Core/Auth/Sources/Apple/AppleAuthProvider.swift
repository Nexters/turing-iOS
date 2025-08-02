//
//  AppleAuthProvider.swift
//  Auth
//
//  Created by koreamango on 7/25/25.
//

import Combine
import AuthenticationServices

public final class AppleAuthProvider: NSObject, AuthProvider {
  private var signInSubject: PassthroughSubject<UserSession, Error>?
  private var authorizationController: ASAuthorizationController?

  public override init() {}

  public func signIn() -> AnyPublisher<UserSession, any Error> {
    let subject = PassthroughSubject<UserSession, Error>()
    self.signInSubject = subject

    let request = ASAuthorizationAppleIDProvider().createRequest()
    request.requestedScopes = []

    let controller = ASAuthorizationController(authorizationRequests: [request])
    controller.delegate = self
    controller.presentationContextProvider = self
    self.authorizationController = controller
    controller.performRequests()

    return subject.eraseToAnyPublisher()
  }

  public func signOut() -> AnyPublisher<Void, any Error> {
    // 애플 로그인은 세션이 없기 때문에 일반적으로 클라이언트에서 signOut 처리가 필요 없음
    return Just(())
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
  }

  public func deleteUser() -> AnyPublisher<Void, any Error> {
    // Apple에서는 유저 삭제 API는 없음. 서버 측 처리 필요
    return Just(())
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
  }
}

// MARK: - ASAuthorizationControllerDelegate
extension AppleAuthProvider: ASAuthorizationControllerDelegate {
  public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
        signInSubject?.send(completion: .failure(NSError(domain: "AppleAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid credential"])))
        return
    }

    let userId = appleIDCredential.user
    let name = [appleIDCredential.fullName?.givenName, appleIDCredential.fullName?.familyName].compactMap { $0 }.joined(separator: " ")
    let idTokenData = appleIDCredential.identityToken ?? Data()
    let token = String(data: idTokenData, encoding: .utf8) ?? ""

    let session = UserSession(
        id: userId,
        name: name.isEmpty ? "Unknown" : name,
        token: token
    )

    signInSubject?.send(session)
    signInSubject?.send(completion: .finished)
    signInSubject = nil
  }

  public func authorizationController(
    controller: ASAuthorizationController,
    didCompleteWithError error: Error
  ) {
    signInSubject?.send(completion: .failure(error))
    signInSubject = nil
  }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension AppleAuthProvider: ASAuthorizationControllerPresentationContextProviding {
  public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    // keyWindow가 없어질 수 있으므로 적절한 UIWindow 제공
    return UIApplication.shared.windows.first { $0.isKeyWindow } ?? ASPresentationAnchor()
  }
}
