// // import 'dart:html';

// import 'package:image_downloader_web/image_downloader_web.dart';
// import 'package:intl/intl.dart';
// import 'common_imports.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:universal_html/html.dart' as html;

// class AppUtils {
//   static final WebImageDownloader _webImageDownloader = WebImageDownloader();
//   static var dio = Dio();

//   static String getImageUrl(String url) {
//     final String baseUrl = ApiConstants.baseURL;
//     return baseUrl + url;
//   }

//   static String removeLastChar(String str) {
//     return removeLastChars(str, 1);
//   }

//   static String removeLastChars(String str, int chars) {
//     return str.substring(0, str.length - chars);
//   }

//   static String convertDate({
//     required String sourceDateStr,
//     required String from,
//     required String to,
//     bool? convert = true,
//   }) {
//     if (sourceDateStr.isNotEmpty) {
//       var fromDateFormat = DateFormat(from);
//       var toDateFormat = DateFormat(to);
//       var tempDate = fromDateFormat.parse(sourceDateStr);
//       if (convert == true) {
//         var offset = DateTime.now().timeZoneOffset;
//         var localDate = tempDate.add(offset);
//         return toDateFormat.format(localDate);
//       } else {
//         return toDateFormat.format(tempDate);
//       }
//     } else {
//       return StringResource.notAvailable;
//     }
//   }

//   static String getCurrentDateText() {
//     var dateFormat = DateFormat('yyyyMMddHHmmss');
//     return dateFormat.format(DateTime.now());
//   }

//   static imageDownloader({
//     required String imageUrl,
//     required String name,
//   }) async {
//     String baseUrl = ApiConstants.baseURL;
//     await _webImageDownloader.downloadImageFromWeb(
//       baseUrl + imageUrl,
//       name: name,
//     );
//   }

//   static pdfDownloader({
//     required String pdfUrl,
//     required String name,
//   }) async {
//     String baseUrl = ApiConstants.baseURL;
//     // AnchorElement anchorElement = AnchorElement(href: baseUrl + pdfUrl);
//     // anchorElement.download = baseUrl + pdfUrl;
//     html.window.open(baseUrl + pdfUrl, 'new tab');
//   }

//   static imageListDownloader({
//     required List<Images> imagesList,
//   }) async {
//     String baseUrl = ApiConstants.baseURL;
//     for (int i = 0; i < imagesList.length; i++) {
//       await _webImageDownloader.downloadImageFromWeb(
//         baseUrl + imagesList[i].imageUrl!,
//         name: "${imagesList[i].id}_${AppUtils.getCurrentDateText()}",
//       );
//     }
//   }

//   static getStatusInText({required int status}) {
//     if (status == 0) {
//       return StringResource.suspended;
//     }
//     if (status == 1) {
//       return StringResource.notApproved;
//     }
//     if (status == 2) {
//       return StringResource.open;
//     }
//     if (status == 3) {
//       return StringResource.quoteAccepted; //quote accepted
//     }
//     if (status == 4) {
//       return StringResource.inProgress;
//     }
//     if (status == 5) {
//       return StringResource.completed;
//     }
//     if (status == 6) {
//       return StringResource.cancelled;
//     }
//     if (status == 7) {
//       return StringResource.transfered;
//     }
//     return StringResource.notAvailable;
//   }

//   static getStatusInNum({required String status}) {
//     if (status == StringResource.suspended) {
//       return 0;
//     }
//     if (status == StringResource.notApproved) {
//       return 1;
//     }
//     if (status == StringResource.open) {
//       return 2;
//     }
//     if (status == StringResource.quoteAccepted) {
//       return 3;
//     }
//     if (status == StringResource.inProgress) {
//       return 4;
//     }
//     if (status == StringResource.completed) {
//       return 5;
//     }
//     if (status == StringResource.cancelled) {
//       return 6;
//     }
//     if (status == StringResource.transfered) {
//       return 7;
//     }
//     if (status == StringResource.all) {
//       return -1;
//     }
//     return 0;
//   }

//   static getPaymentStatusInText({required int status}) {
//     if (status == 0) {
//       return StringResource.suspended;
//     }
//     if (status == 1) {
//       return StringResource.notApproved;
//     }
//     if (status == 2) {
//       return StringResource.open;
//     }
//     if (status == 3 ||
//         status == 4 ||
//         status == 5 ||
//         status == 8 ||
//         status == 9 ||
//         status == 10 ||
//         status == 11) {
//       return StringResource.inProgress; //quote accepted
//     }
//     // if (status == 4) {
//     //   return StringResource.inProgress;
//     // }
//     // if (status == 5) {
//     //   return StringResource.inProgress;
//     // }
//     if (status == 6) {
//       return StringResource.cancelled;
//     }
//     if (status == 7) {
//       return StringResource.completed;
//     }
//     //   if (status == 8) {
//     //   return StringResource.inProgress;
//     // }
//     // if (status == 9) {
//     //   return StringResource.inProgress;
//     // }
//     // if (status == 10) {
//     //   return StringResource.inProgress;
//     // }
//     // if (status == 7) {
//     //   return StringResource.completed;
//     // }
//     return StringResource.notAvailable;
//   }

