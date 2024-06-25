import 'package:EPW_mobile/screens/home/bloc/home_bloc.dart';
import 'package:EPW_mobile/screens/home/screens/home_screen.dart';
import 'package:EPW_mobile/utils/image_resource.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../custome_widgets/custom_translation_widget.dart';
import '../../../utils/common_imports.dart';
import '../../base/state/base_hook_consumer_widget.dart';

import '../../home/bloc/home_event.dart';
import '../../register/view/register_screen.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_state.dart';
import '../widgets/login_widgets.dart';

// ignore: must_be_immutable
class LoginScreen extends BaseHookWidget {
  LoginScreenBloc? loginBloc;
  HomeScreenBloc? homeScreenBloc;
  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    loginBloc = useBloc<LoginScreenBloc>(closeOnDispose: false);
    homeScreenBloc = useBloc<HomeScreenBloc>(closeOnDispose: false);
    useBlocListener(loginBloc!, (loginBloc, value, context) {
      if (value is LoginScreenErrorState) {
        showToast(context: context, message: (value).error.toString());
      }
      if (value is LoginScreenSuccessState) {
        showToast(context: context, message: 'Logged in successfully');
        Future.delayed(const Duration(milliseconds: 200));
        pushNamed(context, RegisterScreen());
        ;
      }
      if (value is NavigateToHomeScreenState) {
        showToast(context: context, message: 'Logged in successfully');
        homeScreenBloc?.add(HomeScreenInitialEvent());
        Future.delayed(const Duration(milliseconds: 200));
        pushReplacement(context, HomeScreen());
      }
    });

    final state = useBlocBuilder(
      loginBloc!,
    );
    final appLifecycleState = useAppLifecycleState();

    useEffect(() {
      if (appLifecycleState == AppLifecycleState.resumed) {
        loginBloc!.mobileNumberController.clear();
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
                  fit: BoxFit.fill,
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

                  // SizedBox(height: 20,),

                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 2.5),
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: bodyWidget(state, context),
                    ),
                  ),
                ],
              ),
            )));
  }

  bodyWidget(LoginScreenState state, BuildContext context) {
    if (state is LoginScreenLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyLoginWidgets.mobileNumberTextBox(context, loginBloc!),
          const SizedBox(
            height: 20,
          ),
          CustomTranslationWidget(bloc: loginBloc),
          const SizedBox(
            height: 20,
          ),
          state is LoginScreenLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : MyLoginWidgets.loginbtn(context, loginBloc!),
        ],
      );
    }
  }
}
