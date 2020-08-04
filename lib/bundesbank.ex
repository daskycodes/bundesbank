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
  Filters banks by given attribute.

  Returns a list of `Bundesbank.Bank` structs

  Possible attributes:
  ```
  [:code, :property, :description, :postal_code, :city, :bank_name, :pan, :bic, :mark_of_conformity, :record_number, :change_code, :delete_code, :emulation_code]
  ```

  ## Examples
   ```
    iex> Bundesbank.filter_by(:bic, "GENODED1KDB")
    [%Bundesbank.Bank{bank_name: "KD-Bank Berlin", bic: "GENODED1KDB", change_code: "U" ...
    iex> Bundesbank.filter_by(:city, "Berlin")
    [%Bundesbank.Bank{bank_name: "BBk Berlin", bic: "MARKDEF1100", change_code: "U", ...
    iex> Bundesbank.filter_by(:code, "20050000")
    [%Bundesbank.Bank{bank_name: "Hamburg Commercial Bank", bic: "HSHNDEHHXXX", change_code: "U", ...
  ```
  """
  def filter_by(attribute, value) do
    Enum.filter(bundesbank(), fn bank ->
      Map.get(bank, attribute) == value
    end)
  end

  @doc """
  Checks if a bank for specific attribute and value exists.

  Returns boolean

  ## Examples
  ```
    iex> Bundesbank.exists?(:city, "New York")
    false
    iex> Bundesbank.exists?(:city, "Berlin")
    true
  ```
  """
  def exists?(attribue, value) do
    filter_by(attribue, value) |> length > 0
  end

  # Load banks from csv file once on compile time

  @bundesbank Bundesbank.Loader.load()

  defp bundesbank do
    @bundesbank
  end
end
