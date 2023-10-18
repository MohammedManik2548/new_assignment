import 'package:flutter/material.dart';
import 'package:new_assignment_json/models/android_version.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<AndroidVerison> processDate = [];
  String searchResult = '';
  bool outputOneClicked = false;
  bool outputTwoClicked = false;
  bool searchClicked = false;


  List<dynamic> inputData1 = [
    {
      "0": {"id": 1, "title": "Gingerbread"},
      "1": {"id": 2, "title": "Jellybean"},
      "3": {"id": 3, "title": "KitKat"}
    },
    [
      {"id": 4, "title": "Lollipop"},
      {"id": 5, "title": "Pie"},
      {"id": 6, "title": "Oreo"},
      {"id": 7, "title": "Nougat"}
    ]
  ];

  List<dynamic> inputData2 = [
    {
      "0": {"id": 1, "title": "Gingerbread"},
      "1": {"id": 2, "title": "Jellybean"},
      "3": {"id": 3, "title": "KitKat"}
    },
    {
      "0": {"id": 8, "title": "Froyo"},
      "2": {"id": 9, "title": "Éclair"},
      "3": {"id": 10, "title": "Donut"}
    },
    [
      {"id": 4, "title": "Lollipop"},
      {"id": 5, "title": "Pie"},
      {"id": 6, "title": "Oreo"},
      {"id": 7, "title": "Nougat"}
    ]
  ];

  @override
  void initState() {
    processJson(inputData1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text('Json Assignment',style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    processJson(inputData1);
                    outputOneClicked=true;
                    outputTwoClicked=false;
                    searchClicked=false;
                  });
                },
                child: Text('Show outpur 1'),
            ),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    processJson(inputData2);
                    outputTwoClicked=true;
                    outputOneClicked=false;
                    searchClicked=false;
                  });
                },
                child: Text('Show outpur 2'),
            ),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                   searchResult = searchId(inputData1, 3);
                   searchClicked=true;
                   outputOneClicked=false;
                   outputTwoClicked=false;
                  });
                },
                child: Text('Search'),
            ),
            Visibility(
              visible: outputOneClicked==true?true:false,
              child: Expanded(
                child: Column(
                  children: [
                    Text('Output 1'),
                    Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, // number of items in each row
                            mainAxisSpacing: 8.0, // spacing between rows
                            crossAxisSpacing: 8.0, // spacing between columns
                          ),
                            itemCount: processDate.length,
                            itemBuilder: (c, i){
                              return Container(
                                padding: EdgeInsets.all(15),
                                  child: Text(processDate[i].title??'',
                                    style: TextStyle(fontSize: 10),
                                  ),
                              );
                            },
                        ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: outputTwoClicked==true?true:false,
              child: Expanded(
                child: Column(
                  children: [
                    Text('Output 2'),
                    Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, // number of items in each row
                            mainAxisSpacing: 8.0, // spacing between rows
                            crossAxisSpacing: 8.0, // spacing between columns
                          ),
                            itemCount: processDate.length,
                            itemBuilder: (c, i){
                              return Container(
                                padding: EdgeInsets.all(15),
                                  child: Text(processDate[i].title??'',
                                    style: TextStyle(fontSize: 10),
                                  ),
                              );
                            },
                        ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: searchClicked==true?true:false,
              child: Expanded(
                  child: Text(searchResult),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void processJson(List<dynamic> jsonData) {
    processDate.clear();

    for(var data in jsonData){

      if(data is List){

        for(var item in data){
          processDate.add(AndroidVerison(id: item['id'],title: item['title']));
        }

      }else if(data is Map){
        for(var item in data.values){
          processDate.add(AndroidVerison(id: item['id'],title: item['title']));
        }
      }

    }

  }

  String searchId(List<dynamic> jsonData, int id){
    for(var data in jsonData){

      if(data is List){
        for(var item in data){
          if(item['id']==id){
            return item['title'];
          }
        }
      }else if(data is Map){
        for(var item in data.values){
          if(item['id']==id){
            return item['title'];
          }
        }
      }
    }
    return 'ID not fund';
  }

}
