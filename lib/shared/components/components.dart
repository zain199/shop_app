import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget articleBuilder(list, index, context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(list[index]['urlToImage'].toString()),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.0)),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${list[index]['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "${list[index]['publishedAt']}",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget articleListView(list) {
  return ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
      itemBuilder: (context, index) => GestureDetector(
        child: articleBuilder(list, index, context),
        onTap: () {
          // NavigatorTo(context, ArticleScreen(list[index]['url']));
        },
      ),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Divider(
          thickness: 2.0,
          color: Colors.orange,
        ),
      ),
      itemCount: list.length,
    ),
    fallback: (context) => Center(child: CircularProgressIndicator()),
  );
}

void NavigatorTo(context, widget) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

void NavigatorToAndKill(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

Widget DefButton({
  double width = double.infinity,

  Color color = Colors.amber,
  @required Widget child,
  @required Function fun,
}) =>
    MaterialButton(

        height: 45.0,
        minWidth: width,
        color: color,
        child: child,
        onPressed: fun);

Widget DefTextForm({
  @required TextInputType type,
  @required TextEditingController controller,
  Icon prefixicon,
  String hint,
  bool isPassword = false,
  IconData suffixicon,
  Function sufOnPressed,
  Function validate,
  Function ontap,
  bool enabled = true,
  Function onSubmitted,
}) {
  return TextFormField(
    enabled: enabled,
    validator: validate,
    obscureText: isPassword,
    keyboardType: type,
    controller: controller,
    decoration: InputDecoration(
      suffixIcon: IconButton(
        icon: Icon(suffixicon),
        onPressed: sufOnPressed,
      ),
      prefixIcon: prefixicon,
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    onFieldSubmitted: onSubmitted,
    onTap: ontap,
  );
}

void toastMessage ({@required String msg,@required int state})
{
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: stateColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

Color stateColor(int state)
{
  // 0 for success and 1 for warning and else for error
  if(state == 0)return Colors.green;
  else if (state == 1) return Colors.yellow;
  else return Colors.red;
}
