abstract class AppStates {}

class AppInitState extends AppStates{}
class EmitState extends AppStates{}

class AdsSuccessState extends AppStates{}
class AdsErrorState extends AppStates{}


class SingleProviderSuccessState extends AppStates{}
class SingleProviderErrorState extends AppStates{}

class LocationLoadingState extends AppStates{}
class LocationSuccessState extends AppStates{}
class LocationErrorState extends AppStates{}


class GetProvidersLoadingState extends AppStates{}
class GetProvidersSuccessState extends AppStates{}
class GetProvidersWrongState extends AppStates{}
class GetProvidersErrorState extends AppStates{}


class GetCouponLoadingState extends AppStates{}
class GetCouponSuccessState extends AppStates{}
class GetCouponWrongState extends AppStates{}
class GetCouponErrorState extends AppStates{}

class CreateOrderLoadingState extends AppStates{}
class CreateOrderSuccessState extends AppStates{}
class CreateOrderWrongState extends AppStates{}
class CreateOrderErrorState extends AppStates{}



class GetOrdersLoadingState extends AppStates{}
class GetOrdersSuccessState extends AppStates{}
class GetOrdersWrongState extends AppStates{}
class GetOrdersErrorState extends AppStates{}



class DeleteOrderLoadingState extends AppStates{}
class DeleteOrderSuccessState extends AppStates{}
class DeleteOrderWrongState extends AppStates{}
class DeleteOrderErrorState extends AppStates{}



class ChangeFavLoadingState extends AppStates{}
class ChangeFavSuccessState extends AppStates{}
class ChangeFavWrongState extends AppStates{}
class ChangeFavErrorState extends AppStates{}


class ReviewLaundryLoadingState extends AppStates{}
class ReviewLaundrySuccessState extends AppStates{}
class ReviewLaundryWrongState extends AppStates{}
class ReviewLaundryErrorState extends AppStates{}

