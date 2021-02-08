defmodule ChatWeb.MessageController do
  use ChatWeb, :controller

  alias Chat.Rooms
  alias Chat.Rooms.Message

  plug :set_room

  def new(conn, _params) do
    changeset = Rooms.change_message(%Message{room_id: conn.assigns.room.id})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"message" => message_params}) do
    room = conn.assigns.room
    message = Rooms.create_message!(Map.put(message_params, "room_id", room.id))

    if turbo_stream_request?(conn) do
      # render_turbo_stream(conn, "create_turbo_stream.html", message: message)

      ChatWeb.Endpoint.update_stream(
        room,
        ChatWeb.MessageView,
        "create_turbo_stream.html",
        message: message
      )

      send_resp(conn, 201, message.content)
    else
      redirect(conn, to: Routes.room_path(conn, :show, conn.assigns.room))
    end
  end

  defp set_room(conn, _) do
    room_id = conn.params["room_id"]
    room = Rooms.get_room!(room_id)
    assign(conn, :room, room)
  end
end
