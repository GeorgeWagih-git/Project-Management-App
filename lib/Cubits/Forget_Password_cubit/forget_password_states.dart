abstract class ForgetPasswordStates {}

class ForgetPasswordInitial extends ForgetPasswordStates {}

class SendResetCodeLoading extends ForgetPasswordStates {}

class SendResetCodeSuccess extends ForgetPasswordStates {}

class SendResetCodeFailure extends ForgetPasswordStates {
  final String errMessage;

  SendResetCodeFailure({required this.errMessage});
}

class ResetPasswordLoading extends ForgetPasswordStates {}

class ResetPasswordSuccess extends ForgetPasswordStates {}

class ResetPasswordFailure extends ForgetPasswordStates {
  final String errMessage;

  ResetPasswordFailure({required this.errMessage});
}
