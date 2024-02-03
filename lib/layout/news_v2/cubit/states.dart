abstract class NewsStateV2{}

class NewInitialStatesV2 extends NewsStateV2 {}

class BottomNavigationChange extends NewsStateV2{}

class BussinessLoadingState extends NewsStateV2{}

class NewsGetBusinessSuccessState extends NewsStateV2{}

class NewsGetBusinessErrorState extends NewsStateV2{
  final error;

  NewsGetBusinessErrorState(this.error);
}

class SportLoadingState extends NewsStateV2{}

class NewsGetSportSuccessState extends NewsStateV2{}

class NewsGetSportErrorState extends NewsStateV2{
  final error;

  NewsGetSportErrorState(this.error);
}

class ScienceLoadingState extends NewsStateV2{}

class NewsGetScienceSuccessState extends NewsStateV2{}

class NewsGetScienceErrorState extends NewsStateV2{
  final error;

  NewsGetScienceErrorState(this.error);
}
class SearchLoadingState extends NewsStateV2{}

class NewsGetSearchSuccessState extends NewsStateV2{}

class NewsGetSearchErrorState extends NewsStateV2{
  final error;

  NewsGetSearchErrorState(this.error);
}
class NewsClearSearchState extends NewsStateV2{}

