import 'package:flutter/material.dart';
import 'package:project_petcare/helper/textStyle_const.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: ColorUtil.BackGroundColorColor,
            expandedHeight: 50.0,
            elevation: 0,
            floating: true,
            pinned: false,
            snap: true, // Set to true for a snapping effect
            flexibleSpace: FlexibleSpaceBar(
              title: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    Text('PetHub',
                    style: TextStyle(fontSize: 20,
                    color: ColorUtil.primaryColor),
                    ),
                    Spacer(),
                    Icon(Icons.search),
                    Icon(Icons.add),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // Your list items go here
                return ListTile(
                  title: Text('Item $index'),
                );
              },
              childCount: 20, // Change this based on your list size
            ),
          ),
        ],
      ),
    );
  }
}
