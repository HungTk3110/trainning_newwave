void main() {
  print(twoSum([3, 0, 2, 3], 6));
}

List<int> twoSum(List<int> nums, int target) {
  int len = nums.length;
  for (int i = 0; i < len - 1; i++) {
    for (int j = i + 1; j < len; j++) {
      if (nums[i] + nums[j] == target) {
        return [i, j];
      }
    }
  }
  return [];
}