//   static getInquiryStatusInText({required int status}) {
//     // if (status == 0) {
//     //   return StringResource.notSupported;
//     // }
//     if (status == 1) {
//       return StringResource.inquiry_info_support;
//     }
//     if (status == 2) {
//       return StringResource.inquiry_info_complete;
//     }

//     return StringResource.notSupported;
//   }
// }

// extension CapExtension on String {
//   String get removeLastCharacter => AppUtils.removeLastChar(this);
// }

import 'package:EPW_mobile/utils/string_resource.dart';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../custome_widgets/custom_style.dart';
import 'common_imports.dart';

class AppUtils {
//  static bool isLoggedIn = false;

  static List<String> permissions = [];
  static final RegExp emailRegExp =
      RegExp(r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");

  static final RegExp mobNoRegEx =
      //RegExp(r'(/^([+]\d{2})?\d{10}$/)');
      // RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
      RegExp(
          r"^(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$");

  static final RegExp aadharExp = RegExp(r"^[0-9 ]*$");
  static final RegExp dobFormatterExp =
      RegExp(r'((?:19|20)\\d\\d)/(0?[1-9]|1[012])/([12][0-9]|3[01]|0?[1-9])');

  static String requiredErrorMsg({required String text}) {
    return "${text} is required";
  }

  static String invalidErrorMsg({required String text}) {
    return "$text is invalid";
  }

  static DateTime getDateFrom(String dateStr, String format) {
    DateFormat formatter = DateFormat(format);
    return formatter.parse(dateStr);
  }

  static String getStringFrom(DateTime dateTime, String format) {
    DateFormat formatter = DateFormat(format);
    return formatter.format(dateTime);
  }

  static DateTime getCurrentDateFormat(String format) {
    DateFormat formatter = DateFormat(format);
    return formatter.parse(DateTime.now().toString());
  }

  static Widget labelText({required String text, bool isMandatory = false}) {
    return Row(
      children: [
        Text(
          text,
          style: CustomStyle.size14w500grey(),
        ),
        isMandatory
            ? Text(
                '*',
                style: CustomStyle.buildRequiredField(),
              )
            : Container(),
      ],
    );
  }



  static String getErrorType(DioErrorType type) {
    switch (type) {
      case DioErrorType.cancel:
        return StringResource.dioException;
      case DioErrorType.connectTimeout:
        return StringResource.connectionTimeOut;
      case DioErrorType.other:
        return StringResource.dioException;
      case DioErrorType.receiveTimeout:
        return StringResource.receiveTimeout;
      case DioErrorType.response:
        return StringResource.responseError;
      case DioErrorType.sendTimeout:
        return StringResource.sendTimeout;
      default:
        return StringResource.dioException;
    }
  }

  static String getLocalDate(
    String? date, {
    bool? convert = true,
  }) {
    try {
      if (date != null) {
        var utcDate = DateTime.parse(date);
        DateFormat formatter = DateFormat('yyyy/MM/dd');
        if (convert == true) {
          if (utcDate.isUtc) {
            return formatter.format(utcDate.toLocal());
          } else {
            return formatter.format(utcDate);
          }
        } else {
          return formatter.format(utcDate);
        }
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  static String getEmpStatus(String? code) {
    switch (code) {
      case "CONTRACT":
        return "Contract";
      case "FULLTIME":
        return "Full Time";
      case "INTERN":
        return "Intern";
      case "SEPERATED":
        return "Separated";
      default:
        return "Full Time";
    }
  }

  static String getEmpRole(String? code) {
    switch (code) {
      case "HR":
        return "HR";
      case "PM":
        return "Project Manager";
      case "EMP":
        return "Employee";

      default:
        return "Employee";
    }
  }


  static DateTime getUTCDate({required String date}) {
    date = date.replaceAll('/', '-');
    return DateTime.parse(date).toUtc();
  }

  static int getEmpRoleID(String? code) {
    switch (code) {
      case "HR":
        return 1;
      case "PM":
        return 2;
      case "EMP":
        return 3;

      default:
        return 3;
    }
  }

  static String getEmpRoleCode(int? code) {
    switch (code) {
      case 1:
        return "HR";
      case 2:
        return "PM";
      case 3:
        return "EMP";

      default:
        return "EMP";
    }
  }
}

extension StringExtension on String? {
  String? isValid() {
    if (this != null) {
      return this!.isEmpty ? null : this!;
    } else {
      return null;
    }
  }
}
