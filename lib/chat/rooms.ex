defmodule Chat.Rooms do
  import Ecto.Query, warn: false
  alias Chat.Repo

  alias Chat.Rooms.Message
  alias Chat.Rooms.Room

  def list_rooms do
    Repo.all(Room)
  end

  @doc """
  Gets a single room.

  Raises `Ecto.NoResultsError` if the Room does not exist.

  ## Examples

      iex> get_room!(123)
      %Room{}

      iex> get_room!(456)
      ** (Ecto.NoResultsError)

  """
  def get_room!(id), do: Repo.get!(Room, id)

  def create_room(attrs \\ %{}) do
    %Room{}
    |> Room.changeset(attrs)
    |> Repo.insert()
  end

  def create_message!(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert!()
  end

  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  def change_room(%Room{} = room, attrs \\ %{}) do
    Room.changeset(room, attrs)
  end

  def change_message(%Message{} = message, attrs \\ %{}) do
    Message.changeset(message, attrs)
  end
end
