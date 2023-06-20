defmodule FileConfig do
  def parse_file(file_path) do
    file = File.read!(file_path)
    content = to_string(file)
    parse_hcl(content)
  end

  defp parse_hcl(file) do
    HCLParser.parse(file)
  end
end
