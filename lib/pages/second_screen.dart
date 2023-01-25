import 'package:flutter/material.dart';
import 'package:suitmedia_app/pages/last_screen.dart';
import 'package:suitmedia_app/shared/theme.dart';

class SecondScreen extends StatelessWidget {
  final String? name;
  final String? selectedName;
  const SecondScreen({super.key, this.name, this.selectedName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteC,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: whiteC,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.blue,
          ),
        ),
        title: Text(
          'Second Screen',
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Welcome',
                  style: blackTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                Text(
                  '$name',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.32,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: (selectedName != null)
                      ? Text(
                          '$selectedName',
                          style: blackTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: semiBold,
                          ),
                        )
                      : Text(
                          'Selected User Name',
                          style: blackTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: semiBold,
                          ),
                        ),
                )
              ],
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(bottom: 32),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LastScreen(
                        name: name,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  backgroundColor: const Color.fromARGB(255, 38, 53, 136),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Choose a User',
                  style: whiteTextStyle.copyWith(fontWeight: medium),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
