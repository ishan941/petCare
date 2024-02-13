import 'package:flutter/material.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/view/adopt/adoptDetails.dart';
import 'package:project_petcare/view/donate/donate_1.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<PetCareProvider>(
        builder: (context, petCareProvider, child) => Consumer<AdoptProvider>(
          builder: (context, adoptProvider, child) => CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: ColorUtil.BackGroundColorColor,
                expandedHeight: 50.0,
                elevation: 0,
                floating: true,
                pinned: false,
                snap: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        Text(
                          'PetFeed',
                          style: TextStyle(
                              fontSize: 20, color: ColorUtil.primaryColor),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.search),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DonateFirstPage()));
                          },
                          icon: Icon(Icons.add),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              height: 60,
                              width: 60,
                              child: petCareProvider.profilePicture != null
                                  ? Image.network(
                                      petCareProvider.profilePicture ?? "",
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/emptypp.png",
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("You have something about pet?"),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 3,
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => AdoptDetails(
                        //       adopt: adoptProvider.adoptDetailsList[index],
                        //     ),
                        //   ),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                adoptProvider
                                        .adoptDetailsList[index].petbread ??
                                    "",
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow
                                    .ellipsis, // Handle overflow gracefully
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                // color: Colors.white,
                                // boxShadow: [
                                //   BoxShadow(
                                //     spreadRadius: 0,
                                //     blurRadius: 3,
                                //     color: Colors.grey.withOpacity(0.5),
                                //     offset: Offset(2, 4),
                                //   ),
                                // ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: GestureDetector(
                                      onDoubleTap: () {
                                        adoptProvider.handleDoubleTap(index);
                                      },
                                      child: Image.network(
                                        adoptProvider.adoptDetailsList[index]
                                                .imageUrl ??
                                            "",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  adoptProvider.adoptDetailsList[index]
                                          .isDoubleTapped
                                      ? Icon(
                                          Icons.favorite_rounded,
                                          color: Colors.red,
                                        )
                                      : Icon(Icons.favorite_outline),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          adoptProvider.adoptDetailsList[index]
                                                  .petname ??
                                              "",
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .7,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                size: 15,
                                                color: ColorUtil.primaryColor,
                                              ),
                                              const SizedBox(
                                                width: 2,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  adoptProvider
                                                          .adoptDetailsList[
                                                              index]
                                                          .location ??
                                                      "",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (index !=
                                adoptProvider.adoptDetailsList.length - 1)
                              Divider(
                                thickness: 3,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: adoptProvider.adoptDetailsList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
