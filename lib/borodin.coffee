BorodinView = require './borodin-view'
{CompositeDisposable} = require 'atom'

module.exports = Borodin =
  borodinView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @borodinView = new BorodinView(state.borodinViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @borodinView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'borodin:toggle': => @toggle()

    require('atom-package-deps').install('borodin').then =>
      console.log 'Loaded dependencies for Borodin'

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @borodinView.destroy()

  serialize: ->
    borodinViewState: @borodinView.serialize()

  toggle: ->
    console.log 'Borodin was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
