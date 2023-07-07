abstract class FlutterBaseWidgetData {
  WidgetEnum? type;
  WidgetFamilyEnum? family;

  FlutterBaseWidgetData({
    this.type,
    this.family,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type?.name ?? "";
    data['family'] = family?.name ?? "";
    return data;
  }
}

enum WidgetEnum {
  time,
  photo,
  weather,
}

enum WidgetFamilyEnum {
  systemSmall,
  systemMedium,
  systemLarge,
  systemExtraLarge,
  accessoryCorner,
  accessoryCircular,
  accessoryRectangular,
  accessoryInline,
}

extension WidgetEnumExtension on WidgetEnum {
  String get name {
    switch (this) {
      case WidgetEnum.time:
        return "time";
      case WidgetEnum.photo:
        return "photo";
      case WidgetEnum.weather:
        return "weather";
    }
  }
}

extension WidgetFamilyEnumExtension on WidgetFamilyEnum {
  String get name {
    switch (this) {
      case WidgetFamilyEnum.systemSmall:
        return "systemSmall";
      case WidgetFamilyEnum.systemMedium:
        return "systemMedium";
      case WidgetFamilyEnum.systemLarge:
        return "systemLarge";
      case WidgetFamilyEnum.systemExtraLarge:
        return "systemExtraLarge";
      case WidgetFamilyEnum.accessoryCorner:
        return "accessoryCorner";
      case WidgetFamilyEnum.accessoryCircular:
        return "accessoryCircular";
      case WidgetFamilyEnum.accessoryRectangular:
        return "accessoryRectangular";
      case WidgetFamilyEnum.accessoryInline:
        return "accessoryInline";
    }
  }
}

class FlutterTimeWidgetData extends FlutterBaseWidgetData {
  String? time;

  FlutterTimeWidgetData({
    this.time,
    super.family,
  }) : super(type: WidgetEnum.time);

  FlutterTimeWidgetData.fromJson(Map<String, dynamic> json) {
    type =
        WidgetEnum.values.firstWhere((element) => element.name == json['type']);
    family = WidgetFamilyEnum.values
        .firstWhere((element) => element.name == json['family']);
    time = json['time'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['time'] = time ?? "";
    return data;
  }
}

class FlutterPhotoWidgetData extends FlutterBaseWidgetData {
  String? photo;

  FlutterPhotoWidgetData({
    this.photo,
    super.family,
  }) : super(type: WidgetEnum.photo);

  FlutterPhotoWidgetData.fromJson(Map<String, dynamic> json) {
    type =
        WidgetEnum.values.firstWhere((element) => element.name == json['type']);
    family = WidgetFamilyEnum.values
        .firstWhere((element) => element.name == json['family']);
    photo = json['photo'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['photo'] = photo ?? "";
    return data;
  }
}

class FlutterWeatherWidgetData extends FlutterBaseWidgetData {
  String? weather;

  FlutterWeatherWidgetData({
    this.weather,
    super.family,
  }) : super(type: WidgetEnum.weather);

  FlutterWeatherWidgetData.fromJson(Map<String, dynamic> json) {
    type =
        WidgetEnum.values.firstWhere((element) => element.name == json['type']);
    family = WidgetFamilyEnum.values
        .firstWhere((element) => element.name == json['family']);
    weather = json['weather'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['weather'] = weather ?? "";
    return data;
  }
}
