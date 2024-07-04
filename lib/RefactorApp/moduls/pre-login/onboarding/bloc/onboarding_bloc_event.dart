part of 'onboarding_bloc_bloc.dart';

@immutable
sealed class OnboardingBlocEvent {
  const OnboardingBlocEvent();
}

class PageChangedEvent extends OnboardingBlocEvent {
  final int pageIndex;

  PageChangedEvent({required this.pageIndex});
}

class SkipEvent extends OnboardingBlocEvent {
  final BuildContext context;

  SkipEvent({required this.context});
}

class NextPageEvent extends OnboardingBlocEvent {
  final BuildContext context;

  NextPageEvent(this.context);
}
