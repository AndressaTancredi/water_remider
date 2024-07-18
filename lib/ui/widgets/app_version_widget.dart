import 'package:flutter/cupertino.dart';
import 'package:hydrate_me/utils/app_metadata.dart';
import 'package:hydrate_me/utils/injection_container.dart';

class AppVersionWidget extends StatelessWidget {
  const AppVersionWidget({super.key});

  TextStyle get textVersionStyle => const TextStyle(
        fontFamily: "DMSans",
        fontWeight: FontWeight.w400,
        color: Color(0xff707070),
        fontStyle: FontStyle.normal,
        fontSize: 12,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("VERSÃO DO APLICATIVO", style: textVersionStyle),
          FutureBuilder<String>(
              future: sl<AppMetadata>().versionNumber(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(
                    'APP v${snapshot.data}',
                    style: textVersionStyle,
                  );
                } else {
                  return Container();
                }
              })
        ],
      ),
    );
  }
}
