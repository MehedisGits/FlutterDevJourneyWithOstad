import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glassNoTEController =
      TextEditingController(text: '1');
  List<WaterTrack> waterTrackList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          'Water Tracker',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildWaterTrackCounter(),
            Expanded(child: _buildWaterTrackListView())
          ],
        ),
      ),
    );
  }

  ListView _buildWaterTrackListView() {
    return ListView.separated(
      itemCount: waterTrackList.length,
      itemBuilder: (context, index) {
        WaterTrack waterTrack = waterTrackList[index];
        return ListTile(
          title:
              Text('${waterTrack.dateTime.hour}:${waterTrack.dateTime.minute}'),
          subtitle: Text(
              '${waterTrack.dateTime.day}/${waterTrack.dateTime.month}/${waterTrack.dateTime.year}'),
          // Or remove this line if no date
          leading: CircleAvatar(
            child: Text('${waterTrack.numOfGlass}'),
          ),
          trailing: IconButton(
              onPressed: () => _onTapDeleteBtn(index),
              icon: Icon(Icons.delete)),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildWaterTrackCounter() {
    return Column(
      children: [
        Text(
          getTotalGlassCount().toString(),
          style: const TextStyle(fontSize: 24, color: Colors.black),
        ),
        const Text(
          'Glass/s',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
              width: 100,
              child: TextField(
                controller: _glassNoTEController,
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  _addNewWaterTrack();
                },
                child: Text('Add')),
          ],
        ),
        SizedBox(
          height: 24,
        ),
      ],
    );
  }

  int getTotalGlassCount() {
    int counter = 0;
    // Loops through the list and adds up all the glasses
    for (WaterTrack t in waterTrackList) {
      counter += t.numOfGlass;
    }
    return counter;
  }

  void _addNewWaterTrack() {
    // Ensures there's a default value of '1' glass if the input is empty
    if (_glassNoTEController.text.isEmpty) {
      _glassNoTEController.text = '1';
    }
    // Tries to convert the text to an integer
    final int numOfGlasses = int.tryParse(_glassNoTEController.text) ?? 1;

    // Creates a new water track entry with the current time
    WaterTrack waterTrack = WaterTrack(
      numOfGlass: numOfGlasses,
      dateTime: DateTime.now(),
    );

    // Adds the entry to the list and updates the UI
    setState(() {
      waterTrackList.add(waterTrack);
    });
  }

  void _onTapDeleteBtn(int index) {
    waterTrackList.removeAt(index);
    setState(() {});
  }
}

class WaterTrack {
  final int numOfGlass;
  final DateTime dateTime;

  WaterTrack({required this.numOfGlass, required this.dateTime});
}
