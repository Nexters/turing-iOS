//
//  AppleAuthProvider.swift
//  Auth
//
//  Created by koreamango on 7/25/25.
//

import Combine
import AuthenticationServices
import UIKit

public final class AppleAuthProvider: NSObject, AuthProvider {
  private var signInSubject: PassthroughSubject<UserSession, Error>?
  private var authorizationController: ASAuthorizationController?

  public override init() {}

  public func signIn() -> AnyPublisher<UserSession, any Error> {
    let subject = PassthroughSubject<UserSession, Error>()
    self.signInSubject = subject

    let request = ASAuthorizationAppleIDProvider().createRequest()
    request.requestedScopes = [.fullName, .email]

    let controller = ASAuthorizationController(authorizationRequests: [request])
    controller.delegate = self
    controller.presentationContextProvider = self
    self.authorizationController = controller

    // ✅ UI API는 반드시 메인에서
    if Thread.isMainThread {
      controller.performRequests()
    } else {
      DispatchQueue.main.async { controller.performRequests() }
    }

    return subject.eraseToAnyPublisher()
  }

  public func signOut() -> AnyPublisher<Void, any Error> {
    Just(())
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }

  public func deleteUser() -> AnyPublisher<Void, any Error> {
    Just(())
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
}

// MARK: - ASAuthorizationControllerDelegate
extension AppleAuthProvider: ASAuthorizationControllerDelegate {
  public func authorizationController(
    controller: ASAuthorizationController,
    didCompleteWithAuthorization authorization: ASAuthorization
  ) {
    guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
      signInSubject?.send(completion: .failure(NSError(
        domain: "AppleAuth", code: -1,
        userInfo: [NSLocalizedDescriptionKey: "Invalid credential"]
      )))
      authorizationController = nil
      signInSubject = nil
      return
    }

    let userId = appleIDCredential.user
    let name = [appleIDCredential.fullName?.givenName, appleIDCredential.fullName?.familyName]
      .compactMap { $0 }.joined(separator: " ")
    let email = appleIDCredential.email
    let token = String(data: appleIDCredential.identityToken ?? Data(), encoding: .utf8) ?? ""

    let session = UserSession(
      id: userId,
      name: name.isEmpty ? "Unknown" : name,
      email: email ?? "Unknown",
      token: token
    )

    // 결과 전달은 메인 보장 (UI 후속 처리 안전)
    if Thread.isMainThread {
      signInSubject?.send(session)
      signInSubject?.send(completion: .finished)
    } else {
      DispatchQueue.main.async {
        self.signInSubject?.send(session)
        self.signInSubject?.send(completion: .finished)
      }
    }
    authorizationController = nil
    signInSubject = nil
  }

  public func authorizationController(
    controller: ASAuthorizationController,
    didCompleteWithError error: Error
  ) {
    if Thread.isMainThread {
      signInSubject?.send(completion: .failure(error))
    } else {
      DispatchQueue.main.async {
        self.signInSubject?.send(completion: .failure(error))
      }
    }
    authorizationController = nil
    signInSubject = nil
  }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension AppleAuthProvider: ASAuthorizationControllerPresentationContextProviding {
  public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    // ✅ 메인 스레드에서 현재 활성 윈도우 탐색
    let findAnchor: () -> ASPresentationAnchor = {
      for scene in UIApplication.shared.connectedScenes {
        guard scene.activationState == .foregroundActive,
              let windowScene = scene as? UIWindowScene else { continue }
        if let key = windowScene.windows.first(where: { $0.isKeyWindow }) {
          return key
        }
        if let first = windowScene.windows.first {
          return first
        }
      }
      return ASPresentationAnchor()
    }

    if Thread.isMainThread {
      return findAnchor()
    } else {
      // Main Thread Checker 회피: 동기적으로 메인에서 anchor 얻기
      var anchor = ASPresentationAnchor()
      DispatchQueue.main.sync { anchor = findAnchor() }
      return anchor
    }
  }
}
