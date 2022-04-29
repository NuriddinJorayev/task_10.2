import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_block/blocks/home_cubit.dart';
import 'package:last_block/blocks/home_state.dart';
import 'package:last_block/pages/create_page.dart';
import 'package:last_block/views/home_view.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var list_key = GlobalKey<AnimatedListState>();
  var dta;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<Home_Cubit>(context).initialize();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<Home_Cubit, Home_state>(
      builder: (context, state) => Scaffold(
        backgroundColor: Color.fromARGB(255, 51, 48, 48),
        appBar: AppBar(
          title: Text("Bloc users = ${state.count}"),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          child: state.isLoading
              ? Container(
                  height: height,
                  width: width,
                  color: Colors.black.withOpacity(0.4),
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator.adaptive(),
                  ),
                )
              : state.base_list.isNotEmpty
                  ? AnimatedList(
                      key: list_key,
                      initialItemCount: state.base_list.length,
                      itemBuilder: (context, index, animation) => UserItem(
                        width: width,
                        list_key: list_key,
                        u: state.base_list[index],
                        animation: animation,
                        Remove: (all_list) {
                          final removed_item = state.base_list[index];
                          context
                              .read<Home_Cubit>()
                              .Delete(index, removed_item);
                          list_key.currentState!.removeItem(
                            index,
                            (context, animation) => UserItem(
                                width: width,
                                list_key: list_key,
                                u: removed_item,
                                model: state,
                                animation: animation,
                                Remove: (ll) {}),
                          );
                        },
                        model: state,
                      ),
                    )
                  : Text("no data"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(state.count);
            Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Create_page()))
                .then((value) {
              if (value != null) {
                context.read<Home_Cubit>().add_user(value);
                print("all list   = ${state.base_list.length}");
                list_key.currentState?.insertItem(state.base_list.length - 1);
              }
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
