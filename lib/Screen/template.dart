import 'package:docscriberlite/Screen/Dashboard.dart';
import 'package:docscriberlite/Screen/infoPage.dart';
import 'package:docscriberlite/Screen/settingPage.dart';
import 'package:docscriberlite/crud/Get%20Patient/GetPatient.dart';
import 'package:docscriberlite/loginSingup/lgoinPage.dart';
import 'package:flutter/material.dart';

class Template extends StatefulWidget {
  const Template({Key? key}) : super(key: key);

  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top section for Company name
          // Left and right sections
          Expanded(
            child: Row(
              children: [
                // Left section (non-scrollable)
                SizedBox(
                  width: 50.0,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyIconButton(
                          icon: Icons.home,
                          onPressed: () {
                            _pageController.jumpToPage(0);
                          },
                        ),
                        MyIconButton(
                          icon: Icons.data_exploration,
                          onPressed: () {
                            _pageController.jumpToPage(1);
                          },
                        ),
                        MyIconButton(
                          icon: Icons.settings,
                          onPressed: () {
                            _pageController.jumpToPage(2);
                          },
                        ),
                        MyIconButton(
                          icon: Icons.info,
                          onPressed: () {
                            _pageController.jumpToPage(3);
                          },
                        ),
                        MyIconButton(
                          icon: Icons.logout,
                          onPressed: () {
                            _pageController.jumpToPage(4);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // Right section (scrollable)
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    children: [
                      const Dashboard(),
                       const GetPatient(),
                      DoctorSettingsPage(),
                        InfoPage(),
                      LoginPage()
                      // _buildPage("Log Out Under Construction"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(String pageName) {
    return Center(
      child: Text(
        pageName,
        style: const TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }
}

class MyIconButton extends StatelessWidget {
  final IconData icon;
  final Function()? onPressed;

  MyIconButton({
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10,),
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
        ),
      ],
    );
  }
}
