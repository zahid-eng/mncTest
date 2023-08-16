import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:mnctest/constant/constant.dart';

class BackgroundDesign extends StatelessWidget {
  const BackgroundDesign({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          color: Colors.white,
          height: size.height * 0.5,
          child: Stack(
            children: [
              Positioned(
                left: 20,
                top: 10,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // ClayContainer(
                    //   height: size.height * 0.25,
                    //   width: size.width * 0.6,
                    //   color: Colors.white,
                    //   borderRadius: 60,
                    //   depth: -50,
                    //   curveType: CurveType.convex,
                    // ),
                    // ClayContainer(
                    //   height: size.height * 0.2,
                    //   width: size.width * 0.5,
                    //   color: Colors.white,
                    //   borderRadius: 60,
                    //   depth: 50,
                    // ),

                    // ClayContainer(
                    //   height: 180,
                    //   width: 180,
                    //   color: Colors.white,
                    //   borderRadius: 200,
                    //   depth: 50,
                    // ),
                    // ClayContainer(
                    //   height: 140,
                    //   width: 140,
                    //   color: Colors.white,
                    //   borderRadius: 200,
                    //   depth: -50,
                    //   curveType: CurveType.convex,
                    // ),
                    // ClayContainer(
                    //   height: 100,
                    //   width: 100,
                    //   color: Colors.white,
                    //   borderRadius: 200,
                    //   depth: 50,
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
