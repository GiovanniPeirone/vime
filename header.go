package ui

import "github.com/rivo/tview"

func header() *tview.TextView {
	header := tview.NewTextView().SetText(" Encabezado").SetTextAlign(tview.AlignCenter)
	return header
}
