defmodule Demo.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :name, :string
      add :notes, :text
      add :due_date, :date
      add :completed, :boolean, default: false, null: false

      timestamps()
    end

  end
end
