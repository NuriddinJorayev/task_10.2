import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_block/blocks/update_cubit.dart';
import 'package:last_block/blocks/update_state.dart';
import 'package:last_block/models/user.dart';
import 'package:last_block/widgets/textfield_build.dart';

class UpdatePage extends StatefulWidget {
  static final String Route_name = "/Update_page";
  final User? user;
  const UpdatePage({Key? key, this.user}) : super(key: key);
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  var control1 = TextEditingController();
  var control2 = TextEditingController();
  static bool tap = true;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      control1.text = widget.user!.title;
      control2.text = widget.user!.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Update_cubit(),
      child: BlocBuilder<Update_cubit, Update_state>(
        builder: (context, state) => Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            centerTitle: true,
            title: Text("Update user"),
          ),
          body: Center(
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      My_Textfield(hint: "Title", con: control1),
                      My_Textfield(
                        hint: "Body",
                        con: control2,
                      ),
                    ],
                  ),
                ),
                state.isloading
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
          floatingActionButton: FloatingActionButton(
            onPressed: tap
                ? () {
                    if (tap) {
                      tap = false;
                      var title = control1.text.trim();
                      var body = control2.text.trim();
                      if (title.isNotEmpty && body.isNotEmpty) {
                        if (widget.user!.title == title &&
                            widget.user!.body == body) {
                          Navigator.pop(context);
                          tap = true;
                          return null;
                        }
                        widget.user!.title = title;
                        widget.user!.body = body;
                        context
                            .read<Update_cubit>()
                            .Update_user(widget.user!)
                            .then((value) {
                          if (value.isNotEmpty) {
                            Navigator.pop(context, widget.user!);
                          }
                        });
                      }
                      tap = true;
                    }
                  }
                : null,
            child: Icon(Icons.refresh),
          ),
        ),
      ),
    );
  }
}
