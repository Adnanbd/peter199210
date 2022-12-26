import 'dart:math';
import 'dart:ui';

import 'package:calendar_page/utils/global.dart';
import 'package:calendar_page/utils/shared_pref.dart';
import 'package:calendar_page/widgets/dummy_text_block.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:simple_shadow/simple_shadow.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;

  LifecycleEventHandler({required this.resumeCallBack});

  @override
  Future<Null> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
    }
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _random = Random();

  bool isLoading = true;

  int randIndex(int x) {
    var temp = 0;
    do {
      temp = 0 + _random.nextInt(43 - 0);
    } while (temp == x);
    return temp;
  }

  DateTime currentDate = DateTime.now();
  int? indexMM;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.

      _refreshContent();
    });

    WidgetsBinding.instance.addObserver(
        LifecycleEventHandler(resumeCallBack: () async => _refreshContent()));
  }

  void _refreshContent() {
    SharedPref sharedPref = SharedPref();
    print("START");
    setState(() {
      var now = DateTime.now();

      // Today

      sharedPref.getPrevIndex().then((value) {
        if (value != null) {
          indexMM = value;
          print(">>>>>INDEX FOUND -> $indexMM<<<<<<");
        } else {
          var v = randIndex(100);
          sharedPref.saveCurrentIndex(v);
          indexMM = v;
          print(">>>>>INDEX NOT FOUND - NEW ASSIGNES => $v<<<<<<");
        }
      });

      sharedPref.getPrevDate().then((value) {
        if (value != null) {
          print(">>>>>DATE FOUND -> $value<<<<<<");
          if (value != now.day.toString()) {
            var v = randIndex(indexMM ?? 100);
            sharedPref.saveCurrentIndex(v);
            indexMM = v;
            sharedPref.saveCurrentDate(now.day.toString());
            print(">>>>>DATE NOT MATCHED -> NEW DAY COME -> $indexMM<<<<<<");
          } else {
            print(">>>>>DATE MATCHED -> SAME DAY");
          }
        } else {
          sharedPref.saveCurrentDate(now.day.toString());
          print(">>>>>DATE NOT FOUND -> ${now.day.toString()}<<<<<<");
        }
      });

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, grad1Color])),
      child: isLoading
          ? Center(
              child: Container(
                height: 150,
                width: 150,
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(120),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(60, 10, 10, 10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                            color: secondaryColor,
                          ),
                          child: SvgPicture.asset(
                            "assets/menu-icon.svg",
                            height: 35,
                            width: 35,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Image.asset(
                          "assets/side-icon1.png",
                          height: 35,
                          width: 35,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Hello, Moodly!",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    //A great day to change your mood
                    Text(
                      "A great day to change your mood",
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: textColorSecondary),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 100,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white.withOpacity(.8),
                      ),
                      child: ListView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) {
                            DateTime tempDate =
                                currentDate.add(Duration(days: index));
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              padding: EdgeInsets.symmetric(
                                  horizontal: index == 0 ? 10 : 11,
                                  vertical: 5),
                              decoration: BoxDecoration(
                                color: index == 0
                                    ? cardFillColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: index == 0
                                      ? borderColor
                                      : const Color(0xFFE4E4E4),
                                  width: 2.2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  index == 0
                                      ? SimpleShadow(
                                          child: Image.asset(
                                              smileysList[indexMM ?? 0]),
                                          opacity: 0.6, // Default: 0.5
                                          color: Colors.black.withOpacity(
                                              .3), // Default: Black
                                          offset: Offset(
                                              0, 5), // Default: Offset(2, 2)
                                          sigma: 3, // Default: 2
                                        )
                                      : Container(),
                                  index == 0
                                      ? Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 25,
                                          width: 1.2,
                                          color: Colors.black,
                                        )
                                      : Container(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat('E')
                                            .format(tempDate)
                                            .substring(0, 2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: textColorSecondary,
                                                height: 1.3),
                                      ),
                                      Text(
                                        DateFormat('d').format(tempDate),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: textColorSecondary,
                                                height: 1.3),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          })),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white.withOpacity(.35),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SimpleShadow(
                                child: Image.asset(
                                  "assets/main-fig.png",
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.contain,
                                ),
                                opacity: 0.6, // Default: 0.5
                                color: Colors.black
                                    .withOpacity(.2), // Default: Black
                                offset: Offset(0, 5), // Default: Offset(2, 2)
                                sigma: 2, // Default: 2
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Text1",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "Text2",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                            fontWeight: FontWeight.w400,
                                            height: 2),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: DummyTextBlock(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
