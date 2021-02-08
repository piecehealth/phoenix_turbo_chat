defmodule Chat.Rooms.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :name, :string
    has_many :messages, Chat.Rooms.Message

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
