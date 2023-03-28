import 'package:flutter/material.dart';
import 'package:walla/Model/cateogryModel.dart';
import 'package:walla/Screens/Category.dart' as category;

import 'Live/LiveCategory.dart' as liveCategory;

class CategoryList extends StatefulWidget {
  final bool isStatic;
  CategoryList(this.isStatic);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
        itemCount:
            widget.isStatic ? categoryList.length : liveCategoryList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => widget.isStatic
                            ? category.Category(
                                category: categoryList[index].name)
                            : liveCategory.LiveCategory(
                                category: liveCategoryList[index].name)));
              },
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: widget.isStatic
                            ? categoryList[index].image
                            : liveCategoryList[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black54,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Center(
                      child: Text(
                        widget.isStatic
                            ? categoryList[index].name.toUpperCase()
                            : liveCategoryList[index].name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'CircularStd',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
