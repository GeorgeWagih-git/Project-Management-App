abstract class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

final class SignUpSuccess extends SignUpStates {}

final class OngoingProjectImageSelected extends SignUpStates {}

final class SignUpLoading extends SignUpStates {}

final class SignUpFailure extends SignUpStates {
  final String errMessage;

  SignUpFailure({required this.errMessage});
}
