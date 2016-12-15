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
end
