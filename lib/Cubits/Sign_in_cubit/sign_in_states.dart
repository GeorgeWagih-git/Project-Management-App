abstract class SignInStates {}

class SignInInitialState extends SignInStates {}

final class SignInSuccess extends SignInStates {}

final class SignInLoading extends SignInStates {}

final class SignInFailure extends SignInStates {
  final String errMessage;

  SignInFailure({required this.errMessage});
}
