import 'package:EPW_mobile/screens/home/screens/home_screen.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../core/router/app_routes.dart';

import '../../../custome_widgets/custom_translation_widget.dart';
import '../../../utils/common_imports.dart';
import '../../../utils/image_resource.dart';
import '../../base/state/base_hook_consumer_widget.dart';

import '../bloc/register_bloc.dart';
import '../bloc/register_state.dart';
import '../widget/register_widget.dart';

// ignore: must_be_immutable
class RegisterScreen extends BaseHookWidget {
  RegisterScreenBloc? registerScreenBloc;

  RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    registerScreenBloc = useBloc<RegisterScreenBloc>(closeOnDispose: false);

    useBlocListener(registerScreenBloc!, (registerScreenBloc, value, context) {
      if (value is RegisterScreenErrorState) {
        showToast(context: context, message: (value).error.toString());
      }
      if (value is RegisterScreenSuccessState) {
        showToast(context: context, message: value.message!);
        Future.delayed(const Duration(milliseconds: 200));

        pushReplacement(context, HomeScreen());
      }
      if (value is NavigateToHomeScreenState) {
        //    pushNamed(context, HomeScreen());
        //  context.goNamed(AppRoutes.homeScreen);
      }
    });

    final state = useBlocBuilder(
      registerScreenBloc!,
    );
    final appLifecycleState = useAppLifecycleState();

    useEffect(() {
      if (appLifecycleState == AppLifecycleState.resumed) {
        registerScreenBloc!.nameTextController!.clear();
      }
      return null;
    }, [appLifecycleState]);

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage(ImageResource.APPBG2),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
              child: Column(
                children: [
                  //                   Container(
                  // //width:
                  //              // height: MediaQuery.of(context).size.height,
                  //            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
                  //         child: Image.asset(

                  //            ImageResource.APPLOGO,
                  //           fit: BoxFit.cover,

                  //              ),

                  //       ),

                  //       SizedBox(height: 50,),

                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 2.8),
                    child: bodyWidget(state, context),
                  ),
                ],
              ),
            )));
  }

  bodyWidget(RegisterScreenState state, BuildContext context) {
    if (state is RegisterScreenLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RegisterScreenWidgets.nameTxtBox(context, registerScreenBloc!),
            const SizedBox(
              height: 25,
            ),
            RegisterScreenWidgets.classDropDown(context, registerScreenBloc!),
            const SizedBox(
              height: 25,
            ),
            RegisterScreenWidgets.disablityStatusDropDown(
                context, registerScreenBloc!),
            const SizedBox(
              height: 25,
            ),
            if (registerScreenBloc!.isChildDisablity != null &&
                registerScreenBloc!.isChildDisablity == "Yes")
              RegisterScreenWidgets.disablityDropDown(
                  context, registerScreenBloc!),
            const SizedBox(
              height: 25,
            ),
            state is RegisterScreenLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RegisterScreenWidgets.registerbtn(context, registerScreenBloc!),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      );
    }
  }
}
