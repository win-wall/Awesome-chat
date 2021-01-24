import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatefulWidget {
  CategorySection({Key key}) : super(key: key);

  @override
  _CategorySectionState createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  int selectedIndex = 0;
  final List<String> categories = ['Messages', 'Online', 'Groups', 'Request'];
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(-1, -1),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.13,
        color: Theme.of(context).primaryColor,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: MediaQuery.of(context).size.width * 0.09,
                ),
                child: AutoSizeText(
                  categories[index],
                  style: TextStyle(
                    color:
                        index == selectedIndex ? Colors.white : Colors.white60,
                    fontSize: 120.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                  maxLines: 1,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
