import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

//Should be future, because working with user profiles tends to be asynchronous operations.
Future<void> main() async {
  // Create a instance of the Stream client
  final client = StreamChatClient(, logLevel: Level.INFO);
  // Set the user for the application
  await client.connectUser(
    User(
      id: 'esra',
      extraData: {
        'image':
            'https://getstream.io/random_png/?id=restless-art-2&amp;name=Restless+art',
      },
    ),
    //Token String
  );
  final channel = client.channel('messaging', id: 'flutter_devs');
  channel.watch();
  runApp(MyApp(client));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final StreamChatClient client;
  MyApp(this.client, {Key? key}) : super(key: key);
  // New

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        return StreamChat(
          child: widget,
          client: client,
        );
      },
      home: ChannelListPage(),
    );
  }
}

class ChannelListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChannelsBloc(
        child: ChannelListView(
          // filter: {
          //   'members': {
          //     '\$in': [StreamChat.of(context).user?.id],
          //   }
          // },
          sort: [SortOption('last_message_at')],
          pagination: PaginationParams(
            limit: 20,
          ),
          channelWidget: ChannelPage(),
        ),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChannelHeader(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MessageListView(),
          ),
          MessageInput(),
        ],
      ),
    );
  }
}
