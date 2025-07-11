import 'package:EPW_mobile/custome_widgets/custom_style.dart';
import 'package:EPW_mobile/screens/explore_screen/view/explore_screen.dart';
import 'package:EPW_mobile/screens/home/bloc/home_bloc.dart';
import 'package:EPW_mobile/screens/home/bloc/home_event.dart';
import 'package:EPW_mobile/screens/login/bloc/login_bloc.dart';
import 'package:EPW_mobile/screens/login/bloc/login_event.dart';
import 'package:EPW_mobile/screens/login/view/login_screen.dart';
import 'package:EPW_mobile/screens/profile/view/profile_screen.dart';
import 'package:EPW_mobile/screens/register/view/register_screen.dart';
import 'package:EPW_mobile/utils/color_resource.dart';
import 'package:EPW_mobile/utils/string_resource.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../utils/common_imports.dart';
import '../../../utils/image_resource.dart';
import '../../base/state/base_hook_consumer_widget.dart';
import '../../materials/view/material_screen.dart';
import '../bloc/Home_state.dart';
import '../widgets/home_Screen_widget.dart';

class HomeScreen extends BaseHookWidget {
  HomeScreenBloc? homeScreenBloc;
  LoginScreenBloc? loginScreenBloc;
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    homeScreenBloc = useBloc<HomeScreenBloc>(closeOnDispose: false);
    loginScreenBloc = useBloc<LoginScreenBloc>(closeOnDispose: false);
    final state = useBlocBuilder(
      homeScreenBloc!,
    );
    final appLifecycleState = useAppLifecycleState();
    useEffect(() {
      if (appLifecycleState == AppLifecycleState.resumed) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        homeScreenBloc!.add(HomeScreenInitialEvent());
        //  });
      }
      return null;
    }, [appLifecycleState]);
    print(context.locale);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage(ImageResource.APPBG4),
                  fit: BoxFit.fill,
                  alignment: Alignment.topCenter,
                ),
              ),
              child:ScreenTypeLayout.builder(
                mobile: (BuildContext context) =>  bodyWidget(state, context,"MOBILE"),
                tablet: (BuildContext context) =>  bodyWidget(state, context,"TABLET"),
                desktop: (BuildContext context) =>  bodyWidget(state, context,"DESKTOP"),
                watch:  (BuildContext context) => bodyWidget(state, context,"WATCH"),
              ),

            )));
  }

  bodyWidget(state,BuildContext context,String type) {
    return state is HomeScreenLoadingState
        ? Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(child: CircularProgressIndicator()))
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(right: 10,),
                child: Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: InkWell(
                      onTap: () async {
                        await homeScreenBloc?.clear();
                        // ignore: use_build_context_synchronously
                        loginScreenBloc
                            ?.add(LoginScreenLanguageChangeEvent(false));
                        // ignore: use_build_context_synchronously
                        await EasyLocalization.of(context)
                            ?.setLocale(context.supportedLocales[0]);
                        pushReplacement(context, LoginScreen());
                      },
                      child: const Icon(
                        Icons.power_settings_new_outlined,
                        color: ColorResource.COLOR_APP_TEXT_FIELD_BORDER,
                      )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        StringResource.WELCOME.tr(),
                        style: CustomStyle.size38w700FFFFF(),
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return AlertDialog(
                                title: Text(StringResource.STUDENT_LIST.tr()),
                                content: setupAlertDialoadContainer(context),
                              );
                            });
                          });
                    },
                    child: Icon(
                      Icons.swap_vert_circle,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ],
              ),
               SizedBox(
                height: type == "TABLET" ? 60:0 ,
              ),
              MyHomeScreenWidgets.languageSwitch(homeScreenBloc!, context),
               SizedBox(
                height: type == "TABLET" ? 90:0 ,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          pushNamed(context, ProfileScreen());
                        },
                        child: MyHomeScreenWidgets.cardWithImage(context, true,
                            ImageResource.PROFILE, StringResource.PROFILE,type),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MaterialScreen()));
                        },
                        child: MyHomeScreenWidgets.cardWithImage(context, true,
                            ImageResource.STUDYMAT, StringResource.STUDYMAT,type),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExploreScreen()));
                    },
                    child: MyHomeScreenWidgets.cardWithImage(context, false,
                        ImageResource.QUIZ, StringResource.QUIZ,type),
                  )
                ],
              )
            ],
          );
  }

  Widget setupAlertDialoadContainer(BuildContext context) {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: homeScreenBloc!.studentList!.length,
                itemBuilder: (BuildContext context, int index) {
                  // if (index == homeScreenBloc!.studentList!.length) {
                  //   return addUserBtn(context);
                  // } else {
                  return ListTile(
                      title:
                          Text('${homeScreenBloc!.studentList![index].name}'),
                      trailing: Checkbox(
                          value: homeScreenBloc!.selectedStudent!.id ==
                                  homeScreenBloc!.studentList![index].id
                              ? true
                              : false,
                          onChanged: (value) {
                            homeScreenBloc!.add(HomeScreenSelectStudentEvent(
                                homeScreenBloc!.studentList![index]));
                            Navigator.of(context).pop();
                          }));
                  //  }
                }),
          ),
          InkWell(
            onTap: () {
              pushNamed(context, RegisterScreen());
            },
            child: Container(
                alignment: FractionalOffset.center,
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorResource.COLOR_APP_BTN),
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                child: Text(
                  StringResource.ADD_STUDENT.tr(),
                  style: CustomStyle.size14w500white(),
                )),
          )
        ],
      ),
    );
  }

  static Widget addUserBtn(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
          alignment: FractionalOffset.center,
          height: 40,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResource.COLOR_APP_BTN),
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: Text(
            StringResource.ADD_STUDENT.tr(),
            style: CustomStyle.size14w500white(),
          )),
    );
  }
}
