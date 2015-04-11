class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
  	# checks whether the user is able to hit or not
    if @scores()[0] < 21
    	@add(@deck.pop())
    # checks if the user didn't padd the score's limit(21), otherwise the user lost 
    if @scores()[0] > 21
    	alert('You lost')
    # if score is equal 21, then it's dealer's turn
    if @scores()[0] == 21
    	console.log("Dealer's turn")

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


