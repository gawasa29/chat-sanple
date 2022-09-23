import 'package:flutter/material.dart';

class SettingProfilePage extends StatefulWidget {
  const SettingProfilePage({Key? key}) : super(key: key);

  @override
  State<SettingProfilePage> createState() => _SettingProfilePageState();
}

class _SettingProfilePageState extends State<SettingProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("設定"),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: const [
                  SizedBox(width: 150, child: Text("名前")),
                  Expanded(child: TextField())
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  const SizedBox(width: 150, child: Text("プロフィール画像")),
                  ElevatedButton(
                    child: const Text('画像を選択'),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  child: const Text('編集'),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ));
  }
}
