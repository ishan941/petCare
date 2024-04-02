import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constBread.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/model/categories.dart';
import 'package:project_petcare/provider/sellpetprovider.dart';
import 'package:provider/provider.dart';

enum PetCategory {
  Dog,
  Cat,
  Fish,
  Parrot,
}

class CategoriesDetails extends StatefulWidget {
  final Categories? categories;

  CategoriesDetails({Key? key, this.categories}) : super(key: key);

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  String? selectedBreed;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getData();
    });
    super.initState();
  }

  getData() async {
    var sellingPetProvider =
        Provider.of<SellingPetProvider>(context, listen: false);
    await sellingPetProvider.getTokenFromSharedPref();
    await sellingPetProvider.getSellingPetData();
    await sellingPetProvider.getDonatePetData();
    await sellingPetProvider.getCategoryDog();
    await sellingPetProvider.getCategoryCat();
    await sellingPetProvider.getCategoryFish();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      body: Consumer<SellingPetProvider>(
        builder: (context, sellingPetProvider, child) => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.white,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.categories!.categoriesName!,
                  style: TextStyle(fontSize: 16, color: ColorUtil.primaryColor),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      widget.categories!.categoriesImage!,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _buildCategoryContent(sellingPetProvider),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryContent(SellingPetProvider sellingPetProvider) {
    switch (widget.categories!.categoriesName) {
      case "Dog":
        return _categoryDog(sellingPetProvider);
      case "Cat":
        return _categoryCat(sellingPetProvider);
      case "Fish":
        return _categoryFish(sellingPetProvider);
      case "Parrot":
        return _categoryParrot();
      default:
        return Text("Unknown category");
    }
  }

  Widget _categoryDog(SellingPetProvider sellingPetProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Text("Our Dog Services"),
          // Text("Dog-specific content"),
          // _buildBreedDropdown(dogBreedList),
          Container(
            height: 200,
            // color: Colors.red,
            child: Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sellingPetProvider.categoryDogList.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 150,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Image.network(sellingPetProvider
                                      .categoryDogList[index].imageUrl ??
                                  ""),
                              Text(sellingPetProvider
                                      .categoryDogList[index].petName ??
                                  ""),
                              Text(sellingPetProvider
                                      .categoryDogList[index].petPrice ??
                                  "Free"),
                            ],
                          ),
                        ),
                      )),
            ),
          )
        ],
      ),
    );
  }

  Widget _categoryCat(SellingPetProvider sellingPetProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Text("Our Cat Services"),
          // Text("Dog-specific content"),
          // _buildBreedDropdown(dogBreedList),
          Container(
            height: 200,
            color: Colors.red,
            child: Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sellingPetProvider.categoryCatList.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 150,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Image.network(sellingPetProvider
                                      .categoryCatList[index].imageUrl ??
                                  ""),
                              Text(sellingPetProvider
                                      .categoryCatList[index].petName ??
                                  ""),
                              Text(sellingPetProvider
                                      .categoryCatList[index].petPrice ??
                                  "Free"),
                            ],
                          ),
                        ),
                      )),
            ),
          )
        ],
      ),
    );
  }

  Widget _categoryFish(SellingPetProvider sellingPetProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Text("Our Fish Services"),
          // Text("Dog-specific content"),
          // _buildBreedDropdown(dogBreedList),
          Container(
            height: 200,
            // color: Colors.red,
            child: Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sellingPetProvider.categoryFishList.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 150,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Image.network(sellingPetProvider
                                      .categoryFishList[index].imageUrl ??
                                  ""),
                              Text(sellingPetProvider
                                      .categoryFishList[index].petName ??
                                  ""),
                              Text(sellingPetProvider
                                      .categoryFishList[index].petPrice ??
                                  "Free"),
                            ],
                          ),
                        ),
                      )),
            ),
          )
        ],
      ),
    );
  }

  Widget _categoryParrot() {
    return Column(
      children: [
        Text("Parrot-specific content"),
        _buildBreedDropdown(fishBreedList),
      ],
    );
  }

  Widget _buildBreedDropdown(List<String> breedList) {
    return DropdownButton<String>(
      hint: Text("Select a breed"),
      value: selectedBreed,
      onChanged: (value) {
        setState(() {
          selectedBreed = value!;
        });
      },
      items: breedList.map((breed) {
        return DropdownMenuItem<String>(
          value: breed,
          child: Text(breed),
        );
      }).toList(),
    );
  }
}
