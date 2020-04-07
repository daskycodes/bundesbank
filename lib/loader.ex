defmodule Bundesbank.Loader do
    @moduledoc false

    alias Bundesbank.Bank

    # load all banks from bundesbank.yml file with :yamerl and transform to to a collection of structs:
    # [%Bundesbank.Bank{bank_name: 'Deutsche Bank Fil Berlin', bic: 'DEUTDEBBXXX', change_code: 'U', ...},
    #   %Bundesbank.Bank{bank_name: 'DB PFK (Deutsche Bank PGK)', bic: 'DEUTDEDBBER', ...

    def load do
        data_path(["bundesbank.yml"])
        |>:yamerl.decode_file()
        |> List.first()
        |> Enum.map(fn bank -> Enum.into(bank, %{}) end)
        |> Enum.map(fn bank -> Map.new(bank, fn {k, v} -> {List.to_atom(k), v} end) end)
        |> Enum.map(fn bank -> struct(Bank, bank) end)
    end

    defp data_path(path) do
        Path.join([:code.priv_dir(:bundesbank), "data"] ++ path)
      end
end
