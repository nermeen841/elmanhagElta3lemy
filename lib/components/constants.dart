import 'package:cached_network_image/cached_network_image.dart';
import 'package:elmanhag_app/components/size_config.dart';
import 'package:elmanhag_app/homeScreen/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:html/parser.dart';

import '../search_class.dart';

const kPrimaryColor = Color(0x2972B7);
const kGreenColor = Color(0x03AB6A);
const kLightGreenColor = Color(0x099861);
const kGreyColor = Color(0x898A8D);
const kWhitecardColor = Color(0xF5F5F5);
const kprimaryLightColor = Color(0x0090CF);
const kFavouriteColor = Color(0xAB0D03);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontFamily: 'Khebrat Musamim',
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

final subheadingStyle = TextStyle(
  fontFamily: 'Khebrat Musamim',
  fontWeight: FontWeight.w400,
  color: Colors.grey,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "من فضلك ادخل بريدك الالكتروني";
const String kInvalidEmailError = "هذا البريد الالكتروني غير صالح";
const String kNamelNullError = "من فضلك قم بادخال الاسم";
const String kPhoneNumberNullError = "من فضلك قم بادخال رقم الهاتف";
const String kPhoneErrorval = "هذ الرقم غير صحيح";
const String kMessageErrorval = "اكتب رسالتك";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    // borderSide: BorderSide(color: kTextColor),
  );
}

spaceH(double height) {
  return SizedBox(height: height);
}

spaceW(double width) {
  return SizedBox(width: width);
}

////////////////////////
homeBottomSheet({context, child}) {
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(5), topLeft: Radius.circular(5)),
    ),
    isDismissible: true,
    context: context,
    builder: (context) => child,
  );
}

// ignore: non_constant_identifier_names
Widget Loading() {
  return Center(
    child: CupertinoActivityIndicator(
      radius: 17,
      animating: true,
    ),
  );
}

///////////////////////////////////////////////////////////////////////////////

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

////////////////////////////////////////////////////////////

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;
  return parsedString;
}

/////////////////////////////////////////////////////////////////
customCachedNetworkImage(
    {required String url,
    required context,
    required BoxFit fit,
    required String title}) {
  try {
    // ignore: unnecessary_null_comparison
    if (url == null || url == "") {
      return Container(
        child: Image.asset(
          "assets/images/logo2021.png",
          height: 100,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.contain,
        ),
      );
    } else {
      return Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        child: (Uri.parse(url).isAbsolute)
            ? CachedNetworkImage(
                imageUrl: url,
                fit: fit,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) {
                  return Column(
                    textDirection: TextDirection.rtl,
                    children: [
                      Image.asset(
                        "assets/images/logo2021.png",
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: headingStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: HexColor("#323232")),
                      )
                    ],
                  );
                })
            : Column(
                textDirection: TextDirection.rtl,
                children: [
                  Image.asset(
                    "assets/images/logo2021.png",
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    title,
                    style: headingStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
      );
    }
  } catch (e) {
    print(e.toString());
  }
}
/////////////////////////////////////////////////////////////////////////////////////

Future<void> showMyDialog(
    {required BuildContext context,
    required String title,
    required Widget data}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        title: data,
      );
    },
  );
}
/////////////////////////////////////////////////////////

customeAppbar({required BuildContext context, required VoidCallback press}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    elevation: 0.0,
    title: InkWell(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      },
      child: Image.asset(
        "assets/images/logo2021-2.png",
        width: 130,
        height: 60,
        fit: BoxFit.contain,
      ),
    ),
    actions: [
      IconButton(
          onPressed: () {
            showSearch(context: context, delegate: LessonpapersSearch());
          },
          icon: Icon(
            Icons.search,
            color: Colors.black,
            size: 35,
          )),
      IconButton(
          onPressed: press,
          icon: Icon(
            Icons.format_align_justify,
            color: Colors.black,
            size: 30,
          )),
    ],
  );
}
