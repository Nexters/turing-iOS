//
//  AppFeature.swift
//  Gotchai
//
//  Created by 가은 on 8/2/25.
//
import TCA
import Onboarding
import SignIn
import Main // 모듈명이 Swift의 @main 과 헷갈리면 이름 변경 고려
import Setting

@Reducer
struct AppFeature {
    struct State {
        enum Root: Equatable { case onboarding, signIn, main }
        var root: Root = .onboarding
        var onboarding = OnboardingFeature.State()
        var signIn     = SignInFeature.State()
        var main = MainFeature.State()

        var path = StackState<AppPath.State>()
    }

    enum Action {
        case onboarding(OnboardingFeature.Action)
        case signIn(SignInFeature.Action)
        case setRoot(State.Root)
        case main(MainFeature.Action)

        case path(StackActionOf<AppPath>)
    }

    // 핵심 리듀서를 분리(타입 추론 안정화)
    private var core: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                // 온보딩 → 로그인으로
            case .onboarding(.delegate(.navigateToSignIn)):
                state.root = .signIn
                return .none
                
                // 로그인 성공 → 메인으로
            case .signIn(.delegate(.didSignIn)):
                state.root = .main
                return .none
                
            case let .main(.delegate(mainAction)):
                switch mainAction {
                case .openTuringTest(let id):
                    state.path.append(.turingTest(.init(turingTestID: id)))
                case .moveToSetting:
                    state.path.append(.setting(.init()))
                }
                return .none
                
                // 필요 시 메인에서 로그아웃 이벤트 받아 루트 전환
            case .path(.element(id: _, action: .turingTest(.delegate(let turingAction)))):
                // 테스트 표지 화면에서 받는 Action
                switch turingAction {
                case let .moveToConceptView(turingTest):
                    state.path.append(.turingTestConcept(.init(turingTest: turingTest)))
                case .moveToMainView:
                    state.path.removeAll()
                default: break
                }
                
                return .none
            case .path(.element(id: _, action: .turingTestConcept(.delegate(let turingAction)))):
                // 테스트 상황 세팅 화면에서 받는 Action
                switch turingAction {
                case .moveToQuizView:
                    state.path.append(.quiz(.init()))
                case .moveToMainView:
                    state.path.removeAll()
                default: break
                }
                
                return .none
            case .path(.element(id: _, action: .quiz(.delegate(let quizAction)))):
                // 퀴즈 화면에서 받는 Action
                switch quizAction {
                case .moveToMainView:
                    state.path.removeAll()
                case .moveToResultView:
                    state.path.append(.turingTestResult(.init()))
                }
                return .none
            case .path(.element(id: _, action: .setting(.delegate(.moveToMainView)))):
                // 세팅 화면에서 받는 Action
                state.path.removeAll()
                return .none
            case let .setRoot(root):
                state.root = root
                return .none
                
            default:
                return .none
            }
        }

    }

    var body: some ReducerOf<Self> {
        Scope(state: \.onboarding, action: \.onboarding) { OnboardingFeature() }
        Scope(state: \.signIn,     action: \.signIn)     { SignInFeature() }
        Scope(state: \.main,       action: \.main)       { MainFeature() }
        core
            .forEach(\.path, action: \.path) {
                AppPath()
            }
    }
}
