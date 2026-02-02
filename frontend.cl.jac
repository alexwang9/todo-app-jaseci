"""Todo App - Client-Side UI."""

import from "@jac/runtime" { jacSignup, jacLogin, jacLogout, jacIsLoggedIn }

import "./styles.css";

import from .components.TodoItem { TodoItem }
import from .components.AuthForm { AuthForm }
import from .components.IngredientItem { IngredientItem }

sv import from main {
    AddTodo, ListTodos, ToggleTodo, DeleteTodo,
    GenerateShoppingList, ListMealPlan, ClearMealPlan
}

def:pub app -> any {
    has isLoggedIn: bool = False,
        checkingAuth: bool = True,
        isSignup: bool = False,
        username: str = "",
        password: str = "",
        error: str = "",
        loading: bool = False,
        todos: list = [],
        newTodoText: str = "",
        todosLoading: bool = True,
        mealInput: str = "",
        ingredients: list = [],
        ingredientsLoading: bool = False;

    can with entry {
        isLoggedIn = jacIsLoggedIn();
        checkingAuth = False;
    }

    can with [isLoggedIn] entry {
        if isLoggedIn {
            fetchTodos();
            fetchMealPlan();
        }
    }

    # Method declarations -- bodies are in frontend.impl.jac
    async def fetchTodos -> None;
    async def addTodo -> None;
    async def toggleTodo(todoId: str) -> None;
    async def deleteTodo(todoId: str) -> None;
    async def handleLogin -> None;
    async def handleSignup -> None;
    def handleLogout -> None;
    async def handleSubmit(e: any) -> None;
    def handleTodoKeyPress(e: any) -> None;
    async def fetchMealPlan -> None;
    async def generateIngredients -> None;
    async def clearIngredients -> None;
    def handleMealKeyPress(e: any) -> None;
    def getIngredientsTotal -> float;

    # ... UI rendering follows ...
}