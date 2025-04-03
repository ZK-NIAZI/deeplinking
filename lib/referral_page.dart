import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ReferralPage extends StatefulWidget {
  final String? referralCode;
  const ReferralPage({Key? key, this.referralCode}) : super(key: key);

  @override
  _ReferralPageState createState() => _ReferralPageState();
}

class _ReferralPageState extends State<ReferralPage> {
  TextEditingController _referrerController = TextEditingController();
  String? _sharedReferralLink;

  @override
  void initState() {
    super.initState();
    if (widget.referralCode != null) {
      _sharedReferralLink = "https://www.speedforce.zeeshan/${widget.referralCode}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Referral Page")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _referrerController,
              decoration: InputDecoration(
                labelText: 'Your Referrer Code',
              ),
            ),
            SizedBox(height: 20),

            Text(
              "Referral Code: ${widget.referralCode ?? 'Not available'}",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (_sharedReferralLink != null) {
                  Share.share("Join using my referral link: $_sharedReferralLink");
                }
              },
              child: Text("Share Referral Link"),
            ),
          ],
        ),
      ),
    );
  }
}
