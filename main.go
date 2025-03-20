package main

import (
	"github.com/rivo/tview"
)

func main() {
	app := tview.NewApplication()

	header := tview.NewTextView().SetText(" Encabezado").SetTextAlign(tview.AlignCenter)

	terminalConteiner := tview.NewGrid().SetTitle("Terminals").SetBorder(true)

	layout := tview.NewFlex().SetDirection(tview.FlexRow).
		AddItem(header, 3, 1, false). // Header de 3 líneas
		AddItem(terminalConteiner, 0, 1, true)

	// Ahora el root es un Flex que contiene 2 elementos
	if err := app.SetRoot(layout, true).Run(); err != nil {
		panic(err)
	}
}
