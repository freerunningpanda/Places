import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/utils/place_type.dart';
// import 'package:places/data/model/place.dart';

abstract class Mocks {
  static const mockLat = 55.988344;
  static const mockLot = 37.608042;

  static final List<String> types = [];

  static final List<Place> mocks = [
    Place(
      id: 0,
      lat: 55.911397,
      lng: 37.740033,
      name: 'Мытищинский парк',
      urls: ['https://pic.rutubelist.ru/video/39/09/390905576c021a02b5b57c374ba16621.jpg'],
      // url: 'lib/ui/res/images/no_image.png',
      placeType: PlaceType.park,
      description: 'Мытищинский парк — центральный парк в одноименном городе Московской области.',
    ),
    Place(
      id: 1,
      lat: 44.419881,
      lng: 34.055799,
      name: 'Воронцовский дворец',
      urls: ['https://core-pht-proxy.maps.yandex.ru/v1/photos/download?photo_id=deRmH1T9ukwAqPbuaHG6FQ&image_size=XXL'],
      // url: 'lib/ui/res/images/no_image.png',
      placeType: PlaceType.park,
      description:
          'Парк на территории Алупки. Памятник садово-паркового искусства, основан в первой половине XIX века под руководством немецкого садовника Карла Кебаха. Составляет единый ансамбль с Воронцовским дворцом.',
    ),
    Place(
      id: 2,
      lat: 55.911355,
      lng: 37.735425,
      name: 'Мытищинский историко-художественный музей',
      urls: ['https://4.bp.blogspot.com/-oC28TR8wg2o/Vo_q8SzKV5I/AAAAAAAAgkA/hKYSFV4vm1w/s1600/SAM_5605.jpg'],
      // url: 'lib/ui/res/images/no_image.png',
      placeType: PlaceType.museum,
      description: 'Центральный музей городского округа Мытищи. Открыт в 1962 году.',
    ),
    Place(
      id: 3,
      lat: 55.908155,
      lng: 37.730916,
      name: 'Папа Джонс',
      urls: ['https://avatars.mds.yandex.net/get-altay/4398559/2a00000181b14c1ff7099db35afff1bef259/XXXL'],
      // url: 'lib/ui/res/images/no_image.png',
      placeType: PlaceType.cafe,
      description:
          'Пиццерия. Предзаказ онлайн, оплата картой, еда навынос, средний счёт 600–1200 ₽, доставка еды. Цены: средние.',
    ),
    Place(
      id: 4,
      lat: 55.917942,
      lng: 37.725245,
      name: 'Якитория',
      urls: ['https://static.yakitoriya.ru/media/cache/60/15/60158655420e2922294478c35d86ba77.png'],
      // url: 'lib/ui/res/images/no_image.png',
      placeType: PlaceType.restaurant,
      description:
          'Летняя веранда, доставка еды, роллы филадельфия от 537 ₽, бесплатная доставка, оплата картой, доставка, Wi-Fi, еда навынос, детское меню, средний счёт от 1500 ₽, детская комната..',
    ),
    Place(
      id: 5,
      lat: 55.907089,
      lng: 37.718347,
      name: 'Lecco',
      urls: [
        'https://cf.bstatic.com/xdata/images/hotel/max1280x900/33106839.jpg?k=6b68980e0b040d0e675237bb26a2f08ce9cc2db5cf404ed965edc5c585240b37&o=&hp=1',
      ],
      // url: 'lib/ui/res/images/no_image.png',
      placeType: PlaceType.hotel,
      description:
          'Отель Lecco расположен в тихом жилом районе, менее чем в 3 км от центра Мытищ и всего в 40 минутах езды от аэропорта Шереметьево. Кроме того, в отеле работает оздоровительный центр и салон красоты.',
    ),
     Place(
      id: 6,
      lat: 55.903283,
      lng: 37.714688,
      name: '13-й микрорайон',
      urls: ['https://core-pht-proxy.maps.yandex.ru/v1/photos/download?photo_id=BavQsmxTMiOC0OpsXpM1Rg&image_size=XXXL'],
      // url: 'lib/ui/res/images/no_image.png',
      placeType: PlaceType.other,
      description: 'Ограничен улицей Сукромка, улицей Благовещенская, рекой Яуза',
    ),
  ];

