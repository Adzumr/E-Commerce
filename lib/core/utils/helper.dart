import '../../models/welcome_model.dart';
import 'app_assets.dart';

class Helper {
  static List<IntroductionMessage> introductionMessges = [
    IntroductionMessage(
      image: AppAssets.logo,
      title: "Discover a New Way to Shop",
      subtitle:
          "Welcome to the future of online commerce! The Immersive Commerce App on Web 3.0 is your gateway to a revolutionary shopping experience. Discover a diverse range of products from our decentralized marketplace, where innovation meets convenience. Whether you're looking for the latest gadgets, trendy fashion, or unique handmade crafts, we have it all.",
    ),
    IntroductionMessage(
      image: AppAssets.logo,
      title: "Dive into Product Details Seamlessly",
      subtitle:
          "Immerse yourself in the world of each product with our intuitive navigation. Effortlessly browse through product listings and dive into comprehensive details by tapping on any item. From detailed descriptions and specifications to user reviews, every piece of information is at your fingertips. Experience a new level of engagement as you explore the products that match your style and preferences.",
    ),
    IntroductionMessage(
      image: AppAssets.logo,
      title: "Personalize Your Shopping Journey",
      subtitle:
          "Make the Immersive Commerce App truly yours! Create an account to unlock personalized features such as favoriting products with a simple tap. Stay effortlessly logged in across devices, ensuring a seamless shopping experience every time you open the app. Manage your profile to keep your information up-to-date, and let us enhance your shopping journey with tailored recommendations",
    ),
  ];
}
