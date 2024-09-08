import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_size.dart';
import '../../../core/widget/image_net.dart';
import '../../../cubits/menu_cubit/menu_cubit.dart';
import '../../../cubits/menu_cubit/menu_states.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return Align(
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSize.h75),
        child: ImageNet(
          fit: BoxFit.cover,
          image: MenuCubit.get(context).userModel?.data?.personalPhoto??'',
          height: AppSize.h150,
          width: AppSize.w150,
        ),
      ),
    );
  },
);
  }
}
