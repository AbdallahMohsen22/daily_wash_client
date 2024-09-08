import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/widget/default_scaffold.dart';
import 'package:on_express/core/widget/profile_app_bar.dart';
import 'package:on_express/features/edit_profile.dart/widget/edit_profile_form.dart';
import 'package:on_express/features/edit_profile.dart/widget/user_avatar.dart';

import '../../cubits/menu_cubit/menu_cubit.dart';
import '../../cubits/menu_cubit/menu_states.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});


  EditUserAvatar editUserAvatar = EditUserAvatar();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultScaffold(
          child: InkWell(
            onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileAppBar(
                  title: 'edit_profile'.tr(),
                ),
                const Gap(30),
                EditUserAvatar(),
                const Gap(30),
                Expanded(
                  child: SingleChildScrollView(


                    child: EditProfileForm(
                      menuStates: state,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }


}
