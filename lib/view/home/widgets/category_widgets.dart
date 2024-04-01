import 'package:bbm/generated/assets.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  final Function(int) onCategorySelected;
  const CategoryWidget({super.key, required this.onCategorySelected});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late int selectedCatIndex;
  @override
  void initState() {
    super.initState();
    selectedCatIndex = 0;
  }
  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoryList = [
      CategoryModel(
          title: 'Lottery', image: Assets.categoryLottery),
      CategoryModel(
          title: 'Mini games', image: Assets.categoryMiniGame),
      CategoryModel(
          title: 'Slots', image: Assets.categorySlots),
      // CategoryModel(
      //     title: 'Sports', image: Assets.categorySports),
      // CategoryModel(
      //     title: 'Casino', image: Assets.categoryCasino),
      // CategoryModel(
      //     title: 'PVC', image: Assets.categoryPvc),
      // CategoryModel(
      //     title: 'Fishing', image: Assets.categoryFishing),
      // CategoryModel(
      //     title: 'Popular', image: Assets.categoryPopular),
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: categoryList.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 5,
              mainAxisSpacing: 3,
              crossAxisCount: 3,
            childAspectRatio: 0.9
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCatIndex = index;
                  widget.onCategorySelected(selectedCatIndex);
                });
              },
              child: Container(
                decoration: BoxDecoration(gradient: AppColors.goldenGradient,borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      '${categoryList[index].image}',
                    ),
                    textWidget(
                        text: categoryList[index].title,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      color: selectedCatIndex == index
                          ? Colors.red // Change text color if selected
                          : Colors.black,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class CategoryModel {
  final String title;
  final String? image;
  CategoryModel({required this.title, this.image});
}
