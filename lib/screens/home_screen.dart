import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:tip_clap/screens/about_us_screen.dart';
import 'package:tip_clap/screens/feedback_screen.dart';
import 'package:tip_clap/screens/privacy_policy_screen.dart';

import '../widgets/slider_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _billAmountController = TextEditingController();
  double _tipPercentage = 0.1;
  double _splitBy = 2;
  bool _includeTax = false;
  double _taxPercentage = 0.1;




  double calculateTotalAmount() {
    double billAmount = double.tryParse(_billAmountController.text) ?? 0;
    double totalTip = billAmount * _tipPercentage;
    double totalWithTip = billAmount + totalTip;

    if (_includeTax) {
      double taxAmount = billAmount * _taxPercentage;
      totalWithTip += taxAmount;
    }

    return totalWithTip;
  }

  double calculateTotalPerPerson() {
    return calculateTotalAmount() / _splitBy;
  }

  double calculateTipPerPerson() {
    double billAmount = double.tryParse(_billAmountController.text) ?? 0;
    double totalTip = billAmount * _tipPercentage;
    return totalTip / _splitBy;
  }

  double calculateTaxAmount() {
    double billAmount = double.tryParse(_billAmountController.text) ?? 0;
    return billAmount * _taxPercentage;
  }

  void adjustTaxPercentage(bool increase) {
    setState(() {
      if (increase) {
        if (_taxPercentage < 1.0) _taxPercentage += 0.1;
      } else {
        if (_taxPercentage > 0.0) _taxPercentage -= 0.1;
      }
    });
  }
  String _selectedOption = '';

  void _showRoundDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String selectedOption = _selectedOption;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              title: const Center(child: Text('Round Tip')),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCheckboxOption('Auto', selectedOption, (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  }),
                  const Divider(),

                  _buildCheckboxOption('Up', selectedOption, (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  }),
                  const Divider(),

                  _buildCheckboxOption('Down', selectedOption, (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  }),
                ],
              ),
              actions: <Widget>[
                Center(
                  child: ElevatedButton(

                    onPressed: () {
                      setState(() {
                        _selectedOption = selectedOption;
                      });
                      Navigator.of(context).pop();
                    },

                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            ),
                      backgroundColor: Color(0xFFF6C757D),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildCheckboxOption(
      String label, String selectedOption, Function(String) onSelected) {
    return ListTile(
      leading: GestureDetector(
        onTap: () {
          onSelected(selectedOption == label ? '' : label);
        },
        child: Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            color: selectedOption == label ? Color(0xFFF13CE66) : Colors.transparent,
            border: Border.all(color:  Color(0xFFF13CE66) , width: 2),
            shape: BoxShape.circle,
          ),
          child: selectedOption == label
              ? Icon(Icons.check, color: Colors.white, size: 16)
              : null,
        ),
      ),
      title: Text(label),
      onTap: () {
        onSelected(selectedOption == label ? '' : label);
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tip Cal',
          style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontSize: 24,
              fontWeight: FontWeight.w900),
        ),
        backgroundColor: const Color(0xFFF26321),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        backgroundColor:const Color(0xFFFF6F8FC),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: <Widget>[
            const SizedBox(height: 90,),
            Container(
              child: Row(
                children: [
                  Icon(Icons.settings_outlined, size: 24, color: Color(0xFFF343A40),),
                  SizedBox(width: 5,),
                  Text("Settings", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFF343A40),
                  ),),
                ],
              ),
            ),

            SizedBox(height: 20,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: _buildDrawerItem(
                      icon: Icons.circle_outlined,
                      text: 'Round',
                      subtitle: 'How the tip should be rounded',
                      onTap: _showRoundDialog,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    color: Colors.white,
                    child: _buildDrawerItem(
                      icon: FontAwesomeIcons.message,
                      text: 'Feed Back',
                      subtitle: 'Send your feedback',
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const FeedbackScreen()),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 2,),
                  Container(
                    color: Colors.white,
                    child: _buildDrawerItem(
                      icon: Icons.info,
                      text: 'About Us',
                      subtitle: 'Learn more about us',
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const AboutUsScreen()),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 2,),
                  Container(
                    color: Colors.white,
                    child: _buildDrawerItem(
                      icon: Icons.feed_outlined,
                      text: 'Privacy Policy',
                      subtitle: 'Learn TipCal Privacy',
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
      backgroundColor: const Color(0xFFFF6F8FC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                width: isSmallScreen ? screenWidth - 32 : 250,
                height: 150,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 93,
                      width: screenWidth - screenWidth*0.45,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6F8FC),
                        border: Border.all(color: Color(0xFFFADB5BD), width: 1),
                        borderRadius: BorderRadius.circular(2)
                      ),
                      child: TextField(
                        controller: _billAmountController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '0.00',
                          hintStyle: TextStyle(color: Color(0xFFFF26321)),
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            color: Color(0xFFFF26321),
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: Text(

                        'Bill Amount',
                        style: TextStyle(

                          fontSize: isSmallScreen ? 18 : 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Percentage Tip',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (var percent in [10, 15, 20, 25, 30])
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 5.0 : 10.0),
                              child: ElevatedButton(
                                
                                onPressed: () {
                                  setState(() {
                                    _tipPercentage = percent / 100;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  fixedSize: Size(65, 50),
                                  backgroundColor: _tipPercentage == percent / 100
                                      ? const Color(0xFFFF26321)
                                      : Color(0xFFFF6F8FC),
                                  foregroundColor: _tipPercentage == percent / 100
                                      ? Color(0xFFFF6F8FC)
                                      : const Color(0xFFFF26321),
                                  side: const BorderSide(
                                      color: Color(0xFFFF26321), width: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                child: Text('$percent%',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Split By',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape: CircularSliderThumb(
                        thumbRadius: 20,
                        sliderValue: _splitBy,
                      ),
                      thumbColor:  Color(0xFFFCE4B0F),
                      activeTrackColor: Color(0xFFFF26321),
                      inactiveTrackColor: Color(0xFFFCED4DA),
                      trackHeight: 12,
                      activeTickMarkColor: Color(0xFFFF07942),
                      inactiveTickMarkColor: Color(0xFFFE9ECEF),
                      trackShape: const RectangularSliderTrackShape(),
                    ),
                    child: Slider(
                      value: _splitBy,
                      min: 1,
                      max: 10,
                      divisions: 9,
                      onChanged: (value) {
                        setState(() {
                          _splitBy = value;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Include Tax %',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Switch(
                        value: _includeTax,
                        onChanged: (value) {
                          setState(() {
                            _includeTax = value;
                          });
                        },
                        activeColor: const Color(0xFFFF5722),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: SizedBox(
                      width: screenWidth*0.5,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color:Colors.white,
                          border: Border.all(color: Color(0xFFFADB5BD)),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width:20,
                              height: 20,
                              decoration: BoxDecoration(
                                border: Border.all(color: _includeTax ? Color(0xFFF495057) :  Color(0xFFFADB5BD)),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: IconButton(
                                padding: const  EdgeInsets.all(0),
                                icon:  Icon(Icons.remove, color: _includeTax ? Color(0xFFF495057) :  Color(0xFFFADB5BD) ,size: 15,),
                                onPressed: () => adjustTaxPercentage(false),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              '${(_taxPercentage * 100).toStringAsFixed(0)}%',
                              style:  TextStyle(
                                  color: _includeTax ? Color(0xFFFF26321) :  Color(0xFFFADB5BD),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              width:20,
                              height: 20,
                              decoration: BoxDecoration(
                                  border: Border.all(color:_includeTax ? Color(0xFFF495057) :  Color(0xFFFADB5BD)),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: IconButton(
                                padding: EdgeInsets.all(0),
                                icon:  Icon(Icons.add, color: _includeTax ? Color(0xFFF495057) :  Color(0xFFFADB5BD), size: 15,),
                                onPressed: () => adjustTaxPercentage(true),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xFFFE9ECEF),width: 1),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Bill Amount',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 18 : 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFF495057),
                              ),
                            ),
                            Text(
                              double.tryParse(_billAmountController.text)?.toStringAsFixed(2) ?? '0.00',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 20 : 24,
                                fontWeight: FontWeight.w400,
                                color:Color(0xFFF495057),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2,),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Tip',
                                style: TextStyle(
                                  color: Color(0xFFF495057),
                                  fontSize: isSmallScreen ? 18 : 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Text(
                              ((double.tryParse(_billAmountController.text) ?? 0) * _tipPercentage).toStringAsFixed(2),
                              style:  TextStyle(
                                color: Color(0xFFF495057),
                                fontSize: isSmallScreen ? 20 : 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Per Person',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 18 : 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFF495057),
                              ),
                            ),
                            Text(
                              calculateTipPerPerson().toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: isSmallScreen ? 20 : 24,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFF495057),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tax',
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 18 : 20,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFF495057),
                                    ),
                                  ),

                                  Text(
                                    _includeTax ? calculateTaxAmount().toStringAsFixed(2) : "0.00",
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 20 : 24,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFF495057),
                                    ),
                                  ),
                                ],
                              ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 20 : 24,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFFF5722),
                                  ),
                                ),
                                Text(
                                  calculateTotalAmount().toStringAsFixed(2),
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 20 : 24,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFFF5722),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 2,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),

            ],
          ),
        ),
      ),

    );
  }

  Widget _buildDrawerItem(
      {required IconData icon,
        required String text,
        required String subtitle,
        required VoidCallback onTap}) {
    return ListTile(

      leading: Icon(icon, color: Colors.orange),
      title: Text(text, style: const TextStyle(color: Colors.black)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.black)),
      onTap: onTap,
    );
  }
}
