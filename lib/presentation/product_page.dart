
import 'package:assignment/bloc/product_bloc.dart';
import 'package:assignment/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// mtsharma.29@gmail.com
class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(body: BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductInitial || state is ProductLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProductLoaded) {
          return ListView.builder(
            itemCount: state.product.length,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.symmetric(horizontal: size.width*.025),
              margin: EdgeInsets.only(bottom: size.height*.03),
              child: Row(
                children: [
                  Container(
                    width: size.width * .35,
                    height: size.height * .1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                        image: DecorationImage(
                            image: NetworkImage(
                                "$imageBaseUrl${state.product[index].designCode}.jpeg"),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: size.width * .05,
                  ),
                  SizedBox(
                    width: size.width*.475,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.product[index].supplierName!,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          state.product[index].brandName!,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          state.product[index].designCategoryName!,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          state.product[index].subDesignCategoryName!,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Divider(
                          color: Colors.black12,
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is ProductError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Container(); // Fallback
      },
    ));
  }
}
