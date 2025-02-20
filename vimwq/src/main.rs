use gtk::prelude::*;
use gtk::{Application, ApplicationWindow, ScrolledWindow, TextView, Entry, Box, Orientation};
use glib::clone;
use std::process::Command;

fn main() {
    let app = Application::builder()
        .application_id("com.example.GtkConsole")
        .build();

    app.connect_activate(|app| {
        // Ventana principal
        let window = ApplicationWindow::builder()
            .application(app)
            .title("Consola GTK en Rust")
            .default_width(600)
            .default_height(400)
            .build();

        let container = Box::new(Orientation::Vertical, 5);

        // Área de salida tipo consola
        let text_view = TextView::new();
        text_view.set_editable(false);
        text_view.set_monospace(true);
        let buffer = text_view.buffer();
        
        let scroll = ScrolledWindow::new();
        scroll.set_vexpand(true);
        scroll.set_child(Some(&text_view));

        // Entrada de comandos
        let entry = Entry::new();
        entry.connect_activate(clone!(@weak buffer => move |entry| {
            let command = entry.text().to_string();
            entry.set_text("");
            
            if !command.is_empty() {
                let output = Command::new("cmd")
                    .args(["/C", &command])
                    .output();
                
                let result = match output {
                    Ok(output) => {
                        let stdout = String::from_utf8_lossy(&output.stdout);
                        let stderr = String::from_utf8_lossy(&output.stderr);
                        format!("$ {}\n{}{}\n", command, stdout, stderr)
                    }
                    Err(e) => format!("$ {}\nError: {}\n", command, e),
                };
                
                buffer.insert(&mut buffer.end_iter(), &result);
            }
        }));

        // Agregar widgets al contenedor
        container.append(&scroll);
        container.append(&entry);

        window.set_child(Some(&container));
        window.show();
    });

    app.run();
}
