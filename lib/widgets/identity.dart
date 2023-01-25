import 'package:flutter/material.dart';

import '../shared/theme.dart';

class Identity extends StatelessWidget {
  final String name;
  final String email;
  final String url;
  final Function() onTap;
  const Identity({
    super.key,
    required this.name,
    required this.email,
    required this.url,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: FadeInImage(
                        width: 49,
                        height: 49,
                        placeholder: const AssetImage('assets/person.png'),
                        image: NetworkImage(url),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        email,
                        style: blackTextStyle.copyWith(
                          fontSize: 10,
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider()
            ],
          )
        ],
      ),
    );
  }
}
