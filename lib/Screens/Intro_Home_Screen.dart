import 'package:flutter/material.dart';

class IntroHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBanner(),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Explore the following features:',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildHorizontalImageScroller(),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      'Essential Health Insights',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildHealthInsightCard(
                    context,
                    'Hypertension',
                    'A comprehensive guide on what high blood pressure is, its causes, symptoms, and how to manage it through lifestyle changes, medication, and regular monitoring.',
                    'https://d2jx2rerrg6sh3.cloudfront.net/images/Article_Images/ImageForArticle_87_16624305564314755.jpg',
                  ),
                  _buildHealthInsightCard(
                    context,
                    'Diabetes Management 101',
                    'Detailed information on the different types of diabetes (Type 1 and Type 2), their symptoms, and effective strategies for managing blood sugar levels, including diet and exercise tips.',
                    'https://www.apollospectra.com/backend/web/blog-images/1717049894symptoms-of-diabetes.webp',
                  ),
                  _buildHealthInsightCard(
                    context,
                    'Heart Health',
                    'Information on common heart diseases, their risk factors, preventive measures, and lifestyle changes to promote cardiovascular health.',
                    'https://p7.hiclipart.com/preview/986/835/829/clip-art-coronary-artery-disease-myocardial-infarction-heart-heart.jpg',
                  ),
                  _buildHealthInsightCard(
                    context,
                    'Cancer Awareness and Prevention',
                    'Educational content on various types of cancer, their risk factors, early detection methods, and ways to reduce your risk through lifestyle changes and screenings.',
                    'https://d3b6u46udi9ohd.cloudfront.net/wp-content/uploads/2022/03/21075108/Types-of-blood-cancer_11zon.jpg',
                  ),
                  _buildHealthInsightCard(
                    context,
                    'Mental Health Awareness',
                    'Articles and videos explaining common mental health disorders, their symptoms, treatment options, and coping strategies.',
                    'https://media.npr.org/assets/img/2013/12/30/13-21664-large-50924dc406b2941ff1d495e1f732be8a36ec9342.jpg',
                  ),
                  _buildHealthInsightCard(
                    context,
                    'Chronic Pain Management',
                    'Tips and techniques for managing chronic pain conditions, including medication, physical therapy, and alternative treatments.',
                    'https://www.frontiersin.org/files/Articles/779328/fpubh-09-779328-HTML/image_m/fpubh-09-779328-g001.jpg',
                  ),
                  _buildHealthInsightCard(
                    context,
                    'Respiratory Health',
                    'Insights into respiratory conditions like asthma and COPD, including symptoms, triggers, and management strategies.',
                    'https://www.cnet.com/a/img/resize/52f68aabd844f167ca0f883242d3a8e863394ddf/hub/2022/10/03/891acb12-5107-48b8-90a4-88e9aa135216/gettyimages-1251244145.jpg?auto=webp&width=1200',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://www.way2smile.ae/blog/wp-content/uploads/2018/11/blogbg.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Center(
        child: Text(
          'Welcome to HealthVista',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black.withOpacity(0.5),
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHealthInsightCard(
    BuildContext context,
    String title,
    String description,
    String imageUrl,
  ) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalImageScroller() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildImageItem('assets/img/running.jpg', 'Running', 'Stay fit with regular running exercises.'),
          _buildImageItem('assets/img/sleep.jpg', 'Sleep Tracking', 'Monitor your sleep patterns for better health.'),
          _buildImageItem('assets/img/heart-rate.jpg', 'Heart Rate', 'Keep track of your heart health with precision.'),
          _buildImageItem('assets/img/bmi.jpg', 'BMI Calculator', 'Calculate your Body Mass Index accurately.'),
          _buildImageItem('assets/img/distance.jpg', 'Distance Measurement', 'Measure distances effectively for your activities.'),
        ],
      ),
    );
  }

  Widget _buildImageItem(String imageUrl, String label, String description) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      width: 300,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
