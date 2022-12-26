import 'package:flutter/material.dart';

class DummyTextBlock extends StatelessWidget {
  const DummyTextBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        //mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Text(
            "Tex1",
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(fontWeight: FontWeight.w400),
          ),
          Text(
            "Text2",
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.w200,
                  height: 1,
                ),
          ),
          Text(
            "01",
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.w400,
                  height: 1.1,
                ),
          ),
          Expanded(child: Container()),
          Text(
            "Tex1",
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(fontWeight: FontWeight.w400),
          ),
          Text(
            "Text2",
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.w200,
                  height: 1,
                ),
          ),
          Text(
            "01",
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.w400,
                  height: 1.1,
                ),
          ),
        ],
      ),
    );
  }
}
