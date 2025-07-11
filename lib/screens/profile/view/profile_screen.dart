import 'package:EPW_mobile/screens/home/screens/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../utils/common_imports.dart';
import '../../../utils/image_resource.dart';
import '../../base/state/base_hook_consumer_widget.dart';

import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widget/profile_widget.dart';

// ignore: must_be_immutable
class ProfileScreen extends BaseHookWidget {
  ProfileScreenBloc? profileScreenBloc;

  ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    print(context.locale);
    profileScreenBloc = useBloc<ProfileScreenBloc>(closeOnDispose: false);

    useBlocListener(profileScreenBloc!, (profileScreenBloc, value, context) {
      if (value is ProfileScreenErrorState) {
        showToast(context: context, message: (value).error.toString());
      }
      if (value is ProfileScreenSuccessState) {
        showToast(context: context, message: value.message!);
        Future.delayed(const Duration(milliseconds: 200));
        pushNamed(context, HomeScreen());
      }
      if (value is NavigateToHomeScreenState) {
        //    pushNamed(context, HomeScreen());
        //  context.goNamed(AppRoutes.homeScreen);
      }
    });

    final state = useBlocBuilder(
      profileScreenBloc!,
    );
    final appLifecycleState = useAppLifecycleState();

    useEffect(() {
      if (appLifecycleState == AppLifecycleState.resumed) {
        profileScreenBloc!.add(ProfileScreenInitialEvent());
      }
      return null;
    }, [appLifecycleState]);

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage(ImageResource.APPBG2),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 2.8),
                  child: ScreenTypeLayout.builder(
                    mobile: (BuildContext context) =>  bodyWidget(state, context,"MOBILE"),
                    tablet: (BuildContext context) =>  bodyWidget(state, context,"TABLET"),
                    desktop: (BuildContext context) =>  bodyWidget(state, context,"DESKTOP"),
                    watch:  (BuildContext context) => bodyWidget(state, context,"WATCH"),
                  ),

                ),
              ),
            )));
  }

  bodyWidget(ProfileScreenState state, BuildContext context,String type) {
    if (state is ProfileScreenLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileScreenWidgets.nameTxtBox(context, profileScreenBloc!),
            const SizedBox(
              height: 25,
            ),
            ProfileScreenWidgets.classDropDown(context, profileScreenBloc!),
            const SizedBox(
              height: 25,
            ),
            ProfileScreenWidgets.disablityTypeStatusDropDown(
                context, profileScreenBloc!),
            const SizedBox(
              height: 25,
            ),
            if (profileScreenBloc!.isChildDisablity != null &&
                profileScreenBloc!.isChildDisablity == "Yes")
              ProfileScreenWidgets.disablityTypeDropDown(
                  context, profileScreenBloc!),
            const SizedBox(
              height: 25,
            ),
            state is ProfileScreenLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ProfileScreenWidgets.Profilebtn(context, profileScreenBloc!),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      );
    }
  }
}
