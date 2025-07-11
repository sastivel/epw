import 'dart:async';

import 'package:EPW_mobile/utils/common_imports.dart';
import 'package:flutter/material.dart';

abstract class BasePageScreen extends StatefulWidget {
  const BasePageScreen({Key? key}) : super(key: key);
}

abstract class BasePageScreenState<T extends BasePageScreen>
    extends State<T> {
  bool _isBack = true;
  bool _isHome = true;
  bool _isShowTitle = true;

  final _loadingController = StreamController<bool>();

  String appBarTitle();
  String appBarSubTitle();

  Widget body();


  void onClickBackButton();

  void onClickHome();

  void isBackButton(bool isBack) {
    _isBack = isBack;
  }

  void isHomeButton(bool isHome) {
    _isHome = isHome;
  }

  void isShowTitle(bool isShowTitle) {
    _isShowTitle = isShowTitle;
  }

  void showLoading() {
    _loadingController.add(true);
  }

  void hideLoading() {
    _loadingController.add(false);
  }
}

mixin BaseScreen<T extends BasePageScreen> on BasePageScreenState<T> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg_header.jpeg'),
                    fit: BoxFit.cover)),
          ),
          title: Column(
            children: [
              Visibility(
                visible: _isShowTitle,
                child: Text(
                  appBarTitle(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                appBarSubTitle(),
                maxLines: _isShowTitle ? 1 : 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          leading: _isBack
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // onClickBackButton();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/main", (Route<dynamic> route) => false);
                  },
                )
              : Container(),
          actions: [
            _isHome
                ? IconButton(
                    icon: const Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      onClickHome();
                    },
                  )
                : Container()
          ],
        ),
        body: SwitchCaseWidget<BaseState>(
            activeState: LoadingWidgetCase(),
            stateBuilder: (BaseState? value) {
              if (value is LoadingWidgetCase) {
                return const CircularProgressIndicator();
              }
              if (value is ErrorWidgetCase) {
                return Text(
                  value.message,
                  style: const TextStyle(color: Colors.red, fontSize: 30),
                );
              }
              if (value is DataLoadedCase) {
                return body();
              }
              //default case
              return null;
            }));
  }

  Widget _buildLoader() {
    return Container(
      color: Colors.black54,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    _loadingController.close();
    super.dispose();
  }
}

abstract class BaseState {}

class LoadingWidgetCase extends BaseState {}

class ErrorWidgetCase extends BaseState {
  final String message;
  ErrorWidgetCase({required this.message});
}

class DataLoadedCase extends BaseState {
  List<int> data = List.generate(12, (index) => index);
}

class SwitchCaseWidget<T> extends StatelessWidget {
  final Widget? Function(T? t) stateBuilder;
  final T activeState;

  const SwitchCaseWidget({
    super.key,
    required this.stateBuilder,
    required this.activeState,
  });

  @override
  Widget build(BuildContext context) {
    return stateBuilder(activeState) ?? const SizedBox.shrink();
  }
}
