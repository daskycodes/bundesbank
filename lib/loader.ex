defmodule Bundesbank.Loader do
  @moduledoc false
  alias Bundesbank.Bank
  NimbleCSV.define(MyParser, separator: ",", escape: "\"")

  # load all banks from data.csv and transform to a collection of structs:
  # [%Bundesbank.Bank{bank_name: "Deutsche Bank Fil Berlin", bic: "DEUTDEBBXXX", change_code: "U", ...},
  #   %Bundesbank.Bank{bank_name: "DB PFK (Deutsche Bank PGK)", bic: "DEUTDEDBBER", ...

  def load do
    keywords = [
      :code,
      :property,
      :description,
      :postal_code,
      :city,
      :bank_name,
      :pan,
      :bic,
      :mark_of_conformity,
      :record_number,
      :change_code,
      :delete_code,
      :emulation_code
    ]

    data_path(["data.csv"])
    |> File.stream!()
    |> MyParser.parse_stream()
    |> Enum.map(fn bank -> Enum.zip(keywords, bank) end)
    |> Enum.map(fn bank -> struct(Bank, bank) end)
  end

  defp data_path(path) do
    Path.join([:code.priv_dir(:bundesbank), "data"] ++ path)
  end
end
