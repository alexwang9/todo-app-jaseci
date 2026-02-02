"""Authentication form component."""

def:pub AuthForm(
    isSignup: bool, username: str, password: str,
    error: str, loading: bool,
    onUsernameChange: any, onPasswordChange: any,
    onSubmit: any, onToggleMode: any
) -> any {
    return
        <div className="auth-container">
            <div className="auth-card">
                <h1 className="auth-title">TaskFlow</h1>
                {(<div className="auth-error">{error}</div>) if error else None}
                <form onSubmit={onSubmit}>
                    {"... username input, password input, submit button ..."}
                </form>
                <button onClick={onToggleMode}>
                    {("Sign In" if isSignup else "Sign Up")}
                </button>
            </div>
        </div>;
}