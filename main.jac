"""TaskFlow - A multi-user todo app with AI meal planning."""

cl {
    import from frontend { app as ClientApp }

    def:pub app -> any {
        return
            <ClientApp />;
    }
}

import from byllm.lib { Model }
import from uuid { uuid4 }

glob llm = Model(model_name="claude-sonnet-4-20250514");

node Todo {
    has id: str,
        title: str,
        completed: bool = False,
        category: str = "other";
}

node MealIngredient {
    has name: str,
        quantity: float,
        unit: str,
        cost: float,
        carby: bool;
}

enum Category { WORK, PERSONAL, SHOPPING, HEALTH, OTHER }

enum Unit { PIECE, LB, OZ, CUP, TBSP, TSP, CLOVE, BUNCH }

obj Ingredient {
    has name: str;
    has quantity: float;
    has unit: Unit;
    has cost: float;
    has carby: bool;
}

sem Ingredient.cost = "Estimated cost in USD";
sem Ingredient.carby = "True if this ingredient is high in carbohydrates";

"""Categorize a todo based on its title."""
def categorize(title: str) -> Category by llm();

"""Generate a shopping list of ingredients needed for a described meal."""
def generate_ingredients(meal_description: str) -> list[Ingredient] by llm();

walker:priv AddTodo {
    has title: str;

    can create with `root entry {
        category = str(categorize(self.title)).split(".")[-1].lower();
        new_todo = here ++> Todo(
            id=str(uuid4()),
            title=self.title,
            category=category
        );
        report {
            "id": new_todo[0].id,
            "title": new_todo[0].title,
            "completed": new_todo[0].completed,
            "category": new_todo[0].category
        };
    }
}

walker:priv ListTodos {
    has todos: list = [];

    can collect with `root entry {
        visit [-->];
    }

    can gather with Todo entry {
        self.todos.append({
            "id": here.id,
            "title": here.title,
            "completed": here.completed,
            "category": here.category
        });
    }

    can report_all with `root exit {
        report self.todos;
    }
}

walker:priv ToggleTodo {
    has todo_id: str;

    can search with `root entry { visit [-->]; }

    can toggle with Todo entry {
        if here.id == self.todo_id {
            here.completed = not here.completed;
            report {"id": here.id, "completed": here.completed};
        }
    }
}

walker:priv DeleteTodo {
    has todo_id: str;

    can search with `root entry { visit [-->]; }

    can delete with Todo entry {
        if here.id == self.todo_id {
            del here;
            report {"deleted": self.todo_id};
        }
    }
}