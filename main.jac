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