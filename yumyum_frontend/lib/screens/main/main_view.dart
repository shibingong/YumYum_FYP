import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:yumyumfyp/app/dependencies.dart';
import 'package:yumyumfyp/screens/main/main_viewmodel.dart';
import 'package:yumyumfyp/widgets/custom_button.dart';

import '../view.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main';
  static MaterialPageRoute createRoute() =>
      MaterialPageRoute(builder: (_) => MainScreen());
  @override
  Widget build(BuildContext context) {
    return ConsumerView(
      viewmodel: dependency<MainViewModel>()..init(),
      builder: (context, viewmodel, _) => Scaffold(
        backgroundColor: Colors.white,
        body: viewmodel.busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: YoutubePlayer.convertUrlToId(
                          "https://www.youtube.com/watch?v=KRaWnd3LJfs"), //Add videoID.
                      flags: YoutubePlayerFlags(
                        hideControls: false,
                        controlsVisibleAtStart: true,
                        autoPlay: false,
                        mute: false,
                      ),
                    ),
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.amber,
                  ),
                  SizedBox(
                    height: 300,
                  ),
                  Center(
                    child: CustomButton(
                      text: 'Get Nutrition',
                      onPressed: () async {
                        await viewmodel.getNutrition("beef, tomato");
                      },
                    ),
                  ),
                  Center(
                    child: CustomButton(
                      text: 'Log Out',
                      onPressed: viewmodel.logOut,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
