import 'package:easy_localization/easy_localization.dart';
import 'package:on_express/core/generic_cubit/generic_cubit.dart';

class SearchViewModel {
  GenericCubit<List<bool>?> filterCubit = GenericCubit(null);

  bool selected = false;
  List<String> filterItems = [
    "all".tr(),
    //"nearest".tr(),
    "best_reviews".tr(),
  ];
  List<bool> filterSelected = [true, false];
  void setFilterSelected(bool value, int index) {
    filterCubit.onLoadingState();
    filterSelected[index] = !filterSelected[index];
    selected = filterSelected[index];
    filterCubit.onUpdateData(filterSelected);
  }
}
