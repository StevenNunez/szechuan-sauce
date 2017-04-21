defmodule MetrocardCleanSwiper do
  @fare_in_cents 275

  def get_clean_swipes(starting_balance, max_addable_amount) do
    do_get_clean_swipes(max_addable_amount, starting_balance, max_addable_amount, [])
  end

  def get_balance(starting_balance, amount_to_add) when amount_to_add >= 5.50 do
    cents = convert_to_cents(amount_to_add) * 1.05
    amount_with_bonus = cents |> convert_to_dollars
    do_get_balance(starting_balance, amount_with_bonus)
  end

  def get_balance(starting_balance, amount_to_add) do
    do_get_balance(starting_balance, amount_to_add)
  end

  def get_balance_in_cents(starting_balance, amount_to_add) do
    get_balance(starting_balance, amount_to_add)
    |> convert_to_cents
  end
  
  def is_clean_swipe?(amount) do
    convert_to_cents(amount) |> rem(@fare_in_cents) == 0
  end

  defp do_get_clean_swipes(amount_left_to_add, _, _, acc) when amount_left_to_add < 0, do: acc
  defp do_get_clean_swipes(amount_left_to_add, starting_balance, max_amount, acc) do
    case get_balance(starting_balance, amount_left_to_add) |> is_clean_swipe? do
      true ->
        next_amount = ((amount_left_to_add |> convert_to_cents) - 5) |> convert_to_dollars
        do_get_clean_swipes(next_amount, starting_balance, max_amount, [amount_left_to_add | acc])
      false ->
        next_amount = ((amount_left_to_add |> convert_to_cents) - 5) |> convert_to_dollars
        do_get_clean_swipes(next_amount, starting_balance, max_amount, acc)
    end
  end

  defp convert_to_cents(amount), do: amount * 100 |> round
  defp convert_to_dollars(amount), do: amount / 100 
  defp do_get_balance(starting_balance, amount_to_add) do
    convert_to_cents(starting_balance) + convert_to_cents(amount_to_add)
    |> convert_to_dollars
  end
end
