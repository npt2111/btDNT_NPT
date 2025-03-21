import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 80.0, 
  fontWeight: FontWeight.bold,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 50.0, 
  fontWeight: FontWeight.w600,
);

const kButtonTextStyle = TextStyle(
  fontSize: 28.0, 
  fontFamily: 'Spartan MB',
  fontWeight: FontWeight.w500,
);

const kConditionTextStyle = TextStyle(
  fontSize: 80.0, 
  fontWeight: FontWeight.bold,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter city name...', 
  hintStyle: TextStyle(
    color: Colors.grey,
    fontSize: 18.0, 
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(12.0),
    ),
    borderSide: BorderSide.none,
  ),
);
