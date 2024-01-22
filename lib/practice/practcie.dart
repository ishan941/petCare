import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constant.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  @override
  Widget build(BuildContext context) {
    List<PickImage> imageList = [
      PickImage(images: "assets/images/ishan.jpg", name: "Ishan", message: "Hello Ishan"),
      PickImage(images: "assets/images/rabbitCategories.png", name: "Google", message: "Hello Manjil"),
      PickImage(images: "assets/images/dog shop.jpeg", name: "Dog", message: "Oi vat day"),
      PickImage(images: "assets/images/medicalpp.avif", name: "Medical", message: "K xa "),
      PickImage(images: "assets/images/cat pp.jpeg", name: "i", message: ""),
    ];
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      body: Column(
        children: [
          Container(
            height: 100,
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios_new),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "ishanshrestha",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Icon(Icons.keyboard_arrow_down_rounded),
                Spacer(),
                Icon(Icons.more_horiz_outlined),
                SizedBox(
                  width: 30,
                ),
                Icon(Icons.copy_all_sharp),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.search, color: Colors.black.withOpacity(0.4)),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Search",
                        style: TextStyle(
                            fontSize: 17, color: Colors.black.withOpacity(0.4)),
                      )
                    ],
                  ),
                ),
              ),
              Text("Filter"),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageList.length,
                itemBuilder: (context, index) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage(
                              imageList[index].images!,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(imageList[index].name!)
                      ],
                    )),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.withOpacity(0.3),
                  ),
                  child: Center(
                      child: Text(
                    "• Primary 10",
                    style: TextStyle(color: Color.fromARGB(255, 7, 110, 195)),
                  )),
                  height: 30,
                  width: 117,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  child: Center(child: Text("General")),
                  height: 30,
                  width: 117,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  child: Center(child: Text("Requests")),
                  height: 30,
                  width: 117,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: imageList.length,
              itemBuilder: (context, index)=>
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // height: 80,
                // color: Colors.red,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(imageList[index].images!),
                    ),
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(imageList[index].name!, style: TextStyle(fontSize: 17,
                        fontWeight: FontWeight.w600),),
                        SizedBox(height: 5,),
                        Text(imageList[index].message!),
                        SizedBox(height: 15,)
                      ],
                    ), 
                    Spacer(),
                    Icon(Icons.camera_enhance_outlined),
                    SizedBox(width: 10,)
                  ],
                ),
              ),
            )
            ),
          )
        ],
      ),
    );
  }
}

class PickImage {
  String? images, name, message;
  PickImage({
    this.images,
    this.name,
    this.message,
  });
}
