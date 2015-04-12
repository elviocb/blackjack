# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model


  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    # IF some EVENT happens to the USER, invoke playerEvents
    @get('playerHand').on 'all', @playerEvents, @
    # IF some EVENT happens to the DEALER, invoke dealerEvents
    @get('dealerHand').on 'all', @dealerEvents, @

  playerEvents: (event, hand) ->
    switch event
      when 'bust'  then @trigger 'dealer-wins'
      when 'stand' then @get('dealerHand').playToWin()

  dealerEvents: (event, hand) ->
    switch event
      when 'bust'  then @trigger 'player-wins'
      when 'stand' then @compareScores()
  
  compareScores: ->
    if @get('playerHand').maxScore() > @get('dealerHand').maxScore()
      console.log('this (playerHand)', this)
      @trigger 'player-wins'
    else if @get('dealerHand').maxScore() > @get('playerHand').maxScore()
      console.log('this (dealerHand)', this)
      @trigger 'dealer-wins'
    else
      @trigger 'push'

 
    

  
