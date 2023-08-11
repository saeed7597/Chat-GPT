
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:iran_gpt/core/services/service_locator.dart';
import 'package:iran_gpt/features/mian/domain/entites/save_data_entity.dart';

import 'package:iran_gpt/features/mian/presentation/pages/home_screen.dart';

void main()async{
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();

  ServiceLocator.init();
  Hive.registerAdapter(SaveDataEntityAdapter());
  await Hive.openBox("saveData");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat GPT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
          // RemoteDataSourceImpl remoteDataSourceImpl = RemoteDataSourceImpl();
          // final testApp = MainParamsDto('gpt-3.5-turbo',[Messages('user','hi')]);
          // final data = remoteDataSourceImpl.getAnswerOfTheQuestion(testApp);

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


// Future<void> getData() async {
//   final Dio  dio = Dio();
//   dio.options.headers['Content-Type']  = 'application/json';
//   dio.options.headers['Authorization'] = 'Bearer  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';
//   Data data = Data('gpt-3.5-turbo',[Messages('user','hi')]);
//
//   String json = jsonEncode(data);
//   print(json);
//
//   final response = await dio.post(
//       'https://api.openai.com/v1/chat/completions',
//       data: json
//   );
//   print(response.statusCode);
// }


// class Data {
//   final String model;
//   final List<Messages> messages;
//   Data(this.model,this.messages);
//
//   Map toJson() => {
//     'model' : model,
//     'messages' : messages
//   };
// }
//
// class Messages {
//   final String role;
//   final String content;
//   Messages(this.role,this.content);
//
//   Map toJson() => {'role':role, 'content' : content};
// }
