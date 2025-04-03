import 'package:app_links/app_links.dart';
import 'package:deeplinking/referral_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppLinks _appLinks = AppLinks();
  String? _deepLink;
  String? _referralCode;

  @override
  void initState() {
    super.initState();

    _appLinks.getInitialLink().then((link) {
      if (link != null) {
        _handleDeepLink("${link}");
      }
    });

    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri.toString());
      }
    });
  }

  void _handleDeepLink(String link) {
    setState(() {
      _deepLink = link;
      _referralCode = _extractReferralCode(link);
    });

    if (_referralCode != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReferralPage(referralCode: _referralCode),
          ),
        );
      });
    }
  }

  String? _extractReferralCode(String link) {
    const baseUrl = "https://www.speedforce.zeeshan/";
    if (link.startsWith(baseUrl)) {
      return link.substring(baseUrl.length);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Deep Link Example")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: _deepLink != null
                  ? Text("Link: $_deepLink")
                  : Text("No Link found"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReferralPage(referralCode: "112233"),
                  ),
                );
              },
              child: Text("Go to ReferralPage"),
            ),
          ],
        ),
      ),
    );
  }
}