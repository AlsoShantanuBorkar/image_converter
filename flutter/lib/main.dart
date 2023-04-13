import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_conversion/base64Sting.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ImageToString());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
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
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class StringToImage extends StatefulWidget {
  const StringToImage({super.key});

  @override
  State<StringToImage> createState() => _StringToImageState();
}

class _StringToImageState extends State<StringToImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.memory(
          base64Decode(base64String),
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}

class ImageToString extends StatefulWidget {
  const ImageToString({super.key});

  @override
  State<ImageToString> createState() => _ImageToStringState();
}

class _ImageToStringState extends State<ImageToString> {
  File? _imageFile;
  String? _base64String;

  Future<void> getImage(ImageSource imageSource) async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? pickedFile = await imagePicker.pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        log("No Image Selected  ");
      }
    });
  }

  Future<void> convertImage() async {
    if (_imageFile != null) {
      List<int> imageBytes = await _imageFile!.readAsBytes();
      setState(() {
        _base64String = base64Encode(imageBytes);
        log(_base64String.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_imageFile != null)
              Image.file(
                _imageFile!,
                height: 150.0,
              )
            else
              const Icon(
                Icons.image,
                size: 150.0,
              ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: const Text('Take a picture'),
              onPressed: () async {
                await getImage(ImageSource.camera);
              },
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              child: const Text('Choose from gallery'),
              onPressed: () async {
                await getImage(ImageSource.gallery);
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                await convertImage();
              },
              child: const Text('Convert Image'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StringToImage(),
                  ),
                );
              },
              child: const Text('Convert String to Image'),
            ),
          ],
        ),
      ),
    );
  }
}
