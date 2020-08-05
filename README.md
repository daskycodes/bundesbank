# Bundesbank

[![Hex.pm](https://img.shields.io/hexpm/v/bundesbank.svg?maxAge=2592000)](https://hex.pm/packages/bundesbank) [![Hex Docs](https://img.shields.io/badge/hex-docs-9768d1.svg)](https://hexdocs.pm/bundesbank)

A collection of German Bank Data including BIC, Bankcodes, PAN and more useful information based on the [Bundesbank Data Set](https://www.bundesbank.de/de/aufgaben/unbarer-zahlungsverkehr/serviceangebot/bankleitzahlen/download-bankleitzahlen-602592)

**Current Data Set is Valid until September, 06th 2020**

## Installation

The package can be installed
by adding `bundesbank` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bundesbank, "~> 0.1.4"}
  ]
end
```

run `mix deps.get`

## Usage

Get all banks from the collection

```elixir
banks = Bundesbank.all
Enum.count(banks)
# 15947
```

Filter banks by a given key.

```elixir
[
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
```

```elixir
bank = Bundesbank.filter_by(:code, "20050000")
# [%Bundesbank.Bank{bank_name: "Hamburg Commercial Bank", bic: "HSHNDEHHXXX", change_code: "U", ...
banks = Bundesbank.filter_by(:city, "Berlin")
# [%Bundesbank.Bank{bank_name: "BBk Berlin", bic: "MARKDEF1100", change_code: "U", ...
Enum.count(banks)
# 96
```

## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am "Add some feature")
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request
