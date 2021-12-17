import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/home_cubit.dart';
import 'package:shop_app/layout/shop_cubit/home_cubit_states.dart';
import 'package:shop_app/models/category_model.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopHomeCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.categoryDataModel!=null,
          builder:(context) =>  ListView.separated(
              itemBuilder: (context, index) => categoryItemBuilder(cubit.categoryDataModel.data.data[index]),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(height: 10.0,),
              ),
              itemCount: cubit.categoryDataModel.data.data.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }

  Widget categoryItemBuilder(CategoryData model) {
    return Container(
      width: double.infinity,
      height: 120.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 120.0,
            height: 120.0,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10.0,),
          Text(
            model.name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          IconButton(icon: Icon(Icons.arrow_forward_outlined), onPressed: (){}),
        ],
      ),
    );
  }
}
