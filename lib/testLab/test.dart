import 'package:flutter/material.dart';
import 'package:ux_ui_find_go/server/User/crude_user.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List? data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          data != null
              ? Expanded(
                  child: ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (context, index) => Card(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data![index].uID.toString()),
                        Text(data![index].uName.toString()),
                        Text(data![index].uEmail.toString()),
                        Text(data![index].uImage.toString()),
                        Text(data![index].uUsername.toString()),
                        Text(data![index].uPassword.toString()),
                        Text(data![index].uLocation.toString()),
                        Text(data![index].uStatus.toString()),
                        Text(data![index].uUserTell.toString()),
                        Text(data![index].uShowTell.toString()),
                        Text(data![index].uClass.toString()),
                        Text(data![index].uTime.toString()),
                      ],
                    )),
                  ),
                )
              : const Text(''),
          TextButton(
            onPressed: () async {
              // data = await CrudeUser().getUsers();
              if (data!.isNotEmpty)
                // data = data!.map((e) => User.fromJson(e)).toList();
                // print(jsonEncode(data[0]));
                setState(() {});
            },
            child: const Text("get User"),
          )
        ],
      ),
    );
  }
}
