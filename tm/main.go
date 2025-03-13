package main

import (
	"fmt"

	"github.com/rivo/tview"
)

func main() {
	app := tview.NewApplication()

	// Crear un cuadro de texto
	textView := tview.NewTextView().
		SetText("¡Bienvenido a la TUI en Go!").
		SetTextAlign(tview.AlignCenter).
		SetDynamicColors(true)

	// Crear un menú interactivo
	list := tview.NewList().
		AddItem("Opción 1", "Descripción de la opción 1", '1', func() {
			textView.SetText("[green]Seleccionaste Opción 1!")
		}).
		AddItem("Opción 2", "Descripción de la opción 2", '2', func() {
			textView.SetText("[blue]Seleccionaste Opción 2!")
		}).
		AddItem("Salir", "Cerrar la aplicación", 'q', func() {
			app.Stop()
		})

	// Crear un diseño de página
	flex := tview.NewFlex().
		SetDirection(tview.FlexRow).
		AddItem(textView, 3, 1, false).
		AddItem(list, 0, 1, true)

	// Iniciar la app
	if err := app.SetRoot(flex, true).Run(); err != nil {
		fmt.Println(err)
	}
}
