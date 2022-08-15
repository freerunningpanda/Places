import 'package:places/domain/sight.dart';

abstract class Mocks {
  static final List<Sight> mocks = [
  Sight(
    name: 'Фиолент',
    lat: 44.501394,
    lon: 33.489158,
    url: 'https://a.d-cd.net/72ee209s-960.jpg',
    details: 'Мыс на Гераклейском полуострове на юго-западном побережье Крыма',
    type: 'Природные объекты',
  ),
  Sight(
    name: 'Тарханкут',
    lat: 45.347618,
    lon: 32.494822,
    url:
        'https://tourpedia.ru/wp-content/uploads/2020/09/Тарханкут-линия-берега.jpg',
    details:
        'Мыс на западе Крыма, на одноимённом полуострове. В путеводителе Сосногоровой 1871 года мыс назван Экифороф.',
    type: 'Природные объекты',
  ),
  Sight(
    name: 'Симиланские острова',
    lat: 8.651096,
    lon: 97.646117,
    url:
        'https://chitatravel.ru/img/news/230-3643118d3bc6d05299aad01bdf6e8076.jpg',
    details:
        'Группа островов в Андаманском море в 70 км к западу от провинции Пхангнга, к которой они административно и относятся.',
    type: 'Природные объекты',
  ),
  Sight(
    name: 'Алупкинский парк',
    lat: 44.421780,
    lon: 34.058052,
    url:
        'https://www.rial-tour.ru/images/stories/virtuemart/product/Воронцовский%20парк%20_900x600.jpg',
    details:
        'Парк на территории Алупки. Памятник садово-паркового искусства, основан в первой половине XIX века под руководством немецкого садовника Карла Кебаха. Составляет единый ансамбль с Воронцовским дворцом.',
    type: 'Исторические объекты',
  ),
  Sight(
    name: 'Свято-Успенский мужской пещерный монастырь',
    lat: 44.744096,
    lon: 33.910369,
    url:
        'https://gur-gur.ru/mt-content/uploads/2019/09/uspenskiy-peshhernyy-monastyr.jpg',
    details:
        'Бахчисарайский Успе́нский пещерный монасты́рь — мужской монастырь Симферопольской епархии Украинской православной церкви, расположенный в урочище Мариам-Дере (Ущелье Марии) вблизи Бахчисарая.',
    type: 'Религиозные объекты',
  ),
];

}
