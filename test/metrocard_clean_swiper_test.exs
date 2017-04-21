defmodule MetrocardCleanSwiperTest do
  use ExUnit.Case
  doctest MetrocardCleanSwiper

  test "returns a clean swipe if you add 2.75 exactly" do
    assert MetrocardCleanSwiper.get_clean_swipes(0, 2.75) == [0.0, 2.75]
  end

  test "considers starting with a card with some money" do
    assert MetrocardCleanSwiper.get_clean_swipes(2.75, 2.75) == [0.0, 2.75]
  end

  test "gets all values where you that can be added to get a clean swipe" do
    assert MetrocardCleanSwiper.get_clean_swipes(0, 80) == [0.0, 2.75, 20.95, 34.05, 41.90, 55.00, 75.95]
  end

  test "considers starting value of card" do
    assert MetrocardCleanSwiper.get_clean_swipes(100, 80) == [1.75, 4.5, 6.9, 20.0, 40.95, 54.05, 61.9, 75.0]
  end


  test "can get resulting balance" do
    assert MetrocardCleanSwiper.get_balance(0, 2.75) == 2.75
  end

  test "considers bonus when calculating balance" do
    assert MetrocardCleanSwiper.get_balance(0, 5.50) == 5.78
  end

  test "works with a starting balance" do
    assert MetrocardCleanSwiper.get_balance(1.00, 5.50) == 6.78
  end

  test "can get balance in cents" do
    assert MetrocardCleanSwiper.get_balance_in_cents(1.00, 5.50) == 678
  end

  test "knows if balance is a clean swipe" do
    assert MetrocardCleanSwiper.is_clean_swipe?(2.75)
    assert MetrocardCleanSwiper.is_clean_swipe?(5.50)
    refute MetrocardCleanSwiper.is_clean_swipe?(2.80)
  end
end
