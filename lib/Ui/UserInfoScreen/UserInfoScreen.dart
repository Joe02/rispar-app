import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:risparapp/Models/UserCredentials.dart';
import 'package:risparapp/Ui/Widgets/DefaultSubmitButton.dart';

import '../../strings.dart';
import '../CreditSelectionPager/CreditSelectionPager.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  UserInfoScreenState createState() => UserInfoScreenState();
}

class UserInfoScreenState extends State<UserInfoScreen> {
  late double screenWidth;
  late double screenHeight;
  late Orientation screenOrientation;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _nameValidation = true;
  bool _emailValidation = true;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    screenOrientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: buildScreenWidgets(),
          ),
        ),
      ),
    );
  }

  buildScreenWidgets() {
    List<Widget> widgetsList = [
      SizedBox(
        height: screenOrientation == Orientation.portrait ? 75 : 25,
      ),
      buildUserScreenImage(),
      SizedBox(
        height: screenOrientation == Orientation.portrait ? 40 : 10,
      ),
      buildUserScreenLabel(),
      SizedBox(
        height: screenOrientation == Orientation.portrait ? 10 : 0,
      ),
      buildUserScreenInput(
        userInfoNameFirstLabel,
        userInfoNameSecondLabel,
        userInfoNameHint,
        _nameController,
        _nameValidation,
        false,
      ),
      buildUserScreenInput(
        userInfoEmailFirstLabel,
        userInfoEmailSecondLabel,
        userInfoEmailHint,
        _emailController,
        _emailValidation,
        true,
      ),
      Padding(
        padding: const EdgeInsets.only(
          top: 40.0,
          bottom: 10.0,
        ),
        child: buildSubmitButton(),
      )
    ];

    return widgetsList;
  }

  buildUserScreenImage() {
    return SvgPicture.asset(
      'assets/images/user_info_image.svg',
      height: screenOrientation == Orientation.portrait
          ? screenHeight / 3.75
          : screenWidth / 3.75,
    );
  }

  buildUserScreenLabel() {
    return ListTile(
      title: RichText(
        text: const TextSpan(
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
              text: userInfoTitleLabel,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            TextSpan(
              text: userInfoSubTitleLabel,
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      subtitle: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        child: Text(
          userInfoDescriptionLabel,
        ),
      ),
    );
  }

  buildUserScreenInput(
    String? title,
    String? boldTitle,
    String inputHint,
    TextEditingController _controller,
    bool _validator,
    bool emailInput,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 25.0,
      ),
      child: ListTile(
        title: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text: title ?? "",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: boldTitle ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        subtitle: TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: inputHint,
            errorText: _validator
                ? null
                : emailInput
                    ? userInfoEmailError
                    : userInfoNameError,
          ),
          keyboardType:
              emailInput ? TextInputType.emailAddress : TextInputType.name,
        ),
      ),
    );
  }

  buildSubmitButton() {
    return DefaultSubmitButton(
      userInfoDefaultButtonLabel,
      null,
      null,
      null,
      const TextStyle(fontSize: 19),
      () {
        bool nameValidation = validateName();
        bool emailValidation = validateEmail();
        if (nameValidation && emailValidation) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => CreditSelectionPager(
                UserCredentials(
                  _nameController.text,
                  _emailController.text,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  validateName() {
    if (_nameController.text.length < 3 && _nameValidation) {
      setState(() {
        _nameValidation = false;
      });
      return false;
    } else if (_nameController.text.length >= 3 && _nameValidation == false) {
      setState(() {
        _nameValidation = true;
      });
      return true;
    }

    return _nameValidation;
  }

  validateEmail() {
    bool isEmailValid =
        EmailValidator.validate(_emailController.text, true, true);
    if (isEmailValid == true && _emailValidation == false) {
      setState(() {
        _emailValidation = true;
      });
      return true;
    } else if (isEmailValid == false && _emailValidation == true) {
      setState(() {
        _emailValidation = false;
      });
      return false;
    }

    return _emailValidation;
  }
}
