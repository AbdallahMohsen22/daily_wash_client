import 'package:on_express/core/generic_cubit/generic_cubit.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/features/requests/model/request_model.dart';

class RequestViewModel {
  GenericCubit<List<RequestModel>?> requestsCubit = GenericCubit(null);
  List<RequestModel> items = [
    RequestModel(
      imageUrl: ImageResources.laundromat,
      providerName: "Name Of Store",
      distance: '2.2 KM',
      location: '26985 Brighton..',
      status: "Pickup",
    ),
    RequestModel(
      imageUrl: ImageResources.laundromat,
      providerName: "Name Of Store",
      distance: '2.2 KM',
      location: '26985 Brighton..',
      status: "Pickup",
    ),
    RequestModel(
      imageUrl: ImageResources.laundromat,
      providerName: "Name Of Store",
      distance: '2.2 KM',
      location: '26985 Brighton..',
      status: "Pickup",
    ),
    RequestModel(
      imageUrl: ImageResources.laundromat,
      providerName: "Name Of Store",
      distance: '2.2 KM',
      location: '26985 Brighton..',
      status: "Pickup",
    ),
    RequestModel(
      imageUrl: ImageResources.laundromat,
      providerName: "Name Of Store",
      distance: '2.2 KM',
      location: '26985 Brighton..',
      status: "Pickup",
    )
  ];

  Future<void> deleterequest(int index) async {
    requestsCubit.onLoadingState();
    items.removeAt(index);

    requestsCubit.onUpdateData(items);
  }
}
