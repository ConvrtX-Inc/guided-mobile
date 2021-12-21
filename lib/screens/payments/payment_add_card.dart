import 'package:flutter/material.dart';
import 'package:guided/common/widgets/borderless_textfield.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';

/// screen for adding payment card
class PaymentAddCard extends StatefulWidget {
  /// constructor
  const PaymentAddCard({Key? key}) : super(key: key);

  @override
  _PaymentAddCardState createState() => _PaymentAddCardState();
}

class _PaymentAddCardState extends State<PaymentAddCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Add Card',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: 'Gilroy'),
        ),
      ),
      body: _buildBody(),
      bottomNavigationBar:
          CustomRoundedButton(title: 'Add Card', onpressed: () {}),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 37),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                'Billing Information',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gilroy'),
              ),
            ),
            _getBillingInfo(),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                'Card Information',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gilroy'),
              ),
            ),
            _getCardInfo(),
          ],
        ),
      ),
    );
  }

  Widget _getBillingInfo() {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        const BorderlessTextField(
          title: 'Full name',
          hint: 'Aycan Doganlar',
        ),
        const SizedBox(
          height: 20,
        ),
        const BorderlessTextField(
          title: 'Address',
          hint: '3819 Lynden Road',
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.8,
              child: const BorderlessTextField(
                title: 'City',
                hint: 'Canada',
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.8,
              child: const BorderlessTextField(
                title: 'Postal Code',
                hint: 'L0B 1M0',
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const BorderlessTextField(title: 'Country', hint: '3819 Lynden Road',),
      ],
    );
  }

  Widget _getCardInfo() {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        const BorderlessTextField(title: 'Name on card', hint: 'Aycan Doganlar',),
        const SizedBox(
          height: 20,
        ),
        const BorderlessTextField(title: 'Card Number', hint: '1234 4567 7890 1234'),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.8,
              child: const BorderlessTextField(
                title: 'Expiry Date',
                hint: '02/24',
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.8,
              child: const BorderlessTextField(
                title: '',
                hint: '...',
              ),
            ),
          ],
        )
      ],
    );
  }
}
