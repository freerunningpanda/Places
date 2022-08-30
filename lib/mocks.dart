import 'package:flutter/material.dart';
import 'package:places/data/sight.dart';
import 'package:places/ui/res/app_strings.dart';

abstract class Mocks {
  static const mockLat = 55.910493;
  static const mockLot = 37.736423;

  static final List<String> types = [];

  static final List<Sight> mocks = [
    Sight(
      name: 'Мытищинский парк',
      lat: 55.911397,
      lon: 37.740033,
      url: 'https://pic.rutubelist.ru/video/39/09/390905576c021a02b5b57c374ba16621.jpg',
      details: 'Мытищинский парк — центральный парк в одноименном городе Московской области.',
      type: AppString.park,
    ),
    Sight(
      name: 'Воронцовский дворец',
      lat: 44.419881,
      lon: 34.055799,
      url: 'https://core-pht-proxy.maps.yandex.ru/v1/photos/download?photo_id=deRmH1T9ukwAqPbuaHG6FQ&image_size=XXL',
      details:
          'Парк на территории Алупки. Памятник садово-паркового искусства, основан в первой половине XIX века под руководством немецкого садовника Карла Кебаха. Составляет единый ансамбль с Воронцовским дворцом.',
      type: AppString.park,
    ),
    Sight(
      name: 'Мытищинский историко-художественный музей',
      lat: 55.911355,
      lon: 37.735425,
      url: 'https://mytyshimuseum.ru/wp-content/uploads/Zal-19-vek-2-1.jpeg',
      details: 'Центральный музей городского округа Мытищи. Открыт в 1962 году.',
      type: AppString.museum,
    ),
    Sight(
      name: 'Папа Джонс',
      lat: 55.908155,
      lon: 37.730916,
      url: 'https://avatars.mds.yandex.net/get-altay/4398559/2a00000181b14c1ff7099db35afff1bef259/XXXL',
      details:
          'Пиццерия. Предзаказ онлайн, оплата картой, еда навынос, средний счёт 600–1200 ₽, доставка еды. Цены: средние.',
      type: AppString.cafe,
    ),
    Sight(
      name: 'Якитория',
      lat: 55.917942,
      lon: 37.725245,
      url: 'https://static.yakitoriya.ru/media/cache/60/15/60158655420e2922294478c35d86ba77.png',
      details:
          'Летняя веранда, доставка еды, роллы филадельфия от 537 ₽, бесплатная доставка, оплата картой, доставка, Wi-Fi, еда навынос, детское меню, средний счёт от 1500 ₽, детская комната..',
      type: AppString.restaurant,
    ),
    Sight(
      name: 'Lecco',
      lat: 55.907089,
      lon: 37.718347,
      url:
          'https://cf.bstatic.com/xdata/images/hotel/max1280x900/33106839.jpg?k=6b68980e0b040d0e675237bb26a2f08ce9cc2db5cf404ed965edc5c585240b37&o=&hp=1',
      details:
          'Отель Lecco расположен в тихом жилом районе, менее чем в 3 км от центра Мытищ и всего в 40 минутах езды от аэропорта Шереметьево. Кроме того, в отеле работает оздоровительный центр и салон красоты.',
      type: AppString.hotel,
    ),
    Sight(
      name: '13-й микрорайон',
      lat: 55.903283,
      lon: 37.714688,
      url: 'https://core-pht-proxy.maps.yandex.ru/v1/photos/download?photo_id=BavQsmxTMiOC0OpsXpM1Rg&image_size=XXXL',
      details: 'Ограничен улицей Сукромка, улицей Благовещенская, рекой Яуза',
      type: AppString.particularPlace,
    ),
  ];

  static double startPoint = 2000;
  static double endPoint = 8000;

  static RangeValues rangeValues = RangeValues(startPoint, endPoint);
}
