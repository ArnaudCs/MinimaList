import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minimalist/services/task_service.dart';
import 'package:minimalist/src/Utils/square_link_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'settings_controller.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final TaskService _taskService = TaskService();
  int completedTaskCount = 0;

  @override
  void initState() {
    super.initState();
    _loadCompletedTaskCount(); 
  }

  Future<void> _loadCompletedTaskCount() async {
    int count = await _taskService.getCompletedTaskCount();
    setState(() {
      completedTaskCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.brightness_6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Theme Mode',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Serif',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  DropdownButton<ThemeMode>(
                    underline: Container(),
                    dropdownColor: Theme.of(context).cardColor,
                    value: widget.controller.themeMode,
                    onChanged: widget.controller.updateThemeMode,
                    enableFeedback: true,
                    items: const [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text(
                          'System Theme',
                          style: TextStyle(
                            fontFamily: 'Serif',
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text(
                          'Light Theme',
                          style: TextStyle(
                            fontFamily: 'Serif',
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text(
                          'Dark Theme',
                          style: TextStyle(
                            fontFamily: 'Serif',
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.emoji_events,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Completed Tasks',
                        style: TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      completedTaskCount.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Serif',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.coffee,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Row(
                          children: [
                            Text(
                              'Buy me a coffee',
                              style: TextStyle(
                                fontFamily: 'Serif',
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.recommend),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'If you like this app, consider supporting me by buying me a coffee. Your support will help me continue to improve this app and create more useful apps in the future.',
                          style: TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.screen_share_outlined,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Row(
                          children: [
                            Text(
                              'Stay connected, follow me ',
                              style: TextStyle(
                                fontFamily: 'Serif',
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.public, color: Colors.grey),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SquareLinkButton(
                            url: 'https://arnaudcs.github.io', 
                            assetLink: 'lib/assets/globe.svg', 
                            iconColor: Colors.white
                          ),
                          SquareLinkButton(
                            url: 'https://github.com/ArnaudCs', 
                            assetLink: 'lib/assets/github.svg', 
                            iconColor: Colors.white
                          ),
                          SquareLinkButton(
                            url: 'https://www.linkedin.com/in/arnaudcs/', 
                            assetLink: 'lib/assets/linkedin.svg', 
                            iconColor: Colors.white
                          )
                        ],
                      )
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.mail_outline_rounded,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'A problem or suggestion?',
                        style: TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse('mailto:arnaud.cossu@gmail.com?subject=Minimalist%20App%20Feedback'));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Contact Us',
                          style: TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Minimalist v1.0.0',
                style: TextStyle(
                  fontFamily: 'Serif',
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
