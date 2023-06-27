import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_market_api/model/detay_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UrunDetaySayfasi extends StatefulWidget {
  int id;
  UrunDetaySayfasi(this.id);

  @override
  State<UrunDetaySayfasi> createState() => _UrunDetaySayfasiState();
}

class _UrunDetaySayfasiState extends State<UrunDetaySayfasi> {


  Future<Detay?> _getDetay() async {
    try {
      var response =
          await Dio().get("https://fakestoreapi.com/products/${widget.id}");
      Detay detay = Detay(
          id: 3,
          title: "1",
          price: 1,
          description: "1",
          category: "1",
          image: "1",
          rating: Rating(rate: 1, count: 1));
      if (response.statusCode == 200) {
        detay = Detay.toJson(response.data);
      }
      return detay;
    } on DioError catch (e) {
      return Future.error(e);
    }
  }

  late Future<Detay?> detayGetir;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detayGetir = _getDetay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Urun Detay Sayfasi")),
      body: FutureBuilder(
        future: _getDetay(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var urun = snapshot.data!;
            return Card(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Container(
                      decoration: BoxDecoration(
                          image:
                              DecorationImage(image: NetworkImage(urun.image))),
                    ),
                  ),
                  const Divider(),
                  Text(urun.title),
                  Text(urun.category.toUpperCase()),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(urun.description),
                  Row(
                    children: [
                      const Icon(
                        Icons.money,
                        size: 30,
                      ),
                      Text(":${urun.price}")
                    ],
                  ),
                  SizedBox(
                   
                    child: RatingBar.builder(
                      
                      initialRating: urun.rating.rate,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                      itemBuilder: (context, index) =>const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
