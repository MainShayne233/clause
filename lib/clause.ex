defmodule Clause do
  require Logger

  @doc """
  Adds integers and only integers.

  ## Examples

      iex> Clause.integer_add(1, 2)
      {:ok, 3}

      iex> Clause.integer_add(1.0, 2)
      {:error, "LHS is invalid"}

      iex> Clause.integer_add(1, "2")
      {:error, "RHS is invalid"}
  """
  def integer_add(lhs, rhs) do
    with {:lhs, :ok} <- {:lhs, validate_integer(lhs)},
         {:rhs, :ok} <- {:rhs, validate_integer(rhs)} do
      {:ok, lhs + rhs}
    else
      error ->
        Logger.error("integer_add/2 failure")

        case error do
          {:lhs, _} ->
            {:error, "LHS is invalid"}

          {:rhs, _} ->
            {:error, "RHS is invalid"}
        end
    end
  end

  defp validate_integer(value) when is_integer(value), do: :ok
  defp validate_integer(value) when is_float(value), do: {:error, :float}
  defp validate_integer(_value), do: {:error, :NaN}
end
