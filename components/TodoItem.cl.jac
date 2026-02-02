"""Todo item component."""

def:pub TodoItem(todo: dict, onToggle: any, onDelete: any, onBreakDown: any, onToggleSubtask: any) -> any {
    hasSubtasks = todo.subtasks and todo.subtasks.length > 0;
    return
        <div className="todo-wrapper">
            <div className="todo-item">
                <input
                    type="checkbox"
                    checked={todo.completed}
                    onChange={lambda -> None { onToggle(todo.id); }}
                    className="todo-checkbox"
                />
                <div className="todo-content">
                    <div className="todo-header">
                        <span className={("todo-title-completed" if todo.completed else "todo-title")}>
                            {todo.title}
                        </span>
                        <div className="todo-badges">
                            {(
                                <span className={f"priority-badge priority-{todo.priority}"}>
                                    {todo.priority.upper()}
                                </span>
                            ) if todo.priority else None}
                            {(
                                <span className={f"effort-badge effort-{todo.effort}"}>
                                    {todo.effort}
                                </span>
                            ) if todo.effort else None}
                            {(
                                <span className="category-badge">{todo.category}</span>
                            ) if todo.category and todo.category != "other" else None}
                        </div>
                    </div>
                </div>
                <div className="todo-actions">
                    {(
                        None
                    ) if hasSubtasks else (
                        <button
                            onClick={lambda -> None { onBreakDown(todo.id); }}
                            className="btn-breakdown"
                            title="Break down into subtasks"
                        >
                            💡
                        </button>
                    )}
                    <button
                        onClick={lambda -> None { onDelete(todo.id); }}
                        className="todo-delete-btn"
                    >
                        ×
                    </button>
                </div>
            </div>
            {(
                <div className="subtasks-container">
                    {[
                        <div key={subtask.id} className="subtask-item">
                            <input
                                type="checkbox"
                                checked={subtask.completed}
                                onChange={lambda -> None { onToggleSubtask(todo.id, subtask.id); }}
                                className="subtask-checkbox"
                            />
                            <span className={("subtask-title-completed" if subtask.completed else "subtask-title")}>
                                {subtask.title}
                            </span>
                        </div>
                        for subtask in todo.subtasks
                    ]}
                </div>
            ) if hasSubtasks else None}
        </div>;
}