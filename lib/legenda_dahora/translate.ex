defmodule LegendaDahora.Translate do

  @yandex Application.get_env(:legenda_dahora, :yandex)

  def translate_yandex(from, to, text) do
    options = [params: [{:key, @yandex[:key]}, {:lang, "#{from}-#{to}"}, {:text, text}]]
    HTTPoison.start()
    case HTTPoison.get(@yandex[:url], [], options) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.Parser.parse!(body, keys: :atoms!).text |> hd()
      _ -> :error
    end
  end

  def translate_subtitle(file) do
    {:ok, subtitle} = Parsex.Subtitle.parse_file(file)
    start = System.monotonic_time(:milliseconds)

    ParallelStream.map(subtitle.lines, fn(line) ->
      Map.put(line, :text, ParallelStream.map(line.text, fn(text) ->
        translate_yandex("pt", "en", text)
      end)
      |> Enum.into([]))
    end, [num_workers: 60])
    |> Enum.into([])
        finish = System.monotonic_time(:milliseconds)
    finish-start

  end
end
