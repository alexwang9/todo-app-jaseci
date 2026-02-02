import from uuid { uuid4 }
cl import "./styles.css";

# A node is a persistent data container in the graph
node Todo {
    has id: str,
        title: str,
        done: bool = False;
}