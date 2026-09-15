import { NavigatorScreenParams } from '@react-navigation/native';

export type ExploreStackParamList = {
  ExploreHome: undefined;
  DishDetail: { dishId: string };
  LocationDetail: { locationId: string };
  SeasonalSearch: { season: string; regionId?: string };
};

export type SearchStackParamList = {
  SearchHome: undefined;
  DishDetail: { dishId: string };
  LocationDetail: { locationId: string };
  SeasonalSearch: { season: string; regionId?: string };
};

export type FavouritesStackParamList = {
  FavouritesHome: undefined;
  DishDetail: { dishId: string };
};

export type SettingsStackParamList = {
  SettingsHome: undefined;
};

export type RootTabParamList = {
  ExploreTab: NavigatorScreenParams<ExploreStackParamList>;
  SearchTab: NavigatorScreenParams<SearchStackParamList>;
  FavouritesTab: NavigatorScreenParams<FavouritesStackParamList>;
  SettingsTab: NavigatorScreenParams<SettingsStackParamList>;
};
