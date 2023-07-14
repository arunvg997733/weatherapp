import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/api/currentweather/apifunction.dart';
import 'package:weatherapp/core/constant.dart';

bool isloaded = false;
  num? temp;
  num? pressure;
  num? humidity;
  num? cloud;
  String? cityname;


class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController citytcr = TextEditingController();
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkpermision();
    
  }

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      body: SafeArea(child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
            Color(0xffA9C9FF),
            Color(0xffFFBBEC)
          ])
        ),
        child: Visibility(
          visible:isloaded,
          replacement: Center(child: CircularProgressIndicator()),
          child:  Padding(
            padding:  EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CupertinoSearchTextField(
                    controller: citytcr,
                    backgroundColor: Colors.grey,
                    itemColor: Colors.white,
                    placeholderStyle: TextStyle(color: Colors.white),
                    style: TextStyle(color: Colors.black),
                  )),
                  kheight20,
                  ElevatedButton(onPressed: () {
                    checkcityname(citytcr.text);
                  }, child: Text('Submit')),
                  kheight20 ,
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(child: Text('City - ${cityname}')),
                  ),
                  kheight,
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(child: Text('Temperature - ${temp?.toInt().toString()} °C')),
                  ),
                  kheight,
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(child: Text('Pressure - ${pressure?.toInt().toString()} hPa')),
                  ),
                  kheight,
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(child: Text('Humidity - ${humidity?.toInt().toString()}%')),
                  ),
                  kheight,
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(child: Text('Cloud Cover - ${cloud?.toInt().toString()}%')),
                  ),
                  
                  
                 
              ],
            ),
          ),
          ),
      )),
    );
  }

  getcurrentlocation()async{
  var position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.low,
    forceAndroidLocationManager: true
  );

  if(position != null){
    print("lati = ${position.latitude},log - ${position.longitude}");
  }else{
    print('data unvailable');
  }

  await getcurrentweather(position);
  setState(() {
    isloaded = true;
  });
  

}

checkcityname(String name)async{
  await getcityweather(name);
  setState(() {
    
  });
  
}

checkpermision()async{
  LocationPermission permission = await Geolocator.checkPermission();
  if(permission == LocationPermission.denied){
    permission = await Geolocator.requestPermission();
    
  }else{
    getcurrentlocation();
  }
}


}







