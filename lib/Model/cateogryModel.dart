import 'package:flutter/material.dart';

class Category {
  String name;
  AssetImage image;

  Category({
    @required this.name,
    @required this.image,
  });
}

List<Category> categoryList = [
  Category(
    image: AssetImage("assets/image/abstract.jpg"),
    name: "Abstract",
  ),
  Category(
    image: AssetImage("assets/image/animal.jpg"),
    name: "Animals",
  ),
  Category(
    image: AssetImage("assets/image/car.jpg"),
    name: "Cars",
  ),
  Category(
    image: AssetImage("assets/image/city.jpg"),
    name: "City",
  ),
  Category(
    image: AssetImage("assets/image/landscape.jpg"),
    name: "Landscape",
  ),
  Category(
    image: AssetImage("assets/image/minimalist.jpg"),
    name: "Minimalist",
  ),
  Category(
    image: AssetImage("assets/image/nature.jpg"),
    name: "Nature",
  ),
  Category(
    image: AssetImage("assets/image/space.jpg"),
    name: "Space",
  ),
  Category(
    image: AssetImage("assets/image/sport.jpg"),
    name: "Sport",
  ),
  Category(
    image: AssetImage("assets/image/fashion.jpg"),
    name: "Fashion",
  ),
  Category(
    image: AssetImage("assets/image/people.jpg"),
    name: "People",
  ),
  Category(
    image: AssetImage("assets/image/food.jpg"),
    name: "Food",
  ),
  Category(
    image: AssetImage("assets/image/flower.jpg"),
    name: "flower",
  ),
  Category(
    image: AssetImage("assets/image/man.jpg"),
    name: "Man",
  ),
  Category(
    image: AssetImage("assets/image/women.jpg"),
    name: "Woman",
  ),
  Category(
    image: AssetImage("assets/image/art.jpg"),
    name: "Art",
  ),
  Category(
    image: AssetImage("assets/image/technology.jpg"),
    name: "Technology",
  ),
  Category(
    image: AssetImage("assets/image/fitness.jpg"),
    name: "Fitness",
  ),
];

List<Category> liveCategoryList = [
  Category(
    image: AssetImage("assets/image/live_nature.jpg"),
    name: "Nature",
  ),
  Category(
    image: AssetImage("assets/image/live_abstract.jpg"),
    name: "Abstract",
  ),
  Category(
    image: AssetImage("assets/image/live_technology.jpg"),
    name: "Technology",
  ),
  Category(
    image: AssetImage("assets/image/live_animation.jpg"),
    name: "Animation",
  )
];
