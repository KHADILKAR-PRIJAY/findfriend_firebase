import 'package:find_friend/models/filter_model.dart';
import 'package:find_friend/services/fetch_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';

class Men extends StatefulWidget {
  final String userid;
  Men({required this.userid});
  @override
  _MenState createState() => _MenState();
}

class _MenState extends State<Men> {
  bool ageSwitch = false;
  bool distanceSwitch = false;
  int _value = 4;
  RangeValues ageBetween = RangeValues(0, 30);

  String countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  String address = "";
  late Future<FilterModel> filtermodel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Age',
                  style: TextStyle(color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Between ${ageBetween.start.round().toString()} & ${ageBetween.end.round().toString()}'),
                ),
                RangeSlider(
                  activeColor: Color(0xff2596BE),
                  inactiveColor: Colors.grey,
                  values: ageBetween,
                  divisions: 3,
                  min: 0,
                  max: 100,
                  //divisions: 5,
                  labels: RangeLabels(
                    ageBetween.start.round().toString(),
                    ageBetween.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      ageBetween = values;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('See people 2 years either side if I run out'),
                      Transform.scale(
                        scale: 0.5,
                        child: CupertinoSwitch(
                            activeColor: Color(0xff2596BE),
                            value: ageSwitch,
                            onChanged: (value) {
                              setState(() {
                                ageSwitch = value;
                              });
                            }),
                      )
                    ],
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Distance',
                  style: TextStyle(color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Up to ${_value.round().toString()} kilometers away'),
                ),
                Slider(
                  value: _value.toDouble(),
                  min: 0,
                  divisions: 100,
                  max: 100,
                  label: '$_value',
                  activeColor: Color(0xff2596BE),
                  inactiveColor: Colors.grey,
                  onChanged: (newvalue) {
                    setState(() {
                      _value = newvalue.round();
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('See people slightly further away if I run out'),
                      Transform.scale(
                        scale: 0.5,
                        child: CupertinoSwitch(
                            activeColor: Color(0xff2596BE),
                            value: distanceSwitch,
                            onChanged: (value) {
                              setState(() {
                                distanceSwitch = value;
                              });
                            }),
                      )
                    ],
                  ),
                )
              ],
            ),
            CSCPicker(
              ///Enable disable state dropdown [OPTIONAL PARAMETER]
              showStates: true,

              /// Enable disable city drop down [OPTIONAL PARAMETER]
              showCities: true,

              ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
              flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,

              ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
              dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.grey,
                  border: Border.all(color: Colors.grey.shade300, width: 1)),

              ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
              disabledDropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.grey.shade300,
                  border: Border.all(color: Colors.grey.shade300, width: 1)),

              ///selected item style [OPTIONAL PARAMETER]
              selectedItemStyle: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),

              ///DropdownDialog Heading style [OPTIONAL PARAMETER]
              dropdownHeadingStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),

              ///DropdownDialog Item style [OPTIONAL PARAMETER]
              dropdownItemStyle: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),

              ///Dialog box radius [OPTIONAL PARAMETER]
              dropdownDialogRadius: 10.0,

              ///Search bar radius [OPTIONAL PARAMETER]
              searchBarRadius: 10.0,

              ///Default Country [OPTIONAL PARAMETER]
              defaultCountry: DefaultCountry.India,

              ///triggers once country selected in dropdown
              onCountryChanged: (value) {
                setState(() {
                  ///store value in country variable
                  countryValue = value;
                });
              },

              ///triggers once state selected in dropdown
              onStateChanged: (value) {
                setState(() {
                  ///store value in state variable
                  stateValue = value;
                });
              },

              ///triggers once city selected in dropdown
              onCityChanged: (value) {
                setState(() {
                  ///store value in city variable
                  cityValue = value;
                });
              },
            ),
            SizedBox(height: 40),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(height: 30, width: 100),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    filtermodel = FilterServices.getFilter(
                        city: cityValue.toString(),
                        interested: 'men',
                        maxage: ageBetween.end.round().toString(),
                        minage: ageBetween.start.round().toString(),
                        userid: widget.userid);
                    Navigator.pop(context);
                  });
                },
                child: Text(
                  'Apply',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                style: ButtonStyle(
                  elevation: null,
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          side: BorderSide(color: Colors.black))),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF2596BE),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
