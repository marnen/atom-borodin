AtomBorodinView = require './atom-borodin-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomBorodin =
  atomBorodinView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomBorodinView = new AtomBorodinView(state.atomBorodinViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomBorodinView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-borodin:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomBorodinView.destroy()

  serialize: ->
    atomBorodinViewState: @atomBorodinView.serialize()

  toggle: ->
    console.log 'AtomBorodin was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
