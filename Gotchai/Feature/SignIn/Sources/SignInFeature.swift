//
//  AuthFeature.swift
//  Auth
//
//  Created by 가은 on 7/20/25.
//

import TCA
import Auth
import Combine
import Foundation

@Reducer
public struct SignInFeature {
    @Dependency(\.kakaoAuthProvider) var kakaoAuthProvider
    @Dependency(\.appleAuthProvider) var appleAuthProvider
    @Dependency(\.signInClient) var signInClient
    @Dependency(\.signInService) var signInService

    enum CancelID { case registerSession }
    enum Provider: Equatable { case kakao, apple }

    @ObservableState
    public struct State: Equatable {
        public init() { }
        var isLoading: Bool = false
        var user: UserSession?
        var lastProvider: Provider? = nil
    }

    public enum Delegate { case didSignIn }

    public enum Action {
        case tappedKakaoLogin
        case tappedAppleLogin

        case signInResponse(Result<UserSession, Error>)
        case registerSessionResponse(Result<Void, Error>)
        case delegate(Delegate)
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce {
            state,
            action in
            switch action {
            case .tappedKakaoLogin:
                state.isLoading = true
                state.lastProvider = .kakao
                return .run { send in
                    do {
                        let session = try await signInClient.signInWithKakao(kakaoAuthProvider)
                        await send(.signInResponse(.success(session)))
                    } catch {
                        await send(.signInResponse(.failure(error)))
                    }
                }

            case .tappedAppleLogin:
                state.isLoading = true
                state.lastProvider = .apple
                return .run { send in
                    do {
                        let session = try await signInClient.signInWithApple(appleAuthProvider)
                        await send(.signInResponse(.success(session)))
                    } catch {
                        await send(.signInResponse(.failure(error)))
                    }
                }

            case let .signInResponse(.success(session)):
                    // ✅ 로그인 성공 후, 어떤 프로바이더인지에 따라 DTO 분기
                    switch state.lastProvider {
                    case .kakao:
                      let req = KakaoSignInRequestDTO(accessToken: session.token)
                      return .publisher {
                        signInService.registerKakaoSession(req)
                          .map { SignInFeature.Action.registerSessionResponse(.success(())) }
                          .catch { Just(.registerSessionResponse(.failure($0))) }
                          .receive(on: RunLoop.main)
                      }
                      .cancellable(id: CancelID.registerSession, cancelInFlight: true)

                    case .apple:
                      let req = AppleSignInRequestDTO(idToken: session.token)
                      return .publisher {
                        signInService.registerAppleSession(req)
                          .map { SignInFeature.Action.registerSessionResponse(.success(())) }
                          .catch { Just(.registerSessionResponse(.failure($0))) }
                          .receive(on: RunLoop.main)
                      }
                      .cancellable(id: CancelID.registerSession, cancelInFlight: true)

                    case .none:
                      // 방어 로직: 프로바이더 정보가 없으면 실패 처리
                      state.isLoading = false
                      print("로그인 프로바이더 정보 없음")
                      return .none
                    }


            case let .signInResponse(.failure(error)):
                state.isLoading = false
                print("로그인 실패:", error)
                return .none

            case .registerSessionResponse(.success):
                state.isLoading = false
                return .send(.delegate(.didSignIn))

            case let .registerSessionResponse(.failure(error)):
                state.isLoading = false
                print("세션 등록 실패:", error)
                return .none

            case .delegate:
                return .none
            }
        }
    }
}


