import 'package:agora_uikit/agora_uikit.dart';
import 'package:agora_uikit/models/agora_settings.dart';
import 'package:agora_uikit/models/agora_user.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const APP_ID = '2af01518a23a4f35a6098c9b50467e85';

const Token =
    '0066b462cbcdf254436ab726620f1edb93bIABuntCwp0/RdFu7vSGX7rKs7WOlQcs+nD6NrZ8Fhm5kUbIhF1sAAAAAEAD+bihbwWpMYQEAAQDCakxh';

class VideoCallPage extends StatefulWidget {
  final String channelName;
  const VideoCallPage({Key? key, required this.channelName}) : super(key: key);

  @override
  _VideoCallPageState createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  late String channelname;
  late AgoraClient client;
  late AgoraUser clients;
  late AgoraSettings settings;
  late Permission camera;
  @override
  void initState() {
    super.initState();

    setState(() {
      channelname = widget.channelName;

      // disablecamera();

      initialize(channelname);
    });
  }

  void initialize(String channelname) {
    client = AgoraClient(
      agoraChannelData: AgoraChannelData(
          muteAllRemoteVideoStreams: true, enableDualStreamMode: true),
      agoraConnectionData: AgoraConnectionData(
        appId: APP_ID,
        channelName: channelname,
      ),
      enabledPermission: [
        //RtcEngine.instance.muteLocalVideoStream(true)
        Permission.microphone,
        Permission.camera,
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    client.sessionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Agora UIKit'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                layoutType: Layout.floating,
                client: client,
                showAVState: true,
              ),
              AgoraVideoButtons(
                client: client,
                extraButtons: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        print(client.sessionController.timer.toString());
                      });
                    },
                    color: Colors.green,
                    child: Text('m'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
