import 'package:flutter/material.dart';
import 'package:janssen_cusomer_service/main.dart';
import 'package:janssen_cusomer_service/models/prodcutinfo.dart';

class ProdcutInfo extends StatelessWidget {
  const ProdcutInfo({
    super.key,
    required this.prodcut,
  });
  final ProductInfo prodcut;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 211, 210, 210),
              borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
          width: .3 * (MediaQuery.sizeOf(context).width - 380),
          child: const Center(
              child: Text(
            "Prodcut Info",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          )),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 230),
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(246, 246, 248, 1),
                borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
            width: .3 * (MediaQuery.sizeOf(context).width - 380),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 9, bottom: 6),
                  child: Text(
                    " نوع المنتج : ${prodcut.ProdcutType}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 9, bottom: 6),
                  child: Text(
                    " اسم المنتج :  ${prodcut.ProductName}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 9, bottom: 6),
                  child: Text(
                    " المقاس : ${prodcut.L}*${prodcut.W}*${prodcut.H}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 9, bottom: 6),
                  child: Text(
                    " الكميه : ${prodcut.Quantity} ",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 9, bottom: 6),
                  child: Text(
                    "${df.format(prodcut.PurcheDate)} : تاريخ الشراء",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 9, bottom: 6),
                  child: Text(
                    " مكان الشراء : ${prodcut.PurcheLocation} ",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
