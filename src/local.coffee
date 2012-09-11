((root, factory) ->
  if typeof exports is "object"    
    # Node.
    module.exports = factory('spine')
  else if typeof define is "function" and define.amd
    # AMD. Register as an anonymous module.
    define ['spine'], factory
  else
    # Browser globals
    root.Spine ?= {}
    root.Spine.Local = factory(root.Spine)
) this, (Spine) ->
  
  Spine.Model.Local =
    extended: ->
      @change @saveLocal
      @fetch @loadLocal

    saveLocal: ->
      result = JSON.stringify(@)
      localStorage[@className] = result

    loadLocal: ->
      result = localStorage[@className]
      @refresh(result or [], clear: true)
  
  Spine.Model.Local