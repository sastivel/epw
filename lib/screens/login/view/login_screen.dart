import 'package:EPW_mobile/screens/home/bloc/home_bloc.dart';
import 'package:EPW_mobile/screens/home/screens/home_screen.dart';
import 'package:EPW_mobile/utils/image_resource.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../custome_widgets/custom_translation_widget.dart';
import '../../../utils/common_imports.dart';
import '../../base/state/base_hook_consumer_widget.dart';

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
      //  homeScreenBloc?.add(HomeScreenInitialEvent());
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
              height: MediaQuery.of(context).size.height,

              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage(ImageResource.APPBG2),
                  fit: BoxFit.fill,
                  alignment: Alignment.topCenter,
                ),
              ),
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 2.5,bottom: 100),
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child:ScreenTypeLayout.builder(
                        mobile: (BuildContext context) =>  bodyWidget(state, context),
                        tablet: (BuildContext context) =>  bodyTabWidget(state, context),
                        desktop: (BuildContext context) =>  bodyWidget(state, context),
                        watch:  (BuildContext context) => bodyWidget(state, context),
                  ),
                  ),
                ),
              ),
            )));
  }

  bodyWidget(LoginScreenState state, BuildContext context) {
    if (state is LoginScreenLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [

          MyLoginWidgets.mobileNumberTextBox(context, loginBloc!,"MOBILE"),
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
              : MyLoginWidgets.loginbtn(context, loginBloc!,"MOBILE"),
        ],
      );
    }
  }

  bodyTabWidget(LoginScreenState state, BuildContext context) {
    if (state is LoginScreenLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          MyLoginWidgets.mobileNumberTextBox(context, loginBloc!,"TABLET"),
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
              : MyLoginWidgets.loginbtn(context, loginBloc!,"TABLET"),
        ],
      );
    }


  }
}
