import 'package:easy_localization/easy_localization.dart';
import 'package:on_express/core/generic_cubit/generic_cubit.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/features/home/model/service_type_model.dart';

class HomeViewModel {
  GenericCubit<int> adsCubit = GenericCubit(0);
  GenericCubit<int> serviceTypeCubit = GenericCubit(0);
  int selectedAds = 0;
  int selectedServiceType = 0;

  List<ServiceTypeModel> serviceTypes = [
    ServiceTypeModel(
      title: "delivery".tr(),
      imageUrl: ImageResources.delivery,
    ),
    ServiceTypeModel(
      title: "pickup".tr(),
      imageUrl: ImageResources.pickup,
    ),
  ];

  void setSelectedAds(int index) {
    adsCubit.onLoadingState();
    selectedAds = index;
    adsCubit.onUpdateData(selectedAds);
  }

  void setSelectedService(int index) {
    serviceTypeCubit.onLoadingState();
    selectedServiceType = index;

    serviceTypeCubit.onUpdateData(selectedServiceType);
  }
}
