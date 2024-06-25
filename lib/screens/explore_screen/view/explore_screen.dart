import 'package:EPW_mobile/screens/exam/view/exam_screen.dart';
import 'package:EPW_mobile/screens/home/bloc/home_bloc.dart';

import '../../../utils/common_imports.dart';
import '../../../utils/image_resource.dart';
import '../../base/state/base_hook_consumer_widget.dart';

class ExploreScreen extends BaseHookWidget {
  HomeScreenBloc? homeScreenBloc;
  ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     Future.delayed(const Duration(milliseconds: 1000), () {
 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ExamScreen()));
});
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage(ImageResource.APPBG4),
                  fit: BoxFit.fill,
                  alignment: Alignment.topCenter,
                ),
              ),
              child: Container(
                height: 100,
                width: 100,
                margin:  EdgeInsets.only(top: 0,left: MediaQuery.of(context).size.width/5,right:  MediaQuery.of(context).size.width/5,bottom: MediaQuery.of(context).size.width/5),
                child: Image.asset(ImageResource.EXPLORE_IMAGE,
                   
                
                ),
              ),
            )));
  }
}
