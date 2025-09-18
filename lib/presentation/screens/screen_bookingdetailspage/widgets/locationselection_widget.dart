import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:dio/dio.dart';

class LocationSearchResult {
  final String address;
  final double latitude;
  final double longitude;

  LocationSearchResult({
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

class LocationSearchScreen extends StatefulWidget {
  final String apiKey;

  const LocationSearchScreen({super.key, required this.apiKey});

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Dio _dio = Dio();
  bool _loading = false;
  List<PlacePrediction> _predictions = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _setupDio();
  }

  void _setupDio() {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _dio.close();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_searchController.text.isNotEmpty) {
      _searchPlaces(_searchController.text);
    } else {
      setState(() {
        _predictions.clear();
      });
    }
  }

  Future<void> _searchPlaces(String input) async {
    if (input.isEmpty) return;

    setState(() => _loading = true);

    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json',
        queryParameters: {
          'input': input,
          'key': widget.apiKey,
          'components': 'country:in',
          'language': 'en',
        },
      );

      if (response.statusCode == 200 && response.data['status'] == 'OK') {
        final predictions = (response.data['predictions'] as List)
            .map((pred) => PlacePrediction.fromJson(pred))
            .toList();

        setState(() {
          _predictions = predictions;
          _loading = false;
        });
      } else {
        throw Exception(
          'API Error: ${response.data['status'] ?? 'Unknown error'}',
        );
      }
    } on DioException catch (e) {
      setState(() => _loading = false);
      String errorMessage = 'Network error occurred';

      if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage =
            'Connection timeout. Please check your internet connection.';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Request timeout. Please try again.';
      } else if (e.response?.statusCode == 403) {
        errorMessage = 'API key error. Please check your Google API key.';
      }

      _showError(errorMessage);
    } catch (e) {
      setState(() => _loading = false);
      _showError("Failed to search places: $e");
    }
  }

  Future<void> _selectPlace(PlacePrediction prediction) async {
    setState(() => _loading = true);

    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/place/details/json',
        queryParameters: {
          'place_id': prediction.placeId,
          'key': widget.apiKey,
          'fields': 'geometry,formatted_address,name',
        },
      );

      if (response.statusCode == 200 && response.data['status'] == 'OK') {
        final result = response.data['result'];

        if (result['geometry'] != null) {
          final location = result['geometry']['location'];
          final lat = location['lat'].toDouble();
          final lng = location['lng'].toDouble();
          final address =
              result['formatted_address'] ??
              result['name'] ??
              prediction.description;

          setState(() => _loading = false);

          Navigator.pop(
            context,
            LocationSearchResult(
              address: address,
              latitude: lat,
              longitude: lng,
            ),
          );
        }
      } else {
        throw Exception(
          'API Error: ${response.data['status'] ?? 'Unknown error'}',
        );
      }
    } on DioException catch (e) {
      setState(() => _loading = false);
      String errorMessage = 'Failed to get place details';

      if (e.response?.statusCode == 403) {
        errorMessage =
            'API key error. Please check your Google API key permissions.';
      }

      _showError(errorMessage);
    } catch (e) {
      setState(() => _loading = false);
      _showError("Failed to get place details: $e");
    }
  }

  Future<void> _useCurrentLocation() async {
    setState(() => _loading = true);

    try {
      // Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Location permissions are permanently denied. Please enable them in settings.',
        );
      }

      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception(
          'Location services are disabled. Please enable them in settings.',
        );
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        timeLimit: const Duration(seconds: 15),
      );

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String address = "Current Location";
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        List<String?> addressParts = [
          placemark.street,
          placemark.locality,
          placemark.administrativeArea,
        ].where((e) => e != null && e.isNotEmpty).toList();

        if (addressParts.isNotEmpty) {
          address = addressParts.join(', ');
        }
      }

      setState(() => _loading = false);

      Navigator.pop(
        context,
        LocationSearchResult(
          address: address,
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    } catch (e) {
      setState(() => _loading = false);
      _showError("Failed to get current location: $e");
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.kbackgroundcolor,
      appBar: AppBar(
        title: TextStyles.subheadline(text: 'Select Location'),
        backgroundColor: Appcolors.kwhitecolor,
        foregroundColor: Appcolors.kblackcolor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Loading indicator
          if (_loading)
            const LinearProgressIndicator(color: Appcolors.kgreencolor),

          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a location...',
                prefixIcon: const Icon(Icons.search, color: Colors.blue),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _predictions.clear();
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
          ),

          // Current location button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _loading ? null : _useCurrentLocation,
                icon: const Icon(Icons.my_location),
                label: const Text("Use Current Location"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(14),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Search results
          Expanded(
            child: _predictions.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Search for a location or use current location',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: _predictions.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final prediction = _predictions[index];
                      return ListTile(
                        leading: const Icon(
                          Icons.location_on,
                          color: Colors.blue,
                        ),
                        title: Text(
                          prediction.structuredFormatting?.mainText ??
                              prediction.description,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          prediction.structuredFormatting?.secondaryText ?? '',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        onTap: () => _selectPlace(prediction),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class PlacePrediction {
  final String description;
  final String placeId;
  final StructuredFormatting? structuredFormatting;

  PlacePrediction({
    required this.description,
    required this.placeId,
    this.structuredFormatting,
  });

  factory PlacePrediction.fromJson(Map<String, dynamic> json) {
    return PlacePrediction(
      description: json['description'] ?? '',
      placeId: json['place_id'] ?? '',
      structuredFormatting: json['structured_formatting'] != null
          ? StructuredFormatting.fromJson(json['structured_formatting'])
          : null,
    );
  }
}

class StructuredFormatting {
  final String mainText;
  final String secondaryText;

  StructuredFormatting({required this.mainText, required this.secondaryText});

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) {
    return StructuredFormatting(
      mainText: json['main_text'] ?? '',
      secondaryText: json['secondary_text'] ?? '',
    );
  }
}
