defmodule EtsStore do
  @table_id __MODULE__

  def init do
    :ets.new(@table_id, [:public, :named_table])
  end

  def insert(key, value) do
    :ets.insert(@table_id, {key, value})
  end

  def get(key) do
    case :ets.lookup(@table_id, key) do
      [{_key, value}]  -> {:ok, value}
      []               -> {:error, :not_found}
    end
  end

  def delete(key) do
    :ets.match_delete(@table_id, {key, :_})
  end

end
