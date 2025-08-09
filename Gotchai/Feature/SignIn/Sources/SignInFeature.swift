//
//  AuthFeature.swift
//  Auth
//
//  Created by 가은 on 7/20/25.
//

import ComposableArchitecture
import Auth
import Navigation
import Combine
import Foundation

@Reducer
public struct SignInFeature {
    @Dependency(\.kakaoAuthProvider) var kakaoAuthProvider
    @Dependency(\.appleAuthProvider) var appleAuthProvider
    @Dependency(\.appRouter) var appRouter
    @Dependency(\.signInClient) var signInClient
    @Dependency(\.signInService) var signInService

    enum CancelID { case registerSession }

    @ObservableState
    public struct State: Equatable {
        public init() { }
        var isLoading: Bool = false
        var user: UserSession?
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
                // 1) 카카오 로그인 트리거
            case .tappedKakaoLogin:
                state.isLoading = true
                return .run { send in
                    do {
                        let session = try await signInClient.signInWithKakao(kakaoAuthProvider)
                        await send(.signInResponse(.success(session)))
                    } catch {
                        await send(.signInResponse(.failure(error)))
                    }
                }

                // (선택) 애플도 동일 패턴
            case .tappedAppleLogin:
                state.isLoading = true
                return .run { send in
                    do {
                        let session = try await signInClient.signInWithApple(appleAuthProvider)
                        await send(.signInResponse(.success(session)))
                    } catch {
                        await send(.signInResponse(.failure(error)))
                    }
                }

                // 2) 로그인 성공 → 우리 서버에 세션 등록
            case let .signInResponse(.success(session)):
                let req = KakaoSignInRequestDTO(accessToken: session.token)
                return .publisher {
                    signInService.registerKakaoSession(req)
                        .map { SignInFeature.Action.registerSessionResponse(.success(())) }
                        .catch { Just(.registerSessionResponse(.failure($0))) }
                        .receive(on: RunLoop.main)
                }
                .cancellable(id: CancelID.registerSession, cancelInFlight: true)

                // 3) 로그인 실패
            case let .signInResponse(.failure(error)):
                state.isLoading = false
                // 에러 상태 업데이트/토스트 등
                print("로그인 실패:", error)
                return .none

                // 4) 세션 등록 성공 → 화면 전환
            case .registerSessionResponse(.success):
                state.isLoading = false
                return .send(.delegate(.didSignIn))

                // 5) 세션 등록 실패
            case let .registerSessionResponse(.failure(error)):
                state.isLoading = false
                print("세션 등록 실패:", error)
                // 실패 UI 처리
                return .none

            case .delegate:
                return .none
            }
        }
    }
}


