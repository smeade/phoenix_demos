defmodule DemoWeb.TodoControllerTest do
  use DemoWeb.ConnCase

  alias Demo.Todos

  @create_attrs %{completed: true, due_date: ~D[2010-04-17], name: "some name", notes: "some notes"}
  @update_attrs %{completed: false, due_date: ~D[2011-05-18], name: "some updated name", notes: "some updated notes"}
  @invalid_attrs %{completed: nil, due_date: nil, name: nil, notes: nil}

  def fixture(:todo) do
    {:ok, todo} = Todos.create_todo(@create_attrs)
    todo
  end

  describe "index" do
    test "lists all todos", %{conn: conn} do
      conn = get(conn, Routes.todo_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Todos"
    end
  end

  describe "new todo" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.todo_path(conn, :new))
      assert html_response(conn, 200) =~ "New Todo"
    end
  end

  describe "create todo" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.todo_path(conn, :create), todo: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.todo_path(conn, :show, id)

      conn = get(conn, Routes.todo_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Todo"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.todo_path(conn, :create), todo: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Todo"
    end
  end

  describe "edit todo" do
    setup [:create_todo]

    test "renders form for editing chosen todo", %{conn: conn, todo: todo} do
      conn = get(conn, Routes.todo_path(conn, :edit, todo))
      assert html_response(conn, 200) =~ "Edit Todo"
    end
  end

  describe "update todo" do
    setup [:create_todo]

    test "redirects when data is valid", %{conn: conn, todo: todo} do
      conn = put(conn, Routes.todo_path(conn, :update, todo), todo: @update_attrs)
      assert redirected_to(conn) == Routes.todo_path(conn, :show, todo)

      conn = get(conn, Routes.todo_path(conn, :show, todo))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, todo: todo} do
      conn = put(conn, Routes.todo_path(conn, :update, todo), todo: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Todo"
    end
  end

  describe "delete todo" do
    setup [:create_todo]

    test "deletes chosen todo", %{conn: conn, todo: todo} do
      conn = delete(conn, Routes.todo_path(conn, :delete, todo))
      assert redirected_to(conn) == Routes.todo_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.todo_path(conn, :show, todo))
      end
    end
  end

  defp create_todo(_) do
    todo = fixture(:todo)
    {:ok, todo: todo}
  end
end
