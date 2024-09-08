abstract class MenuStates {}

class MenuInitState extends MenuStates{}
class EmitState extends MenuStates{}


class UserSuccessState extends MenuStates{}
class UserErrorState extends MenuStates{}

class StaticPagesSuccessState extends MenuStates{}
class StaticPagesErrorState extends MenuStates{}

class SettingsSuccessState extends MenuStates{}
class SettingsErrorState extends MenuStates{}


class UpdateUserLoadingState extends MenuStates{}
class UpdateUserSuccessState extends MenuStates{}
class UpdateUserWrongState extends MenuStates{}
class UpdateUserErrorState extends MenuStates{}


class AddressLoadingState extends MenuStates{}
class AddressSuccessState extends MenuStates{}
class AddressWrongState extends MenuStates{}
class AddressErrorState extends MenuStates{}



class ContactUsLoadingState extends MenuStates{}
class ContactUsSuccessState extends MenuStates{}
class ContactUsWrongState extends MenuStates{}
class ContactUsErrorState extends MenuStates{}

class GetNotificationLoadingState extends MenuStates{}
class GetNotificationSuccessState extends MenuStates{}
class GetNotificationWrongState extends MenuStates{}
class GetNotificationErrorState extends MenuStates{}


class DeleteAccountLoadingState extends MenuStates{}
class DeleteAccountSuccessState extends MenuStates{}
class DeleteAccountWrongState extends MenuStates{}
class DeleteAccountErrorState extends MenuStates{}

