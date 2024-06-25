import 'package:assets_audio_player/assets_audio_player.dart';

class SoundService {
  AssetsAudioPlayer assetPlayer = AssetsAudioPlayer.newPlayer();
  Future<void> playTapDownSound() async {
    // await assetPlayer.play(
    //   'mouse_click.mp3',
    //   mode: PlayerMode.LOW_LATENCY,
    // );
  }
}