  // static final List<Place> placesTovisit = [
  //   const Place(
  //     name: 'Мытищинский парк',
  //     lat: 55.911397,
  //     lot: 37.740033,
  //     url: 'https://pic.rutubelist.ru/video/39/09/390905576c021a02b5b57c374ba16621.jpg',
  //     // url: 'lib/ui/res/images/no_image.png',
  //     details: 'Мытищинский парк — центральный парк в одноименном городе Московской области.',
  //     type: AppString.park,
  //   ),
  //   const Place(
  //     name: 'Воронцовский дворец',
  //     lat: 44.419881,
  //     lot: 34.055799,
  //     url: 'https://core-pht-proxy.maps.yandex.ru/v1/photos/download?photo_id=deRmH1T9ukwAqPbuaHG6FQ&image_size=XXL',
  //     // url: 'lib/ui/res/images/no_image.png',
  //     details:
  //         'Парк на территории Алупки. Памятник садово-паркового искусства, основан в первой половине XIX века под руководством немецкого садовника Карла Кебаха. Составляет единый ансамбль с Воронцовским дворцом.',
  //     type: AppString.park,
  //   ),
  //   const Place(
  //     name: 'Мытищинский историко-художественный музей',
  //     lat: 55.911355,
  //     lot: 37.735425,
  //     url: 'https://4.bp.blogspot.com/-oC28TR8wg2o/Vo_q8SzKV5I/AAAAAAAAgkA/hKYSFV4vm1w/s1600/SAM_5605.jpg',
  //     // url: 'lib/ui/res/images/no_image.png',
  //     details: 'Центральный музей городского округа Мытищи. Открыт в 1962 году.',
  //     type: AppString.museum,
  //   ),
  //   const Place(
  //     name: 'Папа Джонс',
  //     lat: 55.908155,
  //     lot: 37.730916,
  //     url: 'https://avatars.mds.yandex.net/get-altay/4398559/2a00000181b14c1ff7099db35afff1bef259/XXXL',
  //     // url: 'lib/ui/res/images/no_image.png',
  //     details:
  //         'Пиццерия. Предзаказ онлайн, оплата картой, еда навынос, средний счёт 600–1200 ₽, доставка еды. Цены: средние.',
  //     type: AppString.cafe,
  //   ),
  //   const Place(
  //     name: 'Якитория',
  //     lat: 55.917942,
  //     lot: 37.725245,
  //     url: 'https://static.yakitoriya.ru/media/cache/60/15/60158655420e2922294478c35d86ba77.png',
  //     // url: 'lib/ui/res/images/no_image.png',
  //     details:
  //         'Летняя веранда, доставка еды, роллы филадельфия от 537 ₽, бесплатная доставка, оплата картой, доставка, Wi-Fi, еда навынос, детское меню, средний счёт от 1500 ₽, детская комната..',
  //     type: AppString.restaurant,
  //   ),
  //   const Place(
  //     name: 'Lecco',
  //     lat: 55.907089,
  //     lot: 37.718347,
  //     url: 'https://cf.bstatic.com/xdata/images/hotel/max1280x900/33106839.jpg?k=6b68980e0b040d0e675237bb26a2f08ce9cc2db5cf404ed965edc5c585240b37&o=&hp=1',
  //     // url: 'lib/ui/res/images/no_image.png',
  //     details:
  //         'Отель Lecco расположен в тихом жилом районе, менее чем в 3 км от центра Мытищ и всего в 40 минутах езды от аэропорта Шереметьево. Кроме того, в отеле работает оздоровительный центр и салон красоты.',
  //     type: AppString.hotel,
  //   ),
  //   const Place(
  //     name: '13-й микрорайон',
  //     lat: 55.903283,
  //     lot: 37.714688,
  //     url: 'https://core-pht-proxy.maps.yandex.ru/v1/photos/download?photo_id=BavQsmxTMiOC0OpsXpM1Rg&image_size=XXXL',
  //     // url: 'lib/ui/res/images/no_image.png',
  //     details: 'Ограничен улицей Сукромка, улицей Благовещенская, рекой Яуза',
  //     type: AppString.particularPlace,
  //   ),
  // ];

