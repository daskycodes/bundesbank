defmodule Bundesbank do
  @moduledoc ~S"""
  A collection of German Bank Data including BIC, Bankcodes, PAN and more useful information based on the [Bundesbank Data Set](https://www.bundesbank.de/de/aufgaben/unbarer-zahlungsverkehr/serviceangebot/bankleitzahlen/download-bankleitzahlen-602592)

  **Current Data Set is Valid until September, 06th 2020**
  """

  @doc """
  Returns all banks.
  """
  def all do
    bundesbank()
  end

  @doc """
  Returns one bank given its code
  ## Examples
      iex> %Bundesbank.Bank{bank_name: bank_name} = Bundesbank.get(50010060)
      iex> bank_name
      "Postbank Ndl Deutsche Bank"
  """

  def get(code) do
    [bank] = filter_by(:code, code)
    bank
  end

  @doc """
  Filters banks by given key.

  Returns a list of `Bundesbank.Bank` structs

  Possible keys:
  ```
  [:code, :property, :description, :postal_code, :city, :bank_name, :pan, :bic, :mark_of_conformity, :record_number, :change_code, :delete_code, :emulation_code]
  ```

  ## Examples
      iex> Bundesbank.filter_by(:bic, "GENODED1KDB")
      [%Bundesbank.Bank{bank_name: "KD-Bank Berlin", bic: "GENODED1KDB", change_code: "U", city: "Berlin", code: "10061006", delete_code: "0",  description: "Bank für Kirche und Diakonie - KD-Bank Gf Sonder-BLZ", emulation_code: "00000000", mark_of_conformity: "09", pan: "", postal_code: "10117", property: "1", record_number: "055270" }]
      iex> Bundesbank.filter_by(:code, "20050000")
      [%Bundesbank.Bank{bank_name: "Hamburg Commercial Bank", bic: "HSHNDEHHXXX", change_code: "U", city: "Hamburg", code: "20050000", delete_code: "0", description: "Hamburg Commercial Bank, ehemals HSH Nordbank Hamburg", emulation_code: "00000000", mark_of_conformity: "C5", pan: "52000", postal_code: "20095", property: "1", record_number: "011954"}]
      iex> Bundesbank.filter_by(:city, "Berlin") |> Enum.count()
      94
  """
  def filter_by(key, value) do
    Enum.filter(bundesbank(), fn bank ->
      Map.get(bank, key)
      |> normalize(value, key)
    end)
  end

  defp normalize(attribute, value, key),
    do: normalize(attribute, key) == normalize(value, key)

  defp normalize(value, key) when is_integer(value),
    do: value |> Integer.to_string() |> normalize(key)

  defp normalize(value, key) when is_binary(value) and key != :bic,
    do: value |> String.downcase() |> String.replace(~r/\s+/, "") |> String.pad_trailing(11, "x")

  defp normalize(value, key) when is_binary(value) and key == :bic,
    do: value |> String.downcase() |> String.replace(~r/\s+/, "") |> String.pad_trailing(11, "x")

  defp normalize(value, _), do: value

  @doc """
  Checks if a bank for specific key and value exists.

  Returns boolean

  ## Examples
      iex> Bundesbank.exists?(:city, "New York")
      false
      iex> Bundesbank.exists?(:city, "Berlin")
      true
  """
  def exists?(key, value) do
    filter_by(key, value) |> length > 0
  end

  # Load banks from csv file once on compile time

  @bundesbank Bundesbank.Loader.load()

  defp bundesbank do
    @bundesbank
  end
end
