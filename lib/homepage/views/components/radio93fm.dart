// ignore_for_file: avoid_print, deprecated_member_use, prefer_const_constructors, unused_element, sized_box_for_whitespace, prefer_typing_uninitialized_variables, constant_identifier_names, must_call_super, unused_local_variable, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

class HomePlayer extends StatefulWidget {
  @override
  _HomePlayerState createState() => _HomePlayerState();
}

class _HomePlayerState extends State<HomePlayer>
    with AutomaticKeepAliveClientMixin {
  static const int MAX_SAMPLES = 44100; // Ubah nilai sesuai kebutuhan Anda

  static String url = "https://play-93fm.madiunkota.go.id/live";

  late AudioSession session;

  List<double> audioSamples = []; // Data sampel audio
  final List<Color> colors = [
    Colors.red[900]!,
    Colors.green[900]!,
    Colors.blue[900]!,
    Colors.brown[900]!
  ];

  var duration;
  var phoneNumber = 'tel:+62351461817';
  final player = AudioPlayer();
  var position;
  late String profileLink = ""; // Deklarasikan profileLink di sini
  var urlWa =
      'https://wa.me/+6281556451817/?text=${Uri.encodeFull('Halo Radio Suara Madiun !')}';

  final List<int> visDurasi = [900, 700, 600, 800, 500];

  // final SiriWaveformController _controller =
  //     IOS9SiriWaveformController(); // Menambahkan SiriWaveController
  bool _isAudioPlaying = false;
  late Timer _timer;

// Tambahkan variabel _youtubeData

  @override
  void dispose() {
    player.dispose();
    // Panggil SystemChrome.setEnabledSystemUIOverlays dengan [SystemUiOverlay.values] untuk mengembalikan pengaturan overlay UI sistem

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // Show the system status bar
    _timer.cancel(); // Menghentikan timer

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // Show the system status bar
    _timer.cancel(); // Menghentikan timer

    super.dispose();
  }

  Future<void> initAudioSession() async {
    session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playback,
    ));
    session.interruptionEventStream.listen((event) {
      if (event.type == AudioInterruptionType.duck) {
        // Tangani pemutusan audio (misalnya saat panggilan telepon masuk)
        stopAudio();
      } else if (event.type == AudioInterruptionType.pause) {
        // Tangani pemulihan setelah pemutusan audio
      }
    });
  }

  @override
  void initState() {
    super.initState();
    SetUriPlay();
    playAudio();

    initAudioSession();

    // Mengunci orientasi layar ke mode potret
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]); // Show only the status bar

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]); // Show only the status bar

    // Mengecek status siaran langsung setiap 30 detik
  }

  @override
  bool get wantKeepAlive => true;

  // Implementasi fungsi fetchDataFromFirebase untuk mengambil data dari Firebase

  void loadAudioSamples() {
    final audioPlayer = player;

    // Pastikan audio player tidak null
    if (audioPlayer != null) {
      // Dapatkan stream posisi yang di-buffer dari audio player
      final bufferedPositionStream = audioPlayer.bufferedPositionStream;

      // Mendengarkan perubahan dalam stream posisi yang di-buffer
      bufferedPositionStream.listen((bufferedPosition) {
        // Lakukan sesuatu dengan bufferedPosition, misalnya konversi ke sampel audio
        // Kemudian tambahkan ke daftar sampel audio
        setState(() {
          // Tambahkan sampel audio ke dalam daftar
          audioSamples.add(bufferedPosition.inMilliseconds.toDouble());

          // Atau, Anda mungkin ingin membatasi jumlah sampel yang disimpan untuk mencegah memori berlebihan
          if (audioSamples.length > MAX_SAMPLES) {
            audioSamples.removeAt(
                0); // Hapus sampel tertua jika jumlah sampel melebihi batas maksimum
          }
        });
      });
    }
  }

  void updateVisualPosition(Duration bufferPosition) {
    setState(() {});
  }

  double calculateVisualPosition(Duration bufferPosition) {
    return bufferPosition.inMilliseconds.toDouble();
  }

  // void setWaveAmplitude(double volume) {
  //   // Map nilai volume dari rentang 0-1 ke rentang 0-100
  //   var amplitudeValue = volume * 100;
  //   _controller.amplitude =
  //       amplitudeValue; // Gunakan controller yang disediakan
  // }

  Future<void> SetUriPlay() async {
    duration = await player.setUrl(url);
  }

  Future<void> playAudio() async {
    if (!_isAudioPlaying) {
      // Periksa apakah audio tidak sedang diputar
      await player.play();
      setState(() {
        _isAudioPlaying = true; // Atur status pemutaran audio menjadi true
      });
    }
  }

  void stopAudio() {
    if (_isAudioPlaying) {
      // Periksa apakah audio sedang diputar
      player.stop();
      setState(() {
        _isAudioPlaying = false; // Atur status pemutaran audio menjadi false
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AudioPlayerWidget(
      player: player,
      audioSamples: audioSamples,
      updateVisualPosition: updateVisualPosition,
      isPlaying:
          _isAudioPlaying, // Pass the audio playing status to AudioPlayerWidget
      playAudio: playAudio, // Pass the playAudio method to AudioPlayerWidget
      stopAudio: stopAudio, // Pass the stopAudio method to AudioPlayerWidget
    );
  }
}

class AudioPlayerWidget extends StatefulWidget {
  AudioPlayerWidget({
    Key? key,
    required this.player,
    required this.audioSamples,
    required this.updateVisualPosition,
    required this.isPlaying,
    required this.playAudio,
    required this.stopAudio,
  }) : super(key: key);

  final List<double> audioSamples;
  final bool isPlaying; // Tambahkan properti untuk status pemutaran audio
  final VoidCallback playAudio; // Tambahkan properti untuk metode playAudio
  final AudioPlayer player;
  final VoidCallback stopAudio; // Tambahkan properti untuk metode stopAudio
  final void Function(Duration) updateVisualPosition;

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  double _amplitude = 0.0;
  // final SiriWaveformController _controller = IOS9SiriWaveformController();
  bool _isPlaying = false;
  String _nowPlayingTitle = '';
  late Timer _timerPlaying;

  Future<void> fetchNowPlayingTitle() async {
    try {
      final response = await http
          .get(Uri.parse('https://play-93fm.madiunkota.go.id/status-json.xsl'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final title = data['icestats']['source'][1]
            ['title']; // Ambil judul lagu dari sumber kedua
        setState(() {
          _nowPlayingTitle = title; // Perbarui judul lagu yang sedang diputar
        });
      } else {
        throw Exception('Failed to fetch now playing title');
      }
    } catch (error) {
      print('Error Pengambilan Data title: $error');
    }
  }

  @override
  void dispose() {
    widget.player.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // SiriWaveformController _controller = IOS9SiriWaveformController();

    widget.player.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed ||
          playerState.processingState == ProcessingState.idle) {
        setState(() {
          _isPlaying = false;
          // _updateAmplitude(0.0);
        });
      } else if (playerState.processingState == ProcessingState.ready ||
          playerState.processingState == ProcessingState.buffering ||
          playerState.processingState == ProcessingState.ready) {
        setState(() {
          _isPlaying = true;
          // _updateAmplitude(1.0);
        });
      }
    });
    fetchNowPlayingTitle();
    _timerPlaying = Timer.periodic(Duration(seconds: 40), (timer) {
      fetchNowPlayingTitle();

      print(
          '=====UPDATE NowPlaying====='); // Tambahkan pernyataan print di sini
    });
  }

  // void _updateAmplitude(double amplitude) {
  //   setState(() {
  //     _amplitude = amplitude;
  //     controller.amplitude = _amplitude;
  //   });
  // }

  // final controller = IOS9SiriWaveformController(
  //   amplitude: 0.5,
  //   speed: 0.15,
  // );

  void _togglePlayback() async {
    if (_isPlaying) {
      widget.stopAudio(); // Stop audio if it's playing
      setState(() {
        _isPlaying = false; // Update playback status
      });
    } else {
      widget.playAudio(); // Start audio if it's not playing
      setState(() {
        _isPlaying = true; // Update playback status
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: GestureDetector(
        onTap: () {
          if (_isPlaying) {
            widget.player.stop(); // Stop audio if it's playing
          } else {
            widget.player.play(); // Start audio if it's not playing
          }
        },
        child: Card(
          elevation: 2,
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/bannerlppl.png'), // Ganti dengan path gambar pattern Anda
                fit: BoxFit.contain,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Container(
                      //   width: size.width *
                      //       0.5, // Ukuran lebar sesuai dengan parent (Expanded)
                      //   height: size.height * 0.02,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white.withOpacity(0.5),
                      //     borderRadius: BorderRadius.circular(5),
                      //   ),
                      //   child: Marquee(
                      //       text: _nowPlayingTitle.isNotEmpty
                      //           ? _nowPlayingTitle
                      //           : "-",
                      //       style: TextStyle(
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.w300,
                      //         color: Color.fromARGB(255, 0, 0, 0),
                      //       ),
                      //       blankSpace: 70,
                      //       velocity: 50,
                      //       scrollAxis: Axis.horizontal,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       showFadingOnlyWhenScrolling: true,
                      //       fadingEdgeStartFraction: 0.1,
                      //       fadingEdgeEndFraction: 0.1),
                      // ),
                      Container(
                        height: size.height * 0.1,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_isPlaying) {
                              widget.player
                                  .stop(); // Stop audio if it's playing
                            } else {
                              widget.player
                                  .play(); // Start audio if it's not playing
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 37, 71, 106),
                            shape: CircleBorder(),
                            elevation: 5,
                            padding: EdgeInsets.all(0.1),
                          ),
                          child: Container(
                            // decoration: BoxDecoration(
                            //   shape: BoxShape.rectangle,
                            //   boxShadow: [
                            //     BoxShadow(
                            //       color: Colors.black.withOpacity(0.5),
                            //       spreadRadius: 2,
                            //       blurRadius: 5,
                            //       offset: Offset(0, 2),
                            //     ),
                            //   ],
                            // ),
                            child: _isPlaying
                                ? Icon(Icons.pause,
                                    size: 50, color: Colors.white)
                                : Icon(Icons.play_circle_filled,
                                    size: 50, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width * 0.01,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
