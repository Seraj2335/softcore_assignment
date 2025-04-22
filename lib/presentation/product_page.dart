import 'package:assignment/bloc/product_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';
import '../data/models/product_model.dart';

// mtsharma.29@gmail.com
class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('>>>> built again');
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
            itemBuilder: (context, index) => ProductDesign(
              size: size,
              productList: state.product,
              index: index,
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

class ProductDesign extends StatefulWidget {
  const ProductDesign(
      {super.key,
      required this.size,
      required this.index,
      required this.productList});

  final Size size;
  final List<Product> productList;
  final int index;

  @override
  State<ProductDesign> createState() => _ProductDesignState();
}

class _ProductDesignState extends State<ProductDesign>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.size.width * .025),
      margin: EdgeInsets.only(bottom: widget.size.height * .03),
      child: Row(
        children: [
          Container(
            width: widget.size.width * .35,
            height: widget.size.height * .1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: CachedNetworkImage(
              imageUrl:
                  "$imageBaseUrl${widget.productList[widget.index].designCode}.jpeg",
              maxHeightDiskCache: 999,
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: widget.size.width * .05,
          ),
          SizedBox(
            width: widget.size.width * .475,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productList[widget.index].supplierName!,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  widget.productList[widget.index].brandName!,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  widget.productList[widget.index].designCategoryName!,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  widget.productList[widget.index].subDesignCategoryName!,
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
    );
  }
}
