class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    # console.log(@busted())
    if @busted()
      @trigger 'bust', @

  stand: ->
  	# emmit an event to the app
  	@trigger 'stand', @

  busted: ->
    @scores()[0] > 21

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  playToWin: ->
    @first().flip()
    while @scores()[0] < 17
      @hit()
    if !@busted()
      @stand()

  maxScore: -> 
    score = @scores()
    if score[1] <= 21 then score[1] else score[0] 

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