  // static final List<Place> visitedSights = [
  //   const Place(
  //     name: 'Мытищинский парк',
  //     lat: 55.911397,
  //     lot: 37.740033,
  //     url: 'https://pic.rutubelist.ru/video/39/09/390905576c021a02b5b57c374ba16621.jpg',
  //     // url: 'lib/ui/res/images/no_image.png',
  //     details: 'Мытищинский парк — центральный парк в одноименном городе Московской области.',
  //     type: AppString.park,
  //   ),
  //   const Place(
  //     name: 'Воронцовский дворец',
  //     lat: 44.419881,
  //     lot: 34.055799,
  //     url: 'https://core-pht-proxy.maps.yandex.ru/v1/photos/download?photo_id=deRmH1T9ukwAqPbuaHG6FQ&image_size=XXL',
  //     // url: 'lib/ui/res/images/no_image.png',
  //     details:
  //         'Парк на территории Алупки. Памятник садово-паркового искусства, основан в первой половине XIX века под руководством немецкого садовника Карла Кебаха. Составляет единый ансамбль с Воронцовским дворцом.',
  //     type: AppString.park,
  //   ),
  //   const Place(
  //     name: 'Мытищинский историко-художественный музей',
  //     lat: 55.911355,
  //     lot: 37.735425,
  //     url: 'https://4.bp.blogspot.com/-oC28TR8wg2o/Vo_q8SzKV5I/AAAAAAAAgkA/hKYSFV4vm1w/s1600/SAM_5605.jpg',
  //     // url: 'lib/ui/res/images/no_image.png',
  //     details: 'Центральный музей городского округа Мытищи. Открыт в 1962 году.',
  //     type: AppString.museum,
  //   ),
  //   const Place(
  //     name: 'Папа Джонс',
  //     lat: 55.908155,
  //     lot: 37.730916,
  //     url: 'https://avatars.mds.yandex.net/get-altay/4398559/2a00000181b14c1ff7099db35afff1bef259/XXXL',
  //     // url: 'lib/ui/res/images/no_image.png',
  //     details:
  //         'Пиццерия. Предзаказ онлайн, оплата картой, еда навынос, средний счёт 600–1200 ₽, доставка еды. Цены: средние.',
  //     type: AppString.cafe,
  //   ),
  //   const Place(
  //     name: 'Якитория',
  //     lat: 55.917942,
  //     lot: 37.725245,
  //     url: 'https://static.yakitoriya.ru/media/cache/60/15/60158655420e2922294478c35d86ba77.png',
  //     // url: 'lib/ui/res/images/no_image.png',
  //     details:
  //         'Летняя веранда, доставка еды, роллы филадельфия от 537 ₽, бесплатная доставка, оплата картой, доставка, Wi-Fi, еда навынос, детское меню, средний счёт от 1500 ₽, детская комната..',
  //     type: AppString.restaurant,
  //   ),
  //   const Place(
  //     name: 'Lecco',
  //     lat: 55.907089,
  //     lot: 37.718347,
  //     url: 'https://cf.bstatic.com/xdata/images/hotel/max1280x900/33106839.jpg?k=6b68980e0b040d0e675237bb26a2f08ce9cc2db5cf404ed965edc5c585240b37&o=&hp=1',
  //     // url: 'lib/ui/res/images/no_image.png',
  //     details:
  //         'Отель Lecco расположен в тихом жилом районе, менее чем в 3 км от центра Мытищ и всего в 40 минутах езды от аэропорта Шереметьево. Кроме того, в отеле работает оздоровительный центр и салон красоты.',
  //     type: AppString.hotel,
  //   ),
  //   const Place(
  //     name: '13-й микрорайон',
  //     lat: 55.903283,
  //     lot: 37.714688,
  //     url: 'https://core-pht-proxy.maps.yandex.ru/v1/photos/download?photo_id=BavQsmxTMiOC0OpsXpM1Rg&image_size=XXXL',
  //     // url: 'lib/ui/res/images/no_image.png',
  //     details: 'Ограничен улицей Сукромка, улицей Благовещенская, рекой Яуза',
  //     type: AppString.particularPlace,
  //   ),
  // ];

  static double startPoint = 2000;
  static double endPoint = 8000;

  static RangeValues rangeValues = RangeValues(startPoint, endPoint);
}
