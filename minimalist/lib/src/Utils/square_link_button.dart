import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SquareLinkButton extends StatefulWidget {

  final String url;
  final String assetLink;
  final Color iconColor;
  
  const SquareLinkButton({
    super.key,
    required this.url,
    required this.assetLink,
    required this.iconColor,
  });

  @override
  State<SquareLinkButton> createState() => _SquareLinkButtonState();
}

class _SquareLinkButtonState extends State<SquareLinkButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        launchUrl(Uri.parse(widget.url))
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            widget.assetLink,
            color: widget.iconColor,
            width: 40,
            height: 40,
          ),
        ),
      ),
    );
  }
}