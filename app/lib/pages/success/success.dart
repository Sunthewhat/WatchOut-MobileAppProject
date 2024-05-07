import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFA8FFB4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 300.0),
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.asset('assets/images/success.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
