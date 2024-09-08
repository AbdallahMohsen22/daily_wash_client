import 'package:easy_localization/easy_localization.dart';
import 'package:on_express/core/utils/image_resources.dart';

class SliderModel {
  String? image;
  String? title;
  String? description;

// Constructor for variables
  SliderModel({
    this.description,
    this.image,
    this.title,
  });

  void setImage(String getImage) {
    image = getImage;
  }

  void setTitle(String title) {
    this.title = title;
  }

  void setDescription(String getDescription) {
    description = getDescription;
  }

  String? getImage() {
    return image;
  }

  String? getTitle() {
    return title;
  }

  String? getDescription() {
    return description;
  }
}

// List created
List<SliderModel> getSlides() {
  List<SliderModel> slides = [];
  SliderModel sliderModel = SliderModel();

// Item 1
  sliderModel.setImage(ImageResources.onboarding1);
  sliderModel.setTitle("Laundry_services".tr());
  sliderModel.setDescription(
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud");
  slides.add(sliderModel);

  sliderModel = SliderModel();

// Item 2
  sliderModel.setImage(ImageResources.onboarding2);
  sliderModel.setTitle("clean_neat".tr());
  sliderModel.setDescription(
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud");
  slides.add(sliderModel);

  sliderModel = SliderModel();

  sliderModel = SliderModel();
  return slides;
}
