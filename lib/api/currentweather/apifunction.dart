import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/core/constant.dart';
import 'package:weatherapp/presentation/homescreen.dart'; 



getcurrentweather(Position position)async{
  final response = await http.get(Uri.parse('${domain}lat=${position.latitude}&lon=${position.longitude}&appid=$api'));
  if(response.statusCode == 200){
    
    final data = response.body;
    final decodeddata = jsonDecode(data);
    await updateui(decodeddata);
    print(data);
  }else{
    print(response.statusCode);
  }
}

getcityweather(String name)async{
  final response = await http.get(Uri.parse('${domain}q=${name}&appid=${api}'));
  if(response.statusCode == 200){
    final data = response.body;
    final decodeddata = jsonDecode(data);
    await updateui(decodeddata);
    print(data);
    
  }else{
    print(response.statusCode);
  }
}

updateui(var data){
temp = data['main']['temp']-273;
pressure = data['main']['pressure'];
humidity = data['main']['humidity'];
cloud = data['clouds']['all'];
cityname = data['name'];


}