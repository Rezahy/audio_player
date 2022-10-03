import 'dart:async';
import 'dart:ui';

import 'package:audio_player_app/widgets/favorite_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AudioPlayer audioPlayer;
  Duration? duration;
  Timer? timer;

  @override
  void initState() {
    audioPlayer = AudioPlayer();
    audioPlayer.setAsset('assets/sounds/The Shadow of Venus.mp3').then((value) {
      duration = value;
      audioPlayer.play();
      setState(() {});
    });
    timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (audioPlayer.position.inSeconds == duration!.inSeconds) {
        if (audioPlayer.playing) {
          audioPlayer.pause();
        }
      }

      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/apocalyptica.jpeg',
                    ),
                    fit: BoxFit.cover),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 30, sigmaX: 30),
                child: Container(
                  color: Colors.black26,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/band.jpg',
                          width: 60,
                          height: 60,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Apocalyptica',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              '@apocalyptica',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      const FavoriteIconButton()
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'assets/images/apocalyptica.jpeg',
                            fit: BoxFit.cover,
                            width: size.width * 0.7,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              'The Shadow of Venus',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Text(
                              'Apocalyptica',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            if (duration != null)
                              Slider(
                                inactiveColor: Colors.white12,
                                activeColor: Colors.white,
                                max: duration!.inMilliseconds.toDouble() + 1500,
                                min: 0,
                                value: audioPlayer.position.inMilliseconds
                                    .toDouble(),
                                onChanged: (newValue) {
                                  audioPlayer.seek(
                                      Duration(milliseconds: newValue.toInt()));
                                },
                                onChangeStart: (value) {
                                  audioPlayer.pause();
                                },
                                onChangeEnd: (value) {
                                  audioPlayer.play();
                                },
                              ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    audioPlayer.position.toMinutesSecond(),
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  if (duration != null)
                                    Text(
                                      duration!.toMinutesSecond(),
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    var currentPosition = audioPlayer.position;

                                    if (currentPosition.inSeconds > 5) {
                                      audioPlayer.seek(Duration(
                                          seconds:
                                              currentPosition.inSeconds - 5));
                                    }
                                  },
                                  onLongPress: () {
                                    var currentPosition = audioPlayer.position;
                                    if (currentPosition.inSeconds > 10) {
                                      audioPlayer.seek(Duration(
                                          seconds:
                                              currentPosition.inSeconds - 10));
                                    }
                                  },
                                  child: const Icon(
                                    CupertinoIcons.backward_fill,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (audioPlayer.playing) {
                                      audioPlayer.pause();
                                    } else {
                                      audioPlayer.play();
                                    }
                                  },
                                  child: Icon(
                                    audioPlayer.playing
                                        ? CupertinoIcons.pause_circle_fill
                                        : CupertinoIcons.play_circle_fill,
                                    color: Colors.white,
                                    size: 56,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    var currentPosition = audioPlayer.position;
                                    if (!(currentPosition.inSeconds >
                                        duration!.inSeconds - 5)) {
                                      audioPlayer.seek(Duration(
                                          seconds:
                                              currentPosition.inSeconds + 5));
                                    }
                                  },
                                  onLongPress: () {
                                    var currentPosition = audioPlayer.position;
                                    if (!(currentPosition.inSeconds >
                                        duration!.inSeconds - 10)) {
                                      audioPlayer.seek(Duration(
                                          seconds:
                                              currentPosition.inSeconds + 10));
                                    }
                                  },
                                  child: const Icon(
                                    CupertinoIcons.forward_fill,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension DurationExtensions on Duration {
//  converts the duration into a readable string
//05:15
  String toHoursMinutes() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    return '${_toTwoDigits(inHours)}:$twoDigitMinutes}';
  }

  //  converts the duration into a readable string
//05:15:10

  String toHoursMinutesSeconds() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    String twoDigitSecond = _toTwoDigits(inSeconds.remainder(60));

    return '${_toTwoDigits(inHours)}:$twoDigitMinutes:$twoDigitSecond';
  }

  String toMinutesSecond() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = _toTwoDigits(inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  String _toTwoDigits(int n) {
    if (n >= 10) {
      return '$n';
    }
    return '0$n';
  }
}
