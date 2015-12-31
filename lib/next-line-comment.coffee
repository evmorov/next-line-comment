{CompositeDisposable} = require 'atom'

module.exports = NextLineComment =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'next-line-comment:toggle': => @toggle()

  deactivate: ->
    @subscriptions.dispose()

  toggle: ->
    editor = atom.workspace.getActiveTextEditor()
    position = editor.getCursorScreenPosition()

    editor.transact ->
      for selection in editor.selections
        selection.toggleLineComments()

    range = editor.getSelectedScreenRange()
    if !editor.hasMultipleCursors() and (range.start.row - range.end.row is 0)
      editor.setCursorScreenPosition position
      editor.moveDown()
