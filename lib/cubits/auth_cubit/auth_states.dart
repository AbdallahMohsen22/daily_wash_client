abstract class AuthStates{}

class AuthInitState extends AuthStates {}
class EmitState extends AuthStates {}

class CreateUserLoadingState extends AuthStates {}
class CreateUserSuccessState extends AuthStates {}
class CreateUserErrorState extends AuthStates {}
class CreateUserWrongState extends AuthStates {}

class VerifyUserLoadingState extends AuthStates {}
class VerifyUserSuccessState extends AuthStates {}
class VerifyUserErrorState extends AuthStates {}
class VerifyUserWrongState extends AuthStates {}

class SocialLoadingState extends AuthStates {}
class SocialSuccessState extends AuthStates {}
class SocialErrorState extends AuthStates {}
class SocialWrongState extends AuthStates {}