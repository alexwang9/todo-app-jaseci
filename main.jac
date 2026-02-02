import from uuid { uuid4 }
cl import "./styles.css";

# A node is a persistent data container in the graph
node Todo {
    has id: str,
        title: str,
        done: bool = False;
}

"""Add a todo and return it."""
def:pub add_todo(title: str) -> dict {
    todo = root ++> Todo(id=str(uuid4()), title=title);
    return {"id": todo[0].id, "title": todo[0].title, "done": todo[0].done};
}

"""Get all todos."""
def:pub get_todos -> list {
    return [{"id": t.id, "title": t.title, "done": t.done} for t in [root-->](`?Todo)];
}

"""Toggle a todo's done status."""
def:pub toggle_todo(id: str) -> dict {
    for todo in [root-->](`?Todo) {
        if todo.id == id {
            todo.done = not todo.done;
            return {"id": todo.id, "title": todo.title, "done": todo.done};
        }
    }
    return {};
}

"""Delete a todo."""
def:pub delete_todo(id: str) -> dict {
    for todo in [root-->](`?Todo) {
        if todo.id == id {
            del todo;
            return {"deleted": id};
        }
    }
    return {};
}