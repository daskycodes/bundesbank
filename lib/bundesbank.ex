defmodule Bundesbank do
  @doc """
  Returns all banks.
  """
  def all do
    bundesbank()
  end

  @doc """
  Filters banks by given attribute.

  Returns a list of `Bundesbank.Bank` structs
  
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
    iex> Bundesbank.exists?(:name, "Berlin")
    true
  ```
  """
  def exists?(attribue, value) do
    filter_by(attribue, value) |> length > 0
  end

  # Load banks from xlsx file once on compile time

  Application.start(:excelion)

  @bundesbank Bundesbank.Loader.load()

  defp bundesbank do
    @bundesbank
  end
end
