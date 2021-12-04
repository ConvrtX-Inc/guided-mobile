// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/helpers/constant.dart';

class OutfitterAdd extends StatefulWidget {
  const OutfitterAdd({Key? key}) : super(key: key);

  @override
  _OutfitterAddState createState() => _OutfitterAddState();
}

class _OutfitterAddState extends State<OutfitterAdd> {

  final TextStyle greyStyle = TextStyle(
      color: ConstantHelpers.osloGrey,
      fontFamily: ConstantHelpers.fontGilroy,
      fontWeight: FontWeight.w200,
      fontSize: 12
  );

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    _imagePreview() {
      return Stack(
        children: [
          Container(
            width: 100,
            height: 87,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ConstantHelpers.f0f0f0,
              boxShadow: [
                BoxShadow(
                  color: ConstantHelpers.f0f0f0,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: [
                  Image.asset(
                    ConstantHelpers.imageprey,
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 3,
            top: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                color: Colors.grey,
              ),
            ),
          )
        ],
      );
    }

    return ScreenUtilInit(builder: () =>
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: Transform.scale(
              scale: 0.8,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: ConstantHelpers.backarrowgrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_sharp,
                      color: Colors.black,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          body: SafeArea(
            child: SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderText.headerText(
                        ConstantHelpers.outfitters
                      ),
                      ConstantHelpers.spacing30,
                      ConstantHelpers.spacing20,
                      Text(
                        ConstantHelpers.uploadImages,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: ConstantHelpers.osloGrey),
                      ),
                      ConstantHelpers.spacing20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _imagePreview(),
                          _imagePreview(),
                          _imagePreview(),
                        ],
                      ),
                      ConstantHelpers.spacing20,
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                          hintText: ConstantHelpers.title,
                          hintStyle: TextStyle(
                            color: ConstantHelpers.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 0.2),
                          ),
                        ),
                      ),
                      ConstantHelpers.spacing20,
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                          hintText: ConstantHelpers.price,
                          hintStyle: TextStyle(
                            color: ConstantHelpers.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 0.2),
                          ),
                        ),
                      ),
                      ConstantHelpers.spacing20,
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                          hintText: ConstantHelpers.productLink,
                          hintStyle: TextStyle(
                            color: ConstantHelpers.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 0.2),
                          ),
                        ),
                      ),
                      ConstantHelpers.spacing20,
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.pin_drop,
                            color: Colors.black,
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                          hintText: ConstantHelpers.useCurrentLocation,
                          hintStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 0.2),
                          ),
                        ),
                      ),
                      ConstantHelpers.spacing20,
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                          hintText: ConstantHelpers.canada,
                          hintStyle: TextStyle(
                            color: ConstantHelpers.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 0.2),
                          ),
                        ),
                      ),
                      ConstantHelpers.spacing20,
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                          hintText: ConstantHelpers.street,
                          hintStyle: TextStyle(
                            color: ConstantHelpers.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 0.2),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child:  Text(
                          ConstantHelpers.streethint,
                          style: greyStyle,
                        ),
                      ),
                      ConstantHelpers.spacing20,
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                          hintText: ConstantHelpers.city,
                          hintStyle: TextStyle(
                            color: ConstantHelpers.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 0.2),
                          ),
                        ),
                      ),
                      ConstantHelpers.spacing20,
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                          hintText: ConstantHelpers.provinceHint,
                          hintStyle: TextStyle(
                            color: ConstantHelpers.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 0.2),
                          ),
                        ),
                      ),
                      ConstantHelpers.spacing20,
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                          hintText: ConstantHelpers.postalCodeHint,
                          hintStyle: TextStyle(
                            color: ConstantHelpers.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 0.2),
                          ),
                        ),
                      ),
                      ConstantHelpers.spacing20,
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                          hintText: ConstantHelpers.date,
                          hintStyle: TextStyle(
                            color: ConstantHelpers.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 0.2),
                          ),
                        ),
                      ),
                      ConstantHelpers.spacing20,
                      TextField(
                        maxLines: 10,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                          hintText: ConstantHelpers.description,
                          hintStyle: TextStyle(
                            color: ConstantHelpers.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 0.2),
                          ),
                        ),
                      ),
                      ConstantHelpers.spacing20,
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: width,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: ConstantHelpers.buttonNext,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  primary: ConstantHelpers.primaryGreen,
                  onPrimary: Colors.white,
                ),
                child: Text(
                  ConstantHelpers.createOutfitter,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      designSize: const Size(375, 812),
    );
  }
}
