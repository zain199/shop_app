import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/home_cubit.dart';
import 'package:shop_app/layout/shop_cubit/home_cubit_states.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/network/local/Cache_Helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopHomeCubit.get(context);
        List<Widget> carItems = [];
        List<Product> products = [];
        List<CategoryData> categories=[];
        if (cubit.model != null) {
          cubit.model.data.bannaers.forEach((element) {
            carItems.add(Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(element.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16.0)),
            ));
          });

          // cubit.model.data.products.forEach((element) {
          //   products.add(element);
          // });
          //
          // cubit.categoryDataModel.data.data.forEach((element) {
          //   categories.add(element);
          // });
        }

        return ConditionalBuilder(
          condition: cubit.model != null,
          builder: (context) => homeBuilder(carItems,  cubit.model.data.products, cubit.categoryDataModel.data.data,context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget homeBuilder(List<Widget> carItems, List<Product> products,
      List<CategoryData> categories,context) {
    List<Widget> gridItems = [];
    products.forEach((element) {
      gridItems.add(gridItemBuilder(element,context));
    });
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: carItems,
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                )),
            SizedBox(
              height: 15.0,
            ),
            Text(
              'Categories',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              width: double.infinity,
              height: 85.0,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    categoryItemBuilder(categories[index]),
                separatorBuilder: (context, index) => SizedBox(
                  width: 7.0,
                ),
                itemCount: categories.length,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'New Products',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              color: Colors.grey[200],
              child: GridView.count(
                mainAxisSpacing: 1.5,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.76,
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: gridItems,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gridItemBuilder(Product product,context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(product.image),
                width: double.infinity,
                height: 200,
                //fit: BoxFit.cover,
              ),
              if (product.discount != 0)
                Container(
                  color: Colors.red,
                  height: 15.0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Text(
                    'Discount',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  '${product.price}EGP',
                  style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: defColor),
                ),
                SizedBox(
                  width: 8.0,
                ),
                if (product.discount != 0)
                  Text(
                    '${product.oldprice}EGP',
                    style: TextStyle(
                        fontSize: 8.0, decoration: TextDecoration.lineThrough),
                  ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  radius: 15.0,
                  child: IconButton(
                    color: defColor,
                    icon: product.inFavorite ? Icon(Icons.favorite_rounded) :Icon(Icons.favorite_border),
                    onPressed: () {
                      ShopHomeCubit.get(context).changeFavorites(product.id,Cache_Helper.getData('token'),product);
                    },
                    iconSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryItemBuilder(CategoryData model) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 85.0,
        ),
        Container(
          width: 85.0,
          height: 15.0,
          color: Colors.black.withOpacity(.6),
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }


}
