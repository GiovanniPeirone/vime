package ui

import "github.com/rivo/tview"

func layout() *tview.Flex {

	header := header()

	layout := tview.NewFlex().SetDirection(tview.FlexRow).
		AddItem(header, 3, 1, false). // Header de 3 líneas
		AddItem(terminalConteiner, 0, 1, true)

	return layout
}
