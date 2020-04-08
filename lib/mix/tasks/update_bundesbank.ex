defmodule Mix.Tasks.UpdateBundesbank do
    use Mix.Task
  
    @shortdoc "fetches .xlsx file from www.bundesbank.de and overwrites old data.xlsx file"
    def run(_) do
        Application.ensure_all_started(:hackney)
        IO.puts("Pulling Data from https://www.bundesbank.de#{file_path()}")
        case HTTPoison.get("https://www.bundesbank.de#{file_path()}") do
            {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            IO.puts("Writing new Data to data.xlsx")
            File.write!(data_path(["data.xlsx"]), body)
        end
        IO.puts("Data Updated")
    end

    defp data_path(path) do
        Path.join([:code.priv_dir(:bundesbank), "data"] ++ path)
    end

    def file_path do
        case HTTPoison.get("https://www.bundesbank.de/de/aufgaben/unbarer-zahlungsverkehr/serviceangebot/bankleitzahlen/download-bankleitzahlen-602592") do
            {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            {:ok, html} = Floki.parse_document(body)
            Floki.find(html, "a.collection__link.linklist__link.linklist__link--blocklist")
            |> Floki.attribute("href")
            |> Enum.at(2)
        end
    end
end