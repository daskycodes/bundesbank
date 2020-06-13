defmodule Bundesbank.Bank do
  defstruct [
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
end
