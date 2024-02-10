import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constBread.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/model/categories.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                _buildCategoryContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryContent() {
    switch (widget.categories!.categoriesName) {
      case "Dog":
        return _categoryDog();
      case "Cat":
        return _categoryCat();
      case "Fish":
        return _categoryFish();
      case "Parrot":
        return _categoryParrot();
      default:
        return Text("Unknown category");
    }
  }

  Widget _categoryDog() {
    return Column(
      children: [
        Text("Dog-specific content"),
        _buildBreedDropdown(dogBreedList),
      ],
    );
  }

  Widget _categoryCat() {
    return Column(
      children: [
        Text("Cat-specific content"),
        _buildBreedDropdown(catBreedList),
      ],
    );
  }

  Widget _categoryFish() {
    return Column(
      children: [
        Text("Fish-specific content"),
        _buildBreedDropdown(fishBreedList),
        Container(
          height: 1000,
        )
      ],
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
