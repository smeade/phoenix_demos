defmodule Demo.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :completed, :boolean, default: false
    field :due_date, :date
    field :name, :string
    field :notes, :string

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:name, :notes, :due_date, :completed])
    |> validate_required([:name, :notes, :due_date, :completed])
  end
end
