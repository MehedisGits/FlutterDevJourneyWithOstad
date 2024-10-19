import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glassNoTextEditingController =
      TextEditingController(text: '1');

  List<WaterTrack> waterTrackList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Tracker'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              _buildTopWidgets(),
              const SizedBox(height: 10),
              _buildWaterTrackList()
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildWaterTrackList() {
    return Expanded(
        flex: 80,
        child: ListView.separated(
          itemCount: waterTrackList.length,
          itemBuilder: (context, index) {
            final WaterTrack waterTrack = waterTrackList[index];
            return ListTile(
              title: Text(
                  '${waterTrack.dateTime.hour}:${waterTrack.dateTime.minute}'),
              subtitle: Text(
                  '${waterTrack.dateTime.day}/${waterTrack.dateTime.month}/${waterTrack.dateTime.year}'),
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('${waterTrack.noOfGlass}', style: const TextStyle(color: Colors.white),),
              ),
              trailing: TextButton(
                  onPressed: () {
                    _onTapDeleteButton(index);
                  },
                  child: const Icon(Icons.delete, color: Colors.blue,)),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
  }

  Expanded _buildTopWidgets() {
    return Expanded(
      flex: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            getTotalGlassCount().toString(),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Glass/s",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 70,
                    child: TextFormField(
                      controller: _glassNoTextEditingController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Number of Glass')),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 20,
                    child: ElevatedButton(
                      onPressed: _onTapAddNewWaterTrack,
                      style: customButtonStyle(),
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  int getTotalGlassCount() {
    int counter = 0;
    for (WaterTrack t in waterTrackList) {
      counter += t.noOfGlass;
    }
    return counter;
  }

  void _onTapAddNewWaterTrack() {
    if (_glassNoTextEditingController.text.isEmpty) {
      _glassNoTextEditingController.text = '1';
    }
    int noOfGlasses = int.tryParse(_glassNoTextEditingController.text) ?? 1;

    WaterTrack waterTrack =
        WaterTrack(noOfGlass: noOfGlasses, dateTime: DateTime.now());
    waterTrackList.add(waterTrack);
    setState(() {});
  }

  void _onTapDeleteButton(int index) {
    waterTrackList.removeAt(index);
    setState(() {});
  }

  ButtonStyle customButtonStyle() {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 4),
      backgroundColor: Colors.blue, // Button color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6), // Rounded corners
      ),
    );
  }
}

class WaterTrack {
  final int noOfGlass;
  final DateTime dateTime;

  WaterTrack({required this.noOfGlass, required this.dateTime});
}
