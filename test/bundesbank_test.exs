defmodule BundesbankTest do
  use ExUnit.Case, async: true
  doctest Bundesbank

  describe "all/0" do
    test "get all banks" do
      countries = Bundesbank.all()
      assert Enum.count(countries) == 15947
    end
  end

  describe "exists?/2" do
    test "checks if bank exists" do
      refute Bundesbank.exists?(:city, "New York")
      assert Bundesbank.exists?(:city, "Berlin")
    end
  end

  describe "filter_by/2" do
    test "filter banks by bic" do
      bank = Bundesbank.filter_by(:bic, "SKPADEB1XXX")
      assert Enum.count(bank) == 1

      bank = Bundesbank.filter_by(:bic, "skpadeb1")
      assert Enum.count(bank) == 1
    end

    test "filter banks by city" do
      banks = Bundesbank.filter_by(:city, "Berlin")
      assert Enum.count(banks) == 96
    end

    test "filter banks by code" do
      bank = Bundesbank.filter_by(:code, "50010060")
      assert Enum.count(bank) == 1

      bank = Bundesbank.filter_by(:code, 50010060)
      assert Enum.count(bank) == 1
    end

    test "checks if banks exist" do
      banks_exist = Bundesbank.exists?(:city, "New York")
      assert banks_exist == false

      banks_exist = Bundesbank.exists?(:city, "Berlin")
      assert banks_exist == true
    end
  end
end
