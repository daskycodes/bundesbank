defmodule BundesbankTest do
  use ExUnit.Case, async: true

  test "filter banks by bic" do
    bank = Bundesbank.filter_by(:bic, "SKPADEB1XXX")
    assert Enum.count(bank) == 1
  end

  test "filter banks by city" do
    banks = Bundesbank.filter_by(:city, "Berlin")
    assert Enum.count(banks) == 95
  end

  test "get all countries" do
    banks = Bundesbank.all()
    assert Enum.count(banks) == 16028
  end

  test "checks if banks exist" do
    banks_exist = Bundesbank.exists?(:city, "New York")
    assert banks_exist == false

    banks_exist = Bundesbank.exists?(:city, "Berlin")
    assert banks_exist == true
  end
end
