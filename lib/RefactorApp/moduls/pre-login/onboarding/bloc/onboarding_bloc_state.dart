part of 'onboarding_bloc_bloc.dart';

@immutable
sealed class OnboardingBlocState {
  const OnboardingBlocState();
}

class OnboardingInitial extends OnboardingBlocState {
  const OnboardingInitial();
}

class OnboardingPageChanged extends OnboardingBlocState {
  final int currentIndex;

  const OnboardingPageChanged(this.currentIndex);
}
