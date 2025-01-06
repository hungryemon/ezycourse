import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

import 'asset_constants.dart';

class AppConstant {
  
  static List gradientsColor = const [
    LinearGradient(
      begin: Alignment(-1.0, 0.0),
      end: Alignment(1.0, 0.0),
      transform: GradientRotation(90),
      colors: [
        Color(0xFFFFFFFF),
        Color(0xFFFFFFFF),
      ],
    ),
    LinearGradient(
      begin: Alignment(-1.0, 0.0),
      end: Alignment(1.0, 0.0),
      transform: GradientRotation(90),
      colors: [
        Color(0xFFff00ea),
        Color(0xFFff7300),
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      transform: GradientRotation(-135),
      colors: [
        Color.fromRGBO(72, 229, 169, 1),
        Color.fromRGBO(143, 199, 173, 1),
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(116, 167, 126, 1),
        Color.fromRGBO(24, 175, 78, 1),
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFff7f11),
        Color(0xFFff7f11),
      ],
    ),
    LinearGradient(
      begin: Alignment(-1.0, 0.0),
      end: Alignment(1.0, 0.0),
      transform: GradientRotation(90),
      colors: [
        Color(0xFF00ffe1),
        Color(0xFFe9ff42),
      ],
    )
  ];

  static List feedBackGroundGradientColors = [
    "{\"backgroundImage\":\"linear-gradient(90deg, rgb(255, 255, 255) 0%, rgb(255, 255, 255) 100%)\"}",
    "{\"backgroundImage\":\"linear-gradient(45deg, rgb(255, 115, 0) 0%, rgb(255, 0, 234) 100%)\"}",
    "{\"backgroundImage\":\"linear-gradient(135deg, rgb(143, 199, 173), rgb(72, 229, 169))\"}",
    "{\"backgroundImage\":\"linear-gradient(135deg, rgb(116, 167, 126), rgb(24, 175, 78))\"}",
    "{\"backgroundImage\":\"linear-gradient(45deg, rgb(255, 127, 17) 0%, rgb(255, 127, 17) 100%)\"}",
    "{\"backgroundImage\":\"linear-gradient(45deg, rgb(233, 255, 66) 0%, rgb(0, 255, 225) 100%)\"}"
  ];

  static List<Reaction<String>?> reactionList = [
    Reaction<String>(
      value: 'LIKE',
      icon: Image.asset(AssetConstants.likeGif),
    ),
    Reaction<String>(
      value: 'LOVE',
      icon: Image.asset(AssetConstants.loveGif),
    ),
    Reaction<String>(
      value: 'HAHA',
      icon: Image.asset(AssetConstants.hahaGif),
    ),
    Reaction<String>(
      value: 'WOW',
      icon: Image.asset(AssetConstants.wowGif),
    ),
    Reaction<String>(
      value: 'SAD',
      icon: Image.asset(AssetConstants.sadGif),
    ),
    Reaction<String>(
      value: 'ANGRY',
      icon: Image.asset(AssetConstants.angryGif),
    ),
  ];
}