import AsyncStorage from '@react-native-async-storage/async-storage';

const FAVOURITES_KEY = '@localbite_favourite_dish_ids';

export async function getFavouriteDishIds(): Promise<string[]> {
  try {
    const raw = await AsyncStorage.getItem(FAVOURITES_KEY);
    if (!raw) return [];
    return JSON.parse(raw);
  } catch (err) {
    console.error('Error reading favourites:', err);
    return [];
  }
}

export async function toggleFavouriteDishId(dishId: string): Promise<boolean> {
  try {
    const current = await getFavouriteDishIds();
    let updated: string[];
    let isSaved: boolean;

    if (current.includes(dishId)) {
      updated = current.filter(id => id !== dishId);
      isSaved = false;
    } else {
      updated = [...current, dishId];
      isSaved = true;
    }

    await AsyncStorage.setItem(FAVOURITES_KEY, JSON.stringify(updated));
    return isSaved;
  } catch (err) {
    console.error('Error toggling favourite:', err);
    return false;
  }
}

export async function isDishFavourite(dishId: string): Promise<boolean> {
  const current = await getFavouriteDishIds();
  return current.includes(dishId);
}
