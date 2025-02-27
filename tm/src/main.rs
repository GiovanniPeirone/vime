use std::io;
use crossterm::{
    event::{self, KeyCode},
    execute,
    terminal::{disable_raw_mode, enable_raw_mode, EnterAlternateScreen, LeaveAlternateScreen},
};
use tui::{
    backend::CrosstermBackend,
    widgets::{Block, Borders},
    layout::{Layout, Constraint, Direction},
    Terminal,
};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // Configurar terminal
    enable_raw_mode()?;
    let mut stdout = io::stdout();
    execute!(stdout, EnterAlternateScreen)?;
    let backend = CrosstermBackend::new(stdout);
    let mut terminal = Terminal::new(backend)?;

    // Dibujar interfaz
    terminal.draw(|frame| {
        let size = frame.size();
        let block = Block::default().title("Hola, TUI!").borders(Borders::ALL);
        frame.render_widget(block, size);
    })?;

    // Esperar a que el usuario presione una tecla para salir
    loop {
        if let event::Evet::Key(key) = event::read()? {
            if key.code == KeyCode::Char('q') {
                break;
            }
        }

    }

    

    // Restaurar terminal
    disable_raw_mode()?;
    execute!(terminal.backend_mut(), LeaveAlternateScreen)?;

    Ok(())
}