import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/main_model.dart';


class Addpage extends StatelessWidget {
  final MainModel model;
  Addpage(this.model);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>.value (
        value: MainModel(),
        child: Scaffold(
          appBar: AppBar(

            title: Text('TODOアプリ'),
          ),
          body: Consumer<MainModel>(builder:(context,model,child) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                TextField(
                  decoration: InputDecoration(
                      labelText: "追加するTODO",
                      hintText: "(例)ゴミを出す",
                  ),
                  onChanged: (text){
                    model.newtodoText = text;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                RaisedButton(child: Text('追加する'),
                    onPressed: () async {
                      await model.add();
                     Navigator.pop(context);
                    }),
              ],),
            );
          }),
        ),
      );
  }
}