import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_block/blocks/create_cubit.dart';
import 'package:last_block/blocks/create_state.dart';
import 'package:last_block/widgets/textfield_build.dart';

class Create_page extends StatelessWidget {
  const Create_page({Key? key}) : super(key: key);
  static var control1 = TextEditingController();
  static var control2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Create_cubit(),
      child: BlocBuilder<Create_cubit, Create_state>(
        builder: (context, state) => Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            centerTitle: true,
            title: Text("Create user"),
          ),
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  My_Textfield(hint: "Title", con: control1),
                  My_Textfield(hint: "Body", con: control2),
                  Container(
                    margin: EdgeInsets.all(20),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.teal[800],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Color.fromARGB(255, 4, 4, 4), width: 2)),
                    alignment: Alignment.center,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () async {
                            var title = control1.text.trim();
                            var body = control2.text.trim();

                            if (title.isEmpty && body.isEmpty) return;

                            context
                                .read<Create_cubit>()
                                .Create_user(title, body)
                                .then((value) {
                              if (value != null) {
                                control1.clear();
                                control2.clear();

                                Navigator.pop(context, value);
                              }
                            });
                          },
                          splashColor: Colors.black,
                          child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: double.infinity,
                              child: Text(
                                "Create",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: .5),
                              ))),
                    ),
                  )
                ],
              ),
              state.isLoading
                  ? Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(.3),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
