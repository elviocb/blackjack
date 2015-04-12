class window.CardView extends Backbone.View
  className: 'card'
  tagName: 'div'
  
  template: _.template "<img src='./img/cards/<%= rankName %>-<%=suitName%>.png'/>"

  initialize: -> 
  	@render()

  render: ->
    @$el.children().detach()
    @$el.html (@template @model.attributes).toLowerCase()
    @$el.addClass 'covered' unless @model.get 'revealed'

