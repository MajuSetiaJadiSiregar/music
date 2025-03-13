part of 'widgets.dart';

class Label extends StatelessWidget {
  final String label;
  final String color;
  final String fontFamily;
  final double fontSize;
  final int fontWeight;

  const Label({super.key, this.label = "value text is null", this.color = "#000000",this.fontFamily = "PoppinsThin", this.fontSize = 12.0, this.fontWeight = 1});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.values[fontWeight],
        fontSize: fontSize,
        fontFamily: fontFamily,
        color: HexColor(color) ,
      ),
    );
  }

}