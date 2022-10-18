import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jokes_app/models/funny_models.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:jokes_app/models/jokes_model.dart';

class FunnyPage extends StatefulWidget {
  const FunnyPage({super.key});

  @override
  State<FunnyPage> createState() => _FunnyPageState();
}

class _FunnyPageState extends State<FunnyPage> {
  Future<Funnys>? funnys;

  Future<Funnys?>? getFunnys() async {
    String url = "https://v2.jokeapi.dev/joke/Any?amount=50&safe-mode";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as Map<String, dynamic>;
      return Funnys.fromJson(json);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Funnys?>(
            future: getFunnys(),
            builder: (BuildContext context, AsyncSnapshot<Funnys?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  Funnys? funnys = snapshot.data;
                  return jokesListWidget(funnys?.jokes);
                }
                if (snapshot.hasError) {
                  return Container(
                      width: double.infinity,
                      child: Text(
                        "${snapshot.error}",
                        style: const TextStyle(fontSize: 30),
                      ));
                }
              }
              return Container();
            }),
      ),
    );
  }

  Widget jokesListWidget(List<Jokes>? jokes) {
    return Container(
      child: PageView.builder(
        controller: PageController(),
          scrollDirection: Axis.vertical,
          itemCount: jokes?.length ?? 0,
          itemBuilder: (context, index) {
            return Container(
              child: Center(
                child: Stack(
                  children: [
                    Container(
                       height: MediaQuery.of(context).size.height*0.96599,
                      child: Image.network(
                        "https://source.unsplash.com/random/${index}",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height*0.96599,
                      color:  Colors.black.withOpacity(0.5),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                        jokes?[index].setup.toString() ?? "",
                        style: const TextStyle(fontSize: 18,
                          letterSpacing: 2,
                          color: Colors.white),
                    ),
                      ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        jokes?[index].delivery.toString() ?? jokes![index].joke.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          letterSpacing: 2,
                          color: Colors.white
                        ),
                      ),
                    ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
