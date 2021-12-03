import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:guided/helpers/constant.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Container(
          margin: const EdgeInsets.only(left: 10, top: 10, right: 5, bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.grey.withOpacity(0.2)),
          child: IconButton(
              onPressed: () {Navigator.pop(context);},
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              ),
        ),
      ),
      body: getbody(context),
      backgroundColor: Colors.white,
      //resizeToAvoidBottomPadding: false,
    );
  }
}

/// Body of profile screen
Widget getbody(BuildContext context) {
  return SingleChildScrollView(
      child: Padding(
    padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ConstantHelpers.spacing15,
        getprofile(context),
        ConstantHelpers.spacing15,
        const Text(
          'About Me',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'above the Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed venenatis volutpat risus vitae iaculis. ',
          style: TextStyle(color: Colors.grey),
        ),
        getAboutme(context),
        getprofilesetting(context)
      ],
    ),
  ));
}

/// profile image
Widget getprofile(BuildContext context) {
  return Center(
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 3,
            ),
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: const <BoxShadow>[
              BoxShadow(blurRadius: 3, color: Colors.grey)
            ],
          ),
          child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 35,
              backgroundImage: const NetworkImage(
                  'https://www.vhv.rs/dpng/d/164-1645859_selfie-clipart-groucho-glass-good-profile-hd-png.png'),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            blurRadius: 4,
                            color: Colors.grey,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.edit,
                      size: 10,
                      color: Colors.black,
                    )),
              )),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Edit',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Ethan Hunt',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

/// widget for about me
Widget getAboutme(BuildContext context) {
  return GridView.count(
    crossAxisCount: 2,
    crossAxisSpacing: 20,
    shrinkWrap: true,
    children: [
      Container(
        margin: const EdgeInsets.fromLTRB(0,23,0,23),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(ConstantHelpers.image2),
                fit: BoxFit.cover)    
        ),
      ),
      Container(
        margin: const EdgeInsets.fromLTRB(0,23,0,23),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
            image: DecorationImage(
                image: AssetImage(ConstantHelpers.image1),
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
                fit: BoxFit.cover)),
        child: const Center(
          child: Text(
            '4+', style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24
            ),
          ),
        ),
      )
    ],
  );
}

/// widget for profile settings
Widget getprofilesetting(BuildContext context) {
  return Column(children: [
    ListTile(
        leading: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.lock_outline)),
        title: const Text(
          'Change Password',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 17)),
    ListTile(
        leading: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.tablet_android_outlined)),
        title: const Text(
          'Change Mobile Number',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15)),
    ListTile(
        leading: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20)),
            child: Image.asset(ConstantHelpers.certificateIcon)),
        title: const Text(
          'Certificates',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15)),
    ListTile(
        leading: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.lock_outline)),
        title: const Text(
          'About Me',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15)),
  ]);
}
