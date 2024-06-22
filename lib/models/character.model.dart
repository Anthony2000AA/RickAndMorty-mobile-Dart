//entity to represent a character
class ApiResponse{
  final Info info;
  final List<Character> results;

  const ApiResponse({
    required this.info,
    required this.results
  });

  ApiResponse.fromJson(Map<String, dynamic> json)
    : info = Info.fromJson(json['info']),
      results = List<Character>.from(json['results'].map((character) => Character.fromJson(character)));

}


class Info{

  final int count;
  final int pages;
  final String ?next;
  final String ?prev;

  const Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev
  });

  Info.fromJson(Map<String, dynamic> json)
    : count = json['count'],
      pages = json['pages'],
      next = json['next'],
      prev = json['prev'];


}

class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  //final Origin origin;
 // final Location location;
  final String image;
  //final List<String> episode;
  final String url;
  final String created;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
   // required this.origin,
   // required this.location,
    required this.image,
   // required this.episode,
    required this.url,
    required this.created
  });

  Character.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      status = json['status'],
      species = json['species'],
      type = json['type'],
      gender=json['gender'],
      //origin =  Origin.fromJson(json['origin']),
     // location =  Location.fromJson(json['location']),
      image = json['image'],
     // episode = List<String>.from(json['episode']),
      url = json['url'],
      created = json['created'];


  Map<String, dynamic> toMap(){
    return {
      //guardar todos los campos
      "id"  : id,
      "name" : name,
      "status" : status,
      "species" : species,
      "type" : type,
      "gender": gender,
      "image" : image,
      "url" : url,
      "created" : created

    };
  }


}

class Origin {
  final String name;
  final String url;

  const Origin({
    required this.name,
    required this.url
  });

  Origin.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      url = json['url'];
}


class Location {
  final String name;
  final String url;

  const Location({
    required this.name,
    required this.url
  });

  Location.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      url = json['url'];


}

