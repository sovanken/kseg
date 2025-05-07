import 'package:flutter/material.dart';
import 'package:kseg/kseg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KSeg Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _inputText = 'តេស្តTest អក្សរខ្មែរ Latin script';

  @override
  void initState() {
    super.initState();
    _controller.text = _inputText;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KSeg Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text input field
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter mixed text',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _inputText = value;
                });
              },
            ),
            const SizedBox(height: 24.0),

            // Example 1: Basic usage with system fonts
            _buildExampleSection(
              'Basic Usage with System Fonts',
              Kseg(
                text: _inputText,
                khFont: 'Battambang',
                latinFont: 'Roboto',
                khFontSize: 20,
                latinFontSize: 16,
                khUseGoogleFont: false,
                latinUseGoogleFont: false,
              ),
            ),

            // Example 2: Using Google Fonts
            _buildExampleSection(
              'Using Google Fonts',
              Kseg(
                text: _inputText,
                khFont: 'Battambang',
                latinFont: 'Roboto',
                khFontSize: 20,
                latinFontSize: 16,
                // Google Fonts is used by default (khUseGoogleFont and latinUseGoogleFont default to true)
              ),
            ),

            // Example 3: Styling with colors
            _buildExampleSection(
              'Styling with Colors',
              Kseg(
                text: _inputText,
                khFont: 'Battambang',
                latinFont: 'Lato',
                khFontSize: 22,
                latinFontSize: 18,
                khColor: Colors.blue.shade800,
                latinColor: Colors.orange.shade800,
                khFontWeight: FontWeight.bold,
                latinFontWeight: FontWeight.normal,
              ),
            ),

            // Example 4: Advanced styling
            _buildExampleSection(
              'Advanced Styling',
              Kseg(
                text: _inputText,
                khFont: 'Moul',
                latinFont: 'Roboto Mono',
                khFontSize: 20,
                latinFontSize: 16,
                khColor: Colors.deepPurple,
                latinColor: Colors.teal,
                khLetterSpacing: 1.2,
                latinLetterSpacing: 0.5,
                khHeight: 1.5,
                latinHeight: 1.3,
                khBackgroundColor: Colors.yellow.shade100,
                latinBackgroundColor: Colors.blueGrey.shade50,
              ),
            ),

            // Example 5: Text decoration
            _buildExampleSection(
              'Text Decoration',
              Kseg(
                text: _inputText,
                khFont: 'Battambang',
                latinFont: 'Open Sans',
                khFontSize: 20,
                latinFontSize: 16,
                khDecoration: TextDecoration.underline,
                khDecorationColor: Colors.red,
                khDecorationThickness: 2.0,
                latinDecoration: TextDecoration.overline,
                latinDecorationColor: Colors.green,
                latinDecorationStyle: TextDecorationStyle.wavy,
              ),
            ),

            // Script detection information
            const SizedBox(height: 32.0),
            const Text(
              'Script Detection Info:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildScriptInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleSection(String title, Widget example) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: example,
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }

  Widget _buildScriptInfo() {
    final segmented = TextSegmenter.segment(_inputText);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Number of segments: ${segmented.segmentCount}'),
          const SizedBox(height: 8.0),
          const Text('Segments:'),
          const SizedBox(height: 4.0),
          ...segmented.segments.map((segment) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(4.0),
                color:
                    segment.isKhmer
                        ? Colors.blue.withOpacity(0.1)
                        : segment.isLatin
                        ? Colors.green.withOpacity(0.1)
                        : Colors.orange.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Script: ${segment.scriptType}'),
                  Text('Text: "${segment.text}"'),
                  Text('Range: ${segment.startIndex}-${segment.endIndex}'),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
