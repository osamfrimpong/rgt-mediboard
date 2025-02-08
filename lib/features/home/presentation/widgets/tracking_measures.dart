import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/medical_data.dart';
import 'package:dots_indicator/dots_indicator.dart';


class TrackingMeasuresSlider extends StatefulWidget {
  final List<TrackingMeasure> measures;

  const TrackingMeasuresSlider({
    super.key,
    required this.measures,
  });

  @override
  State<TrackingMeasuresSlider> createState() => _TrackingMeasuresSliderState();
}

class _TrackingMeasuresSliderState extends State<TrackingMeasuresSlider> {
  final PageController _pageController =
      PageController(viewportFraction: 0.7, initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.toInt() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Tracking measures',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 250,
          child: PageView.builder(
            padEnds: false,
            controller: _pageController,
            itemCount: widget.measures.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TrackingMeasureCard(
                  measure: widget.measures[index],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        DotsIndicator(
          dotsCount: widget.measures.length,
          position: _currentPage,
          decorator: DotsDecorator(
            activeColor: Colors.deepPurple,
            size: const Size.square(8.0),
            activeSize: const Size.square(8.0),
            spacing: const EdgeInsets.all(4),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class TrackingMeasureCard extends StatelessWidget {
  final TrackingMeasure measure;

  const TrackingMeasureCard({
    super.key,
    required this.measure,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Text(
              measure.type == 'Range'
                  ? DateFormat('dd MMM yyyy').format(measure.date)
                  : '${DateTime.now().difference(measure.date).inDays.toString()} days ago',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      measure.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      measure.type == "Range"
                          ? "${measure.value} ${measure.unit}"
                          : "",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: measure.rating == "Off Track"
                              ? Colors.red
                              : Colors.green),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: measure.rating == "Off Track"
                            ? Colors.red[100]
                            : Colors.green[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        measure.rating,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: measure.rating == "Off Track"
                              ? Colors.red[900]
                              : Colors.green[900],
                        ),
                      ),
                    ),
                  ],
                ),
                ...measure.type == "Fixed"
                    ? [
                        Text.rich(
                          textAlign: TextAlign.left,
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "${measure.value} ",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: measure.unit,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.settings,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              measure.provider,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            Spacer(),
                            if (measure.extraValue != 0)
                              Text(
                                "+${measure.extraValue} Record${measure.extraValue == 1 ? "" : "s"}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.purple),
                              ),
                          ],
                        ),
                      ]
                    : [
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            valueIndicatorColor: Colors.red,
                            valueIndicatorTextStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          child: Slider(
                            value: measure.value,
                            min: 0,
                            max: 2000,
                            label: measure.value.round().toString(),
                            onChanged: (double newValue) {
                             
                            },
                          ),
                        ),
                        Text(
                          measure.provider,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[800]),
                        )
                      ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
