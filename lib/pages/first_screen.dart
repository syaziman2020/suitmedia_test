import 'package:flutter/material.dart';
import 'package:suitmedia_app/pages/second_screen.dart';
import 'package:suitmedia_app/shared/theme.dart';

class FirstScreen extends StatelessWidget {
  FirstScreen({super.key});
  final TextEditingController nameC = TextEditingController();
  final TextEditingController palindromeC = TextEditingController();

  bool checkPalindrome(String str) {
    return str.toLowerCase() == str.toLowerCase().split('').reversed.join();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget header() {
      return Column(
        children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          Container(
            width: size.width * 0.3,
            height: size.width * 0.3,
            decoration: BoxDecoration(
                color: whiteC.withOpacity(0.5), shape: BoxShape.circle),
            child: const Center(
              child: Icon(
                Icons.person_add,
                size: 30,
                color: whiteC,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.08,
          ),
        ],
      );
    }

    Widget inputForm() {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 22),
            width: double.infinity,
            decoration: BoxDecoration(
              color: whiteC,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  controller: nameC,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Name',
                    hintStyle: greyTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: whiteC,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                child: TextFormField(
                  controller: palindromeC,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Palindrome',
                    hintStyle: greyTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.07,
          ),
        ],
      );
    }

    Widget buttons() {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Palindrome Status', style: blackTextStyle),
                    content: checkPalindrome(palindromeC.text)
                        ? Text(
                            'isPalindrome',
                            style: blackTextStyle,
                          )
                        : Text(
                            'not palindrome',
                            style: blackTextStyle,
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
                'CHECK',
                style: whiteTextStyle.copyWith(fontWeight: medium),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (nameC.text.isNotEmpty &&
                    nameC.text.split(' ').join() != '') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondScreen(
                        name: nameC.text,
                      ),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('There is an error', style: blackTextStyle),
                      content: Text(
                        'Sorry, name cannot be empty',
                        style: blackTextStyle,
                      ),
                    ),
                  );
                }
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
                'NEXT',
                style: whiteTextStyle.copyWith(fontWeight: medium),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.cyan, Colors.purple],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              header(),
              inputForm(),
              buttons(),
            ],
          ),
        ),
      ),
    );
  }
}
