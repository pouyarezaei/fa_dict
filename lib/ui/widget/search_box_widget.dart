import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  TextDirection textDirection;
  Function(String value)? onChange;
  Function()? onSearchClicked;
  TextEditingController? textFieldcontroller;

  SearchBox(
      {Key? key,
      required this.textDirection,
      this.onChange,
      this.onSearchClicked,
      this.textFieldcontroller})
      : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Directionality(
              textDirection: widget.textDirection,
              child: TextField(
                onChanged: widget.onChange,
                controller: widget.textFieldcontroller,
                showCursor: true,
                decoration: InputDecoration(
                    filled: true,
                    contentPadding: const EdgeInsets.all(16.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    hintTextDirection: TextDirection.rtl,
                    hintText: "کلمه مورد نظر خود را برای ترجمه وارد کنید ..."),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          GestureDetector(
            onTap: widget.onSearchClicked,
            child: Container(
              margin: EdgeInsets.all(16.0),
              width: 50,
              height: 50,
              child: Icon(
                Icons.search,
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
