//temp waifu model, will be replaced by actual mongodb model soon

class Waifu {
  final int id;
  final int likes;
  final int comments;
  final String name;
  final String anime;
  final String description;
  final String image;

  const Waifu({this.id, this.likes,this.comments,this.name, this.anime, this.description, this.image});
}

// dummy data - to be replaced with actual db data
List<Waifu> waifuList = [
  const Waifu(
    id: 1,
    likes: 20,
    comments: 15,
    name: "Waifu1",
    anime: "Anime1",
    description: "Lorem ipsum...",
    image: "assets/img/waifu1.png",
  ),
  const Waifu(
    id: 2,
    likes: 10,
    comments: 13,
    name: "Waifu2",
    anime: "Anime2",
    description: "Lorem ipsum...",
    image: "assets/img/waifu2.png",
  ),
  const Waifu(
    id: 3,
    likes: 90,
    comments: 19,
    name: "Waifu3",
    anime: "Anime3",
    description: "Lorem ipsum...",
    image: "assets/img/waifu3.png",
  ),
  const Waifu(
    id: 4,
    likes: 80,
    comments: 19,
    name: "Waifu4",
    anime: "Anime4",
    description: "Lorem ipsum...",
    image: "assets/img/waifu4.png",
  ),
  const Waifu(
    id: 5,
    likes: 78,
    comments: 90,
    name: "Waifu5",
    anime: "Anime5",
    description: "Lorem ipsum...",
    image: "assets/img/waifu5.png",
  ),
];
