import 'package:EPW_mobile/screens/home/screens/home_screen.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
        registerScreenBloc!.nameTextController.clear();
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
                  alignment: Alignment.center,
                ),
              ),
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 2.8),
                  child:ScreenTypeLayout.builder(
                    mobile: (BuildContext context) =>  bodyWidget(state, context,"MOBILE"),
                    tablet: (BuildContext context) =>  bodyWidget(state, context,"TABLET"),
                    desktop: (BuildContext context) =>  bodyWidget(state, context,"DESKTOP"),
                    watch:  (BuildContext context) => bodyWidget(state, context,"WATCH"),
                  ),


                ),
              ),
            )));
  }

  bodyWidget(RegisterScreenState state, BuildContext context,String type) {
    if (state is RegisterScreenLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RegisterScreenWidgets.nameTxtBox(context, registerScreenBloc!,type),
            const SizedBox(
              height: 25,
            ),
            RegisterScreenWidgets.classDropDown(context, registerScreenBloc!,type),
            const SizedBox(
              height: 25,
            ),
            RegisterScreenWidgets.disablityStatusDropDown(
                context, registerScreenBloc!,type),
            const SizedBox(
              height: 25,
            ),
            if (registerScreenBloc!.isChildDisablity != null &&
                registerScreenBloc!.isChildDisablity == "Yes")
              RegisterScreenWidgets.disablityDropDown(
                  context, registerScreenBloc!,type),
            const SizedBox(
              height: 25,
            ),
            state is RegisterScreenLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RegisterScreenWidgets.registerbtn(context, registerScreenBloc!,type),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      );
    }
  }
}
