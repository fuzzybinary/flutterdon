import 'package:flutter/widgets.dart';

import '../mastodon/models.dart';

class PosterAvatar extends StatelessWidget {
  final Status status;

  const PosterAvatar({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    var mainPoster = status.account.avatarStatic;
    String? secondaryPoster;
    var mainPosterSize = const Size(50, 50);

    if (status.reblog != null) {
      secondaryPoster = mainPoster;
      mainPoster = status.reblog!.account.avatarStatic;
      mainPosterSize = const Size(35, 35);
    }

    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        children: [
          Positioned(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                mainPoster,
                width: mainPosterSize.width,
                height: mainPosterSize.height,
              ),
            ),
          ),
          if (status.reblog != null)
            Positioned(
              top: 20,
              left: 20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  secondaryPoster!,
                  width: 25,
                  height: 25,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
