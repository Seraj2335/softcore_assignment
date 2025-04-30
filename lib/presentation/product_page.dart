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
    final size = MediaQuery.of(context).size;

    return Scaffold(body: BlocBuilder<ProductBloc, ProductState>(
      builder:(context, state) {
        if (state is ProductInitial || state is ProductLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProductLoaded || state is ProductLoadingMore) {
          final products = (state is ProductLoaded)
              ? state.product
              : (state as ProductLoadingMore).products;
          return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification.metrics.pixels ==
                    scrollNotification.metrics.maxScrollExtent) {
                  context.read<ProductBloc>().add(FetchData());
                }
                return false;
              },
              child: ListView.builder(
                  itemCount: products.length + 1,
                  itemBuilder: (context, index) {
                    if (index < products.length) {
                      return ProductDesign(
                        size: size,
                        product: products[index],
                        key: ValueKey(products[index].designCode),
                      );
                    } else {
                      return state is ProductLoadingMore
                          ? const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : const SizedBox();
                    }
                  }));
        } else if (state is ProductError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Container(); // Fallback
      },
    ));
  }
}

class ProductDesign extends StatefulWidget {
  const ProductDesign({
    super.key,
    required this.size,
    required this.product,
  });

  final Size size;
  final Product product;

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
            width: widget.size.width * 0.35,
            height: widget.size.width * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
              imageUrl: '$imageBaseUrl${widget.product.designCode}.jpeg',
                width: double.infinity,
                height: double.infinity,
                maxHeightDiskCache: 999,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: Colors.grey[200]),
                errorWidget: (context, url, error) => Container(
                  color: Colors.black12,
                  child: Center(child: Icon(Icons.error, color: Colors.white)),
                )),
            ),
          ),
          SizedBox(width: widget.size.width * .05),
          SizedBox(
            width: widget.size.width * .475,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildText(widget.product.supplierName ?? ''),
                const SizedBox(height: 3),
                _buildText(widget.product.brandName ?? ''),
                const SizedBox(height: 3),
                _buildText(widget.product.designCategoryName ?? ''),
                const SizedBox(height: 3),
                _buildText(widget.product.subDesignCategoryName ?? ''),
                const Divider(color: Colors.black12, height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(fontSize: 14),
    );
  }
}
